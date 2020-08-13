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

    var previewAudioView: PreviewAudioView { self.view as! PreviewAudioView }

    var player: AVPlayer?
    var isPlaying = false
    
    var urlAudio: URL? {
        didSet {
            preparePlayer()
        }
    }
    
    var segmentModels = [SegmentModel]()
    
    override func loadView() {
        self.view = PreviewAudioView()
    }

    override func viewWillAppear(_ animated: Bool) {
        setupNavigationController()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initInterfaceComponent()
        
        guard let urlAudio = urlAudio else { return }
        let asset = AVAsset(url: urlAudio)
        let duration = asset.duration
        let durationInSeconds = CMTimeGetSeconds(duration)
        let (_, M, S) = secondsToHoursMinutesSeconds(seconds: Int(durationInSeconds))
        lengthOfAudioLabel.text = "\(M):\(S)"
    }
    
    private func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
      return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    private func initInterfaceComponent() {
        playPauseButton = previewAudioView.playAudioButton
        playPauseButton.addTarget(self, action: #selector(playPauseButtonPressed(_:)), for: .touchUpInside)
        
        editButton = previewAudioView.buttonEdit
        editButton.addTarget(self, action: #selector(editButtonPressed(_:)), for: .touchUpInside)

        lengthOfAudioLabel = previewAudioView.timeLengthAudioLabel
        editLabel = previewAudioView.editLabel
        audioButton = previewAudioView.buttonAudio
        audioLabel = previewAudioView.audioLabel
        
        segmentCollectionView = previewAudioView.segmentCollectionView
        segmentCollectionView.register(SegmentCell.self, forCellWithReuseIdentifier: Constants.KEY_SEGMENT_CELL)
        segmentCollectionView.delegate = self
        segmentCollectionView.dataSource = self
    }

    private func setupNavigationController() {
        title = "Preview Your Audio"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes

        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.isTranslucent = true

        let saveButton: UIButton = {
            let button = UIButton()
            button.setTitle("Save", for: .normal)
            button.addTarget(self, action: #selector(saveButtonPressed(_:)), for: .touchUpInside)
            button.setTitleColor(.systemBlue, for: .normal)
            return button
        }()

        let rightBarButtonItem = UIBarButtonItem(customView: saveButton)
        rightBarButtonItem.isEnabled = false
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    @objc func editButtonPressed(_ sender: Any) {
        guard let url = urlAudio else { return }
        
        EditAudioWireframe.performToEditAudio(urlAudio: url, callback: { (segmentModels) in
            if segmentModels.count != 0 {
                self.segmentModels = segmentModels
                self.playPauseButton.isHidden = true
                self.lengthOfAudioLabel.isHidden = true
                self.segmentCollectionView.isHidden = false
                self.segmentCollectionView.reloadData()
            }
        }, caller: self)
    }

    @objc func saveButtonPressed(_ sender: Any) {
        
    }

    @objc func playPauseButtonPressed(_ sender: Any) {
        guard let player = player else { return }
        
        if player.rate == 0 {
            changeBGPlayPauseButton()
            isPlaying = true
            player.play()
        } else {
            changeBGPlayPauseButton()
            isPlaying = false
            player.pause()
        }
    }
    
    private func preparePlayer() {
        guard let safeURLAudio = urlAudio else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = AVPlayer(url: safeURLAudio)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func changeBGPlayPauseButton() {
        if isPlaying {
            playPauseButton.setImage(UIImage(named: "play"), for: .normal)
        } else {
            playPauseButton.setImage(UIImage(named: "pause"), for: .normal)
        }
    }
}

extension PreviewAudioVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
        let screenSize = UIScreen.main.bounds
        
        return CGSize(width: screenSize.width - 30, height: 75)
    }
}
