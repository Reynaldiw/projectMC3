//
//  PreviewAudioVC.swift
//  ProjectPodcastMC3
//
//  Created by Reynaldi Wijaya on 07/08/20.
//  Copyright © 2020 Reynaldi Wijaya. All rights reserved.
//

import UIKit
import AVFoundation

class PreviewAudioVC: UIViewController {
    
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var lengthOfAudioLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var editLabel: UILabel!
    @IBOutlet weak var audioButton: UIButton!
    @IBOutlet weak var audioLabel: UILabel!
    @IBOutlet weak var segmentCollectionView: UICollectionView!
    
    @IBOutlet weak var playCellButton: UIButton!

    var previewAudioView: PreviewAudioView { self.view as! PreviewAudioView }
    var customSheetView: CustomActionSheet = CustomActionSheet()
    var loadingCustomView: CustomLoadingView = CustomLoadingView()
    
    var designReadyDelegate: designReadyDelegate!

    var player: AVPlayer!
    var isPlaying = false
    var audioPlayer: AVAudioPlayer!
    var isAudioLocalPlaying = false
    
    var urlAudio: URL? {
        didSet {
            preparePlayer(url: urlAudio)
        }
    }
    
    var urlLocalAudio: URL? {
        didSet {
            prepareAudioPlayer(url: urlLocalAudio)
        }
    }
    
    var durationSeconds: Int?
    
    var segmentModels = [SegmentModel]()
    
    var selectedItem: Int = 0
    var indexPath: IndexPath?
    
    override func loadView() {
        self.view = PreviewAudioView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        initInterfaceComponent()
        
        if let durationSeconds = durationSeconds {
            let (_,m,s) = secondsToHoursMinutesSeconds(seconds: durationSeconds)
            lengthOfAudioLabel.text = "\(m):\(s)"
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if let player = player {
            if player.rate != 0 {
                player.pause()
                self.player = nil
            }
        }
        
        if let player = audioPlayer {
            if player.isPlaying {
                player.pause()
                self.audioPlayer = nil
            }
        }
    }
    
    private func initInterfaceComponent() {
        playPauseButton = previewAudioView.playAudioButton
        playPauseButton.addTarget(self, action: #selector(playPauseButtonPressed(_:)), for: .touchUpInside)
        
        editButton = previewAudioView.buttonEdit
        editButton.addTarget(self, action: #selector(editButtonPressed(_:)), for: .touchUpInside)

        lengthOfAudioLabel = previewAudioView.timeLengthAudioLabel
        editLabel = previewAudioView.editLabel
        audioLabel = previewAudioView.audioLabel
        
        audioButton = previewAudioView.buttonAudio
        audioButton.addTarget(self, action: #selector(audioButtonPressed(_:)), for: .touchUpInside)
        
        segmentCollectionView = previewAudioView.segmentCollectionView
        segmentCollectionView.register(SegmentCell.self, forCellWithReuseIdentifier: Constants.KEY_SEGMENT_CELL)
        segmentCollectionView.delegate = self
        segmentCollectionView.dataSource = self
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressCollectionView(_:)))
        segmentCollectionView.addGestureRecognizer(gesture)
    }

    private func setupNavigationController() {
        title = "Preview Your Audio"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes

        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.isTranslucent = true

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveButtonPressed(_:)))
        self.navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    @objc private func editButtonPressed(_ sender: Any) {
        guard let url = urlAudio else { return }

        EditAudioWireframe.performToEditAudio(urlAudio: url, callback: { (segmentModels) in
            if segmentModels.count != 0 {
                print(segmentModels)
                self.segmentModels.append(contentsOf: segmentModels)
                self.changeStatusView()
                if segmentModels.count != 0 {
                    print("here")
                    self.navigationItem.rightBarButtonItem?.isEnabled = true
                }
            }
        }, caller: self)
    }
    
    @objc private func audioButtonPressed(_ sender: Any) {
        AdditionalSoundWireframe.performToAdditionalSound(caller: self) { (soundModel) in
            let segmentModel = SegmentModel(nameSegment: soundModel.nameOfSounds, urlAdditionalAudio: soundModel.url, durationAdditionalAudio: soundModel.duration, typeSegment: .AddtionalAudio)
            self.segmentModels.append(segmentModel)
            self.changeStatusView()
        }
    }

    @objc private func saveButtonPressed(_ sender: Any) {
        if let player = player, let localPlayer = audioPlayer {
            if player.rate != 0 || localPlayer.isPlaying {
                player.pause()
            }
        }
                
        if segmentModels.count != 0 {
            if segmentModels.count == 1 {
                splitAudio()
            } else if segmentModels.count > 1 {
                showAlertToMergeOrSplit(title: "Merge Or Split", message: "What do you want to do with this file ?")
            }
        } else {
            createAlertAndShowAlert(title: "Warning", message: "You have to fill the segment first!", actionName: "Okay, Got it", caller: self, handler: nil)
        }
    }
    
    private func showAlertToMergeOrSplit(title: String?, message: String?) {
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        controller.addAction(UIAlertAction(title: "Merge", style: .default, handler: { (action) in
            
            var urls = [URL]()

            for i in 0..<self.segmentModels.count {
                
                let segmentModel = self.segmentModels[i]

                if segmentModel.typeSegment == .AddtionalAudio {
                    if let additionalURLAudio = segmentModel.urlAdditionalAudio {
                        urls.append(additionalURLAudio)
                    }
                } else {
                    if let urlAudio = segmentModel.urlSegment {
                        urls.append(urlAudio)
                    }
                }
            }
            self.mergeAudio(urls: urls, fileName: "Merge Audio: \(EditAudioRepository.getNumberForFileManager())")
            
        }))
        
        controller.addAction(UIAlertAction(title: "Split", style: .default, handler: { (action) in
            self.splitAudio()
        }))
        
        controller.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(controller, animated: true, completion: nil)
    }
    
    private func mergeAudio(urls: [URL], fileName: String) {
        
        EditAudioRepository.merge(audioFilesURL: urls, fileName: fileName, successExport: { (url) in
            
            for i in 0..<urls.count {
                if EditAudioRepository.isFileURLExist(url: urls[i]) {
                    print("URL exist")
                    EditAudioRepository.removeExistingFile(atPath: urls[i])
                }
            }
            
            guard let urlAudio = self.urlAudio else { return }
            
            let donwloadedURL = urlAudio
            let fileName = "\(donwloadedURL.lastPathComponent).mp3"
            let filePath = getDirectory().appendingPathComponent(fileName)
            
            if EditAudioRepository.isFileURLExist(url: filePath) {
                print("Donwloaded URL exist")
                EditAudioRepository.removeExistingFile(atPath: filePath)
            }
            
            let resultModel = SegmentModel(nameSegment: fileName, startTimeSeconds: nil, endTimeSeconds: nil, urlSegment: url, urlAdditionalAudio: nil, durationAdditionalAudio: nil, typeSegment: .EditAudio)
            
            DispatchQueue.main.async {
                self.designReadyDelegate.didAudioReady(isReady: true)
                self.designReadyDelegate.audioReady(model: [resultModel])
                self.navigationController?.popToRootViewController(animated: true)
            }

        }) { (message) in
            createAlertAndShowAlert(title: "ERROR", message: "Cant Merge Audio", actionName: "Cancel", caller: self, handler: nil)
            return
        }
    }
    
    private func splitAudio() {
        
        var resultSegmentModels = [SegmentModel]()
        
        for i in 0..<segmentModels.count {
            
            let segmentModel = segmentModels[i]
            
            if segmentModel.typeSegment == .EditAudio {
                resultSegmentModels.append(segmentModel)
            }
        }
        
        self.designReadyDelegate.didAudioReady(isReady: true)
        self.designReadyDelegate.audioReady(model: resultSegmentModels)
        self.navigationController?.popToRootViewController(animated: true)
    }

    @objc private func playPauseButtonPressed(_ sender: Any) {
        guard let player = player else { return }
        
        let button = sender as! UIButton
        if button == playPauseButton {
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
    }
    
    private func preparePlayer(url: URL?) {
        guard let safeURLAudio = url else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = AVPlayer(url: safeURLAudio)
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func prepareAudioPlayer(url: URL?) {
        guard let safeURLAudio = url else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            audioPlayer = try AVAudioPlayer(contentsOf: safeURLAudio)
            
            guard let player = audioPlayer else { return }
            player.prepareToPlay()
            
            NotificationCenter.default.addObserver(self, selector: #selector(audioPlayerDidFinishPlaying), name: .AVPlayerItemDidPlayToEndTime, object: nil)
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @objc private func audioPlayerDidFinishPlaying() {
        if let indexPath = indexPath {
            self.segmentCollectionView.performBatchUpdates({
                self.segmentCollectionView.reloadItems(at: [indexPath])
                isPlaying = false
            }) { (finish) in
                print(finish)
            }
        }
    }
    
    private func changeStatusView() {
        self.playPauseButton.isHidden = true
        self.lengthOfAudioLabel.isHidden = true
        self.segmentCollectionView.isHidden = false
        self.segmentCollectionView.reloadData()
    }
}

extension PreviewAudioVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return segmentModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.KEY_SEGMENT_CELL, for: indexPath) as! SegmentCell

        var segmentModel = segmentModels[indexPath.row]
        
        var nameSegment = segmentModel.nameSegment
        if nameSegment?.count == 0 || nameSegment == nil {
            nameSegment = "Segment \(indexPath.row + 1)"
            segmentModel.nameSegment = nameSegment
            segmentModels[indexPath.row] = segmentModel
        }
        
        if segmentModel.typeSegment == .AddtionalAudio  {
            let nameSegment = segmentModel.nameSegment!

            let (_, M, S) = secondsToHoursMinutesSeconds(seconds: segmentModel.durationAdditionalAudio!)
            
            let minutesString = checkTimeIs2DigitOrNot(time: M)
            let secondsString = checkTimeIs2DigitOrNot(time: S)
            
            cell.titleLabel.text = nameSegment
            cell.rangeTimeLabel.text = "\(minutesString):\(secondsString)"
            cell.playButton.setImage(UIImage(named: "playButtonRed"), for: .normal)
            
        } else {            
            cell.segmentModel = segmentModel
        }
        
        cell.playButton.addTarget(self, action: #selector(playCellButtonPressed(_:)), for: .touchUpInside)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectedItem = indexPath.row
        
        if segmentModels[indexPath.row].typeSegment == .EditAudio {
            showCustomSheet()
        } else {
            previewAudioView.addSubview(customSheetView)
            customSheetView.anchor(top: previewAudioView.topAnchor, bottom: previewAudioView.bottomAnchor, leading: previewAudioView.leadingAnchor, trailing: previewAudioView.trailingAnchor, marginTop: 0, marginBottom: 0, marginLeading: 0, marginTrailing: 0, width: 0, height: 0, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
            
            customSheetView.stackRenameView.isHidden = true
            customSheetView.optionsTitileLabel.bottomAnchor.constraint(equalTo: customSheetView.stackDeleteView.topAnchor, constant: -10).isActive = true
            customSheetView.optionsTitileLabel.topAnchor.constraint(equalTo: customSheetView.contentSheetView.topAnchor, constant: 15).isActive = true
            customSheetView.stackEditView.isHidden = true
            customSheetView.editingsTitileLabel.isHidden = true
            customSheetView.contentSheetView.heightAnchor.constraint(equalToConstant: 140).isActive = true
            
            navigationController?.navigationItem.rightBarButtonItem?.isEnabled = false
            customSheetView.stackDeleteView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(deleteSheetTapped)))
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = UIScreen.main.bounds
        
        return CGSize(width: screenSize.width - 30, height: 75)
    }
    
    @objc func handleLongPressCollectionView(_ gesture: UILongPressGestureRecognizer) {
        let collectionView = segmentCollectionView
        
        switch gesture.state {
        case .began:
            guard let targetIndexPath = collectionView?.indexPathForItem(at: gesture.location(in: collectionView)) else {
                return
            }
            
            collectionView?.beginInteractiveMovementForItem(at: targetIndexPath)
            
        case .changed:
            collectionView?.updateInteractiveMovementTargetPosition(gesture.location(in: collectionView))
            
        case .ended:
            collectionView?.endInteractiveMovement()
        default:
            collectionView?.cancelInteractiveMovement()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let item = segmentModels.remove(at: sourceIndexPath.row)
        segmentModels.insert(item, at: destinationIndexPath.row)
    }
}

extension PreviewAudioVC {
    @objc private func playCellButtonPressed(_ sender: Any) {
        if let player = audioPlayer {
            if player.isPlaying {
                isAudioLocalPlaying = false
                player.pause()
                self.player = nil
            }
        }
        
        if let indexPath = indexPath {
            self.segmentCollectionView.performBatchUpdates({
                self.segmentCollectionView.reloadItems(at: [indexPath])
            }) { (finish) in
                print(finish)
            }
        }
        
        if let button = sender as? UIButton {
            let point: CGPoint = button.convert(.zero, to: self.segmentCollectionView)
            if let indexPath = self.segmentCollectionView!.indexPathForItem(at: point) {
                let cell = self.segmentCollectionView!.cellForItem(at: indexPath) as! SegmentCell
                                
                self.indexPath = indexPath
                
                playCellButton = cell.playButton

                
                if segmentModels[indexPath.row].typeSegment == .AddtionalAudio {
                    if let url = segmentModels[indexPath.row].urlAdditionalAudio {
                        urlLocalAudio = url
                    }
                } else {
                    if let url = segmentModels[indexPath.row].urlSegment {
                        urlLocalAudio = url
                    }
                }
                
                guard let player = audioPlayer else {
                    return
                }
                
                player.play()
                changeBGPlayPauseButton(isPlaying: isAudioLocalPlaying, playPauseButton: playCellButton)
                isAudioLocalPlaying = true
            }
        }
    }
}

extension PreviewAudioVC {
    private func showCustomSheet() {
        previewAudioView.addSubview(customSheetView)
        customSheetView.anchor(top: previewAudioView.topAnchor, bottom: previewAudioView.bottomAnchor, leading: previewAudioView.leadingAnchor, trailing: previewAudioView.trailingAnchor, marginTop: 0, marginBottom: 0, marginLeading: 0, marginTrailing: 0, width: 0, height: 0, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        navigationController?.navigationItem.rightBarButtonItem?.isEnabled = false
        customSheetView.cancelButton.addTarget(self, action: #selector(cancelSheetPressed(_:)), for: .touchUpInside)
        customSheetView.stackDeleteView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(deleteSheetTapped)))
        customSheetView.stackRenameView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(renameSheetTapped)))
    }

    private func removeCustomSheet() {
        customSheetView.removeFromSuperview()
        if segmentModels.count != 0 {
            if segmentModels[selectedItem].nameSegment != nil {
                navigationController?.navigationItem.rightBarButtonItem?.isEnabled = true
            } else {
                navigationController?.navigationItem.rightBarButtonItem?.isEnabled = false
            }
        }
    }
    
    @objc private func cancelSheetPressed(_ sender: Any) {
        removeCustomSheet()
    }
    
    @objc private func deleteSheetTapped() {
        removeCustomSheet()
        segmentModels.remove(at: selectedItem)
        self.segmentCollectionView.reloadData()
        if segmentModels.count == 0 {
            self.segmentCollectionView.isHidden = true
            self.lengthOfAudioLabel.isHidden = false
            self.playPauseButton.isHidden = false
            self.navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
    
    @objc private func renameSheetTapped() {
        removeCustomSheet()
        createActionSheetWithTextField(title: "Rename Segment", message: nil, caller: self) { (userInput) in
            self.segmentModels[self.selectedItem].nameSegment = userInput
            self.segmentCollectionView.reloadData()
        }
    }
    
    @objc private func editSheetTapped() {
        removeCustomSheet()
    }
}
