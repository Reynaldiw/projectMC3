//
//  EditAudioVC.swift
//  ProjectPodcastMC3
//
//  Created by Reynaldi Wijaya on 12/08/20.
//  Copyright © 2020 Reynaldi Wijaya. All rights reserved.
//

import UIKit
import AVFoundation

class EditAudioVC: UIViewController {
    
    @IBOutlet weak var sliderView: UISlider!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var timeLengthOfAudio: UILabel!
    @IBOutlet weak var addSegmentPressed: UIButton!
    @IBOutlet weak var segmentCollectionView: UICollectionView!
    @IBOutlet weak var stackInfoSegmentView: UIStackView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var textField: UITextField!
    
    var editAudioView: EditAudioView { return self.view as! EditAudioView }
    var customSheetView: CustomActionSheet = CustomActionSheet()
    
    var player: AVPlayer?
    
    var isPlaying = false
    
    var urlAudio: URL? {
        didSet {
            preparePlayer()
        }
    }
    
    var duration: Int?
    
    var segmentModels = [SegmentModel]()
    
    var callback: (([SegmentModel]) -> Void)?
    
    var selectedRow: Int = 0
    
    override func loadView() {
        self.view = EditAudioView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationController()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initInterfaceComponent()
        registerCell()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if player?.rate != 0 {
            player?.pause()
        }
        player = nil
    }
    
    @objc private func progressValueChanged(_ sender: UISlider) {
        guard let player = player else { return }
        
        if let duration = player.currentItem?.duration {
            let totalSeconds = CMTimeGetSeconds(duration)
            
            let value = Float64(sender.value) * totalSeconds
            
            let seekTime = CMTime(value: Int64(value), timescale: 1)
                            
            player.seek(to: seekTime) { (compltedSeek) in
                // Perhaps do something later
            }
        }
    }
    
    private func preparePlayer() {
        guard let safeURLAudio = urlAudio else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = AVPlayer(url: safeURLAudio)
            guard let player = player else { return }
            
            let interval = CMTime(value: 1, timescale: 2)
            player.addPeriodicTimeObserver(forInterval: interval, queue: .main) { (progressTime) in
                
                let seconds = CMTimeGetSeconds(progressTime)
                let secondsString = String(format: "%02d", Int(seconds) % 60)
                let minutesString = String(format: "%02d", Int(seconds / 60))
                
                self.timeLengthOfAudio.text = "\(minutesString):\(secondsString)"
                
                if let duration = self.player?.currentItem?.duration {
                    let durationSeconds = CMTimeGetSeconds(duration)
                    
                    self.sliderView.value = Float(seconds / durationSeconds)
                }
            }
            
            NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: .AVPlayerItemDidPlayToEndTime, object: nil)
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @objc private func playerDidFinishPlaying() {
           changeBGPlayPauseButton(isPlaying: isPlaying, playPauseButton: playPauseButton)
           isPlaying = false
       }
    
    @objc private func addSegmentButtonPressed(_ sender: UIButton) {
        EditAudioWireframe.performToAddSegment(durationInSeconds: duration ,caller: self) { (segmentModel) in
            self.segmentModels.append(segmentModel)
            self.stackInfoSegmentView.isHidden = true
            self.segmentCollectionView.isHidden = false
            self.segmentCollectionView.reloadData()
        }
    }
    
    @objc private func buttonInfoPressed(_ sender: Any) {
           createAlertAndShowAlert(title: "How to edit your audio", message: "this sound will be added to your audio", actionName: "Ok, Got it!", caller: self) { (action) in
            }
    }
       
    @objc private func playPauseButtonPressed(_ sender: Any) {
        guard let player = player else { return }
        
        if player.rate == 0 {
            changeBGPlayPauseButton(isPlaying: isPlaying, playPauseButton: playPauseButton)
            isPlaying = true
            player.play()
        } else {
            changeBGPlayPauseButton(isPlaying: isPlaying, playPauseButton: playPauseButton)
            isPlaying = false
            player.pause()
        }
    }
    
    @objc func doneButtonPressed(_ sender: Any) {
        if segmentModels.count == 0 {
            createAlertAndShowAlert(title: "Warning", message: "Create a segment First", actionName: "Cancel", caller: self, handler: nil)
            return
        }
        
        if player?.rate != 0 {
            player?.pause()
        }
                
        guard let urlAudio = urlAudio else { return }

        var resultSegmets = [SegmentModel]()
        
        self.editAudioView.showLoading()
        editAudioView.loadingCustomView.messageLabel.text = "Please wait, Rendering.. Do Not leave the screen"
        self.navigationItem.hidesBackButton = true
        
        DispatchQueue.global(qos: .background).async {
            // Donwload The SOurce of Audio
            EditAudioRepository.checkBookFileExists(withLink: urlAudio.absoluteString, completion: { (downloadedURL) in

                print("URL Of source: \(downloadedURL.absoluteString)")
                print("Donwload Complete")

                for i in 0..<self.segmentModels.count {

                    let segmentModel = self.segmentModels[i]

                    if let startTime = segmentModel.startTimeSeconds, let endTime = segmentModel.endTimeSeconds {

                        let rangeTime = RangeTime(startTime: startTime, endTime: endTime)
                        
                        let outputName = "\(segmentModel.nameSegment ?? "Segment") \(EditAudioRepository.getNumberForFileManager())"

                        print("Start to Trim")

                        EditAudioRepository.trimAudio(
                            urlAudio: downloadedURL,
                            rangeTime: rangeTime,
                            outputFileName: "\(outputName)",
                            successEditAudio: { (url) in

                                print("Success to trim")

                                let model = SegmentModel(nameSegment: segmentModel.nameSegment, startTimeSeconds: segmentModel.startTimeSeconds, endTimeSeconds: segmentModel.endTimeSeconds, urlSegment: url, urlAdditionalAudio: segmentModel.urlAdditionalAudio, durationAdditionalAudio: segmentModel.durationAdditionalAudio, typeSegment: segmentModel.typeSegment)
                                resultSegmets.append(model)

                        }) { (message) in
                            DispatchQueue.main.async {
                                self.editAudioView.removeLoading()
                                createAlertAndShowAlert(title: "Warning", message: "Cant trim audio", actionName: "Cancel", caller: self, handler: nil)
                                self.navigationItem.hidesBackButton = false
                                print(message)
                            }
                            return
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.editAudioView.removeLoading()
                            createAlertAndShowAlert(title: "Warning", message: "Error, Doesnt have a range time", actionName: "Cancel", caller: self, handler: nil)
                            self.navigationItem.hidesBackButton = false
                        }
                        return
                    }
                }
            }) { (message) in
                DispatchQueue.main.async {
                    self.editAudioView.removeLoading()
                    createAlertAndShowAlert(title: "ERROR", message: "Cant Rendering Segment", actionName: "Okay!", caller: self, handler: nil)
                    self.navigationItem.hidesBackButton = false
                }
                return
            }

            for _ in 0... {
                if self.segmentModels.count == resultSegmets.count {

                    DispatchQueue.main.async {
                        self.editAudioView.removeLoading()
                        self.callback?(resultSegmets)
                        print("Total: \(resultSegmets)")
                        self.navigationController?.popViewController(animated: true)
                    }
                    return

                } else {
                    continue
                }
            }
        }
    }
    
    @objc func moreButtonPressed(_ sender: Any) {
        print("More Button Pressed")
    }
}

extension EditAudioVC {
    
    private func showCustomSheet() {
        UIView.animate(withDuration: 0.7, delay: 0.3, options: .curveEaseIn, animations: {
            self.editAudioView.addSubview(self.customSheetView)
            self.customSheetView.anchor(top: self.editAudioView.topAnchor, bottom: self.editAudioView.bottomAnchor, leading: self.editAudioView.leadingAnchor, trailing: self.editAudioView.trailingAnchor, marginTop: 0, marginBottom: 0, marginLeading: 0, marginTrailing: 0, width: 0, height: 0, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        })
        customSheetView.cancelButton.addTarget(self, action: #selector(cancelTapped(_:)), for: .touchUpInside)
        customSheetView.stackDeleteView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(deleteTapped)))
        customSheetView.stackRenameView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(renameTapped)))
    }
    
    private func removeCustomSheet() {
        UIView.animate(withDuration: 0.7, delay: 0.3, options: .curveEaseIn, animations: {
            self.customSheetView.removeFromSuperview()
        })
    }
    
    @objc private func cancelTapped(_ sender: Any) {
        removeCustomSheet()
    }
    
    @objc private func deleteTapped() {
        removeCustomSheet()
        segmentModels.remove(at: selectedRow)
        self.segmentCollectionView.reloadData()
        if segmentModels.count == 0 {
            self.segmentCollectionView.isHidden = true
            self.stackInfoSegmentView.isHidden = false
        }
    }
    
    @objc private func renameTapped() {
        removeCustomSheet()
        createActionSheetWithTextField(title: "Rename Segment", message: nil, caller: self) { (userInput) in
            self.segmentModels[self.selectedRow].nameSegment = userInput
            self.segmentCollectionView.reloadData()
        }
    }
    
    @objc private func editTapped() {
        removeCustomSheet()
    }
}

extension EditAudioVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return segmentModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.KEY_SEGMENT_CELL, for: indexPath) as! SegmentCell
        
        var nameSegment = ""
        
        var segmentModel = segmentModels[indexPath.row]
        
        if segmentModel.nameSegment == "" || segmentModel.nameSegment == nil {
            nameSegment = "Segment \(indexPath.row + 1)"
        } else {
            nameSegment = segmentModel.nameSegment!
        }
        segmentModel.nameSegment = nameSegment
        
        segmentModels[indexPath.row] = segmentModel
        
        cell.segmentModel = segmentModel
                
        cell.playButton.isHidden = true
        cell.stackVerticalView.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 15).isActive = true
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let contentViewSize = contentView.bounds
        
        return CGSize(width: contentViewSize.width - 30, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedRow = indexPath.row
        showCustomSheet()
    }
}

extension EditAudioVC {
    private func initInterfaceComponent() {
        sliderView = editAudioView.slider
        sliderView.setThumbImage(UIImage(named: "Triangle"), for: .normal)
        sliderView.tintColor = Colors.BG_PROGRESS_SLIDER_COLOR
        sliderView.maximumTrackTintColor = Colors.GRAY_COLOR
        sliderView.addTarget(self, action: #selector(progressValueChanged(_:)), for: .valueChanged)
        
        playPauseButton = editAudioView.playPauseButton
        playPauseButton.addTarget(self, action: #selector(playPauseButtonPressed(_:)), for: .touchUpInside)
        
        addSegmentPressed = editAudioView.addSegmentButton
        addSegmentPressed.addTarget(self, action: #selector(addSegmentButtonPressed(_:)), for: .touchUpInside)
        
        timeLengthOfAudio = editAudioView.timeLengthOfAudio
        
        segmentCollectionView = editAudioView.segmentCV
        segmentCollectionView.delegate = self
        segmentCollectionView.dataSource = self
        
        stackInfoSegmentView = editAudioView.stackInfoSegmentView
        contentView = editAudioView.view
        
        doneButton = editAudioView.doneButton
        doneButton.addTarget(self, action: #selector(doneButtonPressed(_:)), for: .touchUpInside)
    }
    
    private func registerCell() {
        segmentCollectionView.register(SegmentCell.self, forCellWithReuseIdentifier: Constants.KEY_SEGMENT_CELL)
    }
    
    private func setupNavigationController() {
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        title = "Edit Audio"
        
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.isTranslucent = true
        
        let infoButton = UIBarButtonItem(image: UIImage(named: "info"), style: .plain, target: self, action: #selector(buttonInfoPressed(_:)))
        self.navigationItem.rightBarButtonItem = infoButton
    }
}
