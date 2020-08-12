//
//  Utils.swift
//  ProjectPodcastMC3
//
//  Created by Reynaldi Wijaya on 11/08/20.
//  Copyright © 2020 Reynaldi Wijaya. All rights reserved.
//

import UIKit
import AVFoundation

func secondsToHoursMinutesSeconds (urlAudio : URL) -> (Int, Int, Int) {
    let asset = AVAsset(url: urlAudio)
    let duration = asset.duration
    let durationInSeconds = Int(CMTimeGetSeconds(duration))
    return (durationInSeconds / 3600, (durationInSeconds % 3600) / 60, (durationInSeconds % 3600) % 60)
}

func createAlertAndShowAlert(title: String?, message: String?, actionName: String?, caller: UIViewController, handler: ((UIAlertAction) -> Void)?) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

    alert.addAction(UIAlertAction(title: actionName, style: .cancel, handler: { (alert) in
        if let handler = handler {
            handler(alert)
        }
    }))
    
    caller.present(alert, animated: true)
}

func changeBGPlayPauseButton(isPlaying: Bool, playPauseButton: UIButton) {
    if isPlaying {
        playPauseButton.setImage(UIImage(named: "play"), for: .normal)
    } else {
        playPauseButton.setImage(UIImage(named: "pause"), for: .normal)
    }
}
