//
//  EditAudioWireframe.swift
//  ProjectPodcastMC3
//
//  Created by Reynaldi Wijaya on 12/08/20.
//  Copyright © 2020 Reynaldi Wijaya. All rights reserved.
//

import UIKit

struct EditAudioWireframe {
    static func performToEditAudio(durationInSeconds: Int?, urlAudio: URL, callback: (([SegmentModel]) -> Void)? ,caller: UIViewController) {
        let vc = EditAudioVC()
        vc.urlAudio = urlAudio
        vc.callback = { segmentModels in
            callback?(segmentModels)
        }
        vc.duration = durationInSeconds
//        if let segmentModels = segmentModels {
//            vc.segmentModels = segmentModels
//        }
        caller.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func performToAddSegment(durationInSeconds: Int?, caller: UIViewController, callback: ((SegmentModel) -> Void)?) {
        let vc = AddSegmentVC()
        vc.durationOfSourceAudio = durationInSeconds
        vc.modalPresentationStyle = .formSheet
        vc.callback = { segmentModel in
            callback?(segmentModel)
        }
        let navController = UINavigationController(rootViewController: vc)
        caller.present(navController, animated: true, completion: nil)
    }
}
