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
    
    var editAudioView: EditAudioView { return self.view as! EditAudioView }
    
    var player: AVPlayer?
    
    var isPlaying = false
    
    var urlAudio: URL? {
        didSet {
            preparePlayer()
        }
    }
    
    var segmentModels = [SegmentModel]()
    
    var callback: (([SegmentModel]) -> Void)?
    
    override func loadView() {
        self.view = EditAudioView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationController()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initInterfaceComponent()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if player?.rate != 0 {
            player?.pause()
        }
        player = nil
        
        callback?(segmentModels)
    }
    
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
        segmentCollectionView.register(SegmentCell.self, forCellWithReuseIdentifier: Constants.KEY_SEGMENT_CELL)
        segmentCollectionView.delegate = self
        segmentCollectionView.dataSource = self
        
        stackInfoSegmentView = editAudioView.stackInfoSegmentView
        contentView = editAudioView.view
        
        doneButton = editAudioView.doneButton
        doneButton.addTarget(self, action: #selector(doneButtonPressed(_:)), for: .touchUpInside)
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
    
    @objc private func addSegmentButtonPressed(_ sender: UIButton) {
        EditAudioWireframe.performToAddSegment(caller: self) { (segmentModel) in
            self.segmentModels.append(segmentModel)
            self.stackInfoSegmentView.isHidden = true
            self.segmentCollectionView.isHidden = false
            self.segmentCollectionView.reloadData()
        }
    }
    
    @objc private func playerDidFinishPlaying() {
        changeBGPlayPauseButton(isPlaying: isPlaying, playPauseButton: playPauseButton)
        isPlaying = false
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
        navigationController?.popViewController(animated: true)
    }
}

extension EditAudioVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return segmentModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.KEY_SEGMENT_CELL, for: indexPath) as! SegmentCell
        
        let nameSegment = "Segment \(indexPath.row + 1)"
        
        var segmentModel = segmentModels[indexPath.row]
        segmentModel.nameSegment = nameSegment
        
        cell.segmentModel = segmentModel
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let contentViewSize = contentView.bounds
        
        return CGSize(width: contentViewSize.width - 30, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}
