//
//  PreviewAudioWireframe.swift
//  ProjectPodcastMC3
//
//  Created by Reynaldi Wijaya on 07/08/20.
//  Copyright © 2020 Reynaldi Wijaya. All rights reserved.
//

import UIKit

struct PreviewAudioWireframe {
    static func performToPreviewAudio(caller: UIViewController, urlAudio: URL) {
        let vc = PreviewAudioVC()
        vc.urlAudio = urlAudio
        caller.navigationController?.pushViewController(vc, animated: true)
    }
}
