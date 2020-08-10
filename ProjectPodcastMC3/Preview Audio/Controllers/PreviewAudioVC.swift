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

    var previewAudioView: PreviewAudioView { self.view as! PreviewAudioView }

    var player: AVPlayer?
    var isPlaying = false
    
    var urlAudio: URL? {
        didSet {
            preparePlayer()
        }
    }
    
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
        let (H, M, S) = secondsToHoursMinutesSeconds(seconds: Int(durationInSeconds))
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
