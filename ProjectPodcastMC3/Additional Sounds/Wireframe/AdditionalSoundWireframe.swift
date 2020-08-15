//
//  AdditionalSoundWireframe.swift
//  ProjectPodcastMC3
//
//  Created by Reynaldi Wijaya on 13/08/20.
//  Copyright © 2020 Reynaldi Wijaya. All rights reserved.
//

import UIKit

struct AdditionalSoundWireframe {
    static func performToAdditionalSound(caller: UIViewController, callback: ((AdditionalSoundModel) -> Void)?) {
        let vc = AdditionalSoundsVC()
        vc.modalPresentationStyle = .fullScreen
        vc.callback = { soundModel in
            callback?(soundModel)
        }
        caller.navigationController?.pushViewController(vc, animated: true)
    }
}
