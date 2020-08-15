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

func checkTimeIs2DigitOrNot(time: Int) -> String {
    if time < 10 {
        return "0\(time)"
    } else {
        return "\(time)"
    }
}

func createActionSheetWithTextField(title: String?, message: String?, caller: UIViewController, handler: ((String) -> Void)?) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alertController.addTextField(configurationHandler: { (textField) in
        textField.placeholder = "Enter Name"
    })
    let saveAction = UIAlertAction(title: "Save", style: .default, handler: { alert -> Void in
        let firstTextField = alertController.textFields![0] as UITextField
        if let userInput = firstTextField.text {
            if userInput.count != 0 {
                handler?(userInput)
            }
        }
    })
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
        (action : UIAlertAction!) -> Void in })
    
    alertController.addAction(saveAction)
    alertController.addAction(cancelAction)
    
    caller.present(alertController, animated: true, completion: nil)
}

func createActionSheet(title: String?, message: String?, actions: [String], images: [UIImage]?, handler: ((String) -> Void)?, caller: UIViewController) {
    
    let optionMenu = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
    optionMenu.setBackgroundColor(color: Colors.BG_SCREEN_PURPLE_GRAY)
    optionMenu.setTitle(font: nil, color: .white)
    optionMenu.setMessage(font: nil, color: .white)
    
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
    optionMenu.addAction(cancelAction)
    
    for i in 0..<actions.count {
        optionMenu.setTint(color: .white)
        if actions[i] == "Delete Segment" {
            optionMenu.setTint(color: .red)
        }
        
        let action = UIAlertAction(title: actions[i], style: .destructive) { (action) in
            handler?(actions[i])
        }
        if let images = images {
            action.setValue(images[i].withRenderingMode(.alwaysOriginal), forKey: "image")
        }
        
        optionMenu.addAction(action)
    }
    
    caller.present(optionMenu, animated: true, completion: nil)
}

// Function that gets path to directory
public func getDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let documentDirectory = paths[0]
    return documentDirectory
}
