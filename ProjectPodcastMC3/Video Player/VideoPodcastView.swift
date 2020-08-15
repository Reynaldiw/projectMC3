//
//  VideoPodcastView.swift
//  ProjectPodcastMC3
//
//  Created by Ganang Arief Pratama on 13/08/20.
//  Copyright © 2020 Reynaldi Wijaya. All rights reserved.
//

import UIKit
import AVFoundation

class VideoPodcastView: UIView {
    let videoUrl: String
    let videoPlayerView = VideoPlayerView()
    var isPlaying = false
    var timeObserverToken: Any?
  
    // 9 Add player
    @objc private let player = AVQueuePlayer()

    init(videoUrl: String) {
        self.videoUrl = videoUrl
    
        super.init(frame: .zero)
    
        // 10 Set up the player
        initializePlayer(videoUrl)
        addGestureRecognizers()
    }
    
    deinit {
        player.replaceCurrentItem(with: nil)
    }
  
    // 10 Set up player
    private func initializePlayer(_ videoUrl: String) {
        videoPlayerView.playerLayer.videoGravity = AVLayerVideoGravity.resizeAspect
        videoPlayerView.player = player
     
        addVideoToPlayer(videoUrl)

        player.volume = 1.0
        player.play()
        isPlaying = true
        
    }
  
    // 11 Create player items from video URLs and insert them into the player's list
    private func addVideoToPlayer(_ videoUrl: String) {
        let asset = AVURLAsset(url: URL(string: videoUrl)!)
        
        let item = AVPlayerItem(asset: asset)
        player.insert(item, after: player.items().last)
    }
  
    // 12 Add methods to pause and play when the view leaves the screen
    func pause() {
        player.pause()
    }

    func play() {
        player.play()
    }
  
    // MARK - Gestures
  
    // 13 Add single and double tap gestures to the video looper
    func addGestureRecognizers() {
        // 1
        let tap = UITapGestureRecognizer(target: self, action: #selector(VideoPodcastView.wasTapped))
        let doubleTap = UITapGestureRecognizer(target: self,
                                               action: #selector(VideoPodcastView.wasDoubleTapped))
        doubleTap.numberOfTapsRequired = 2
        
        // 2
        tap.require(toFail: doubleTap)

        // 3
        addGestureRecognizer(tap)
        addGestureRecognizer(doubleTap)
    }
  
    // 13a Single tapping should toggle the volume
    @objc func wasTapped() {
        isPlaying ? pause() : play()
        isPlaying = !isPlaying
    }
  
    // MARK - Unnecessary Code
    @objc func wasDoubleTapped() {
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension VideoPodcastView {
    override func layoutSubviews() {
        super.layoutSubviews()
    
        videoPlayerView.frame = bounds
        addSubview(videoPlayerView)
    }
}
