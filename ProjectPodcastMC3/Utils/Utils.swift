//
//  Utils.swift
//  ProjectPodcastMC3
//
//  Created by Reynaldi Wijaya on 12/08/20.
//  Copyright © 2020 Reynaldi Wijaya. All rights reserved.
//

import UIKit

func createAlertAndShowAlert(title: String?, message: String?, actionName: String?, caller: UIViewController, handler: ((UIAlertAction) -> Void)?) {
    
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
    alertController.addAction(UIAlertAction(title: actionName, style: .cancel, handler: { (alertAction) in
        if let handler = handler {
            handler(alertAction)
        }
    }))
    
    caller.present(alertController, animated: true, completion: nil)
}

func changeBGPlayPauseButton(isPlaying: Bool, playPauseButton: UIButton) {
    if isPlaying {
        playPauseButton.setImage(UIImage(named: "play"), for: .normal)
    } else {
        playPauseButton.setImage(UIImage(named: "pause"), for: .normal)
    }
}

func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
  return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
}
