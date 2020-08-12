//
//  EditAudioWireframe.swift
//  ProjectPodcastMC3
//
//  Created by Reynaldi Wijaya on 11/08/20.
//  Copyright © 2020 Reynaldi Wijaya. All rights reserved.
//

import UIKit

struct EditAudioWireframe {
    static func performEditAudio(caller: UIViewController, urlAudio: URL){
        let vc = EditAudioVC()
        vc.urlAudio = urlAudio
        caller.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func performEditSegment(caller: UIViewController) {
        let vc = EditSegmentVC()
        caller.modalTransitionStyle = .coverVertical
        caller.modalPresentationStyle = .pageSheet
        let navController = UINavigationController(rootViewController: vc)
        caller.present(navController, animated: true, completion: nil)
    }
}
