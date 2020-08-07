//
//  PreviewAudioVC.swift
//  ProjectPodcastMC3
//
//  Created by Reynaldi Wijaya on 07/08/20.
//  Copyright © 2020 Reynaldi Wijaya. All rights reserved.
//

import UIKit

class PreviewAudioVC: UIViewController {
    
    var previewAudioView: PreviewAudioView { self.view as! PreviewAudioView }
    
    var urlAudio: URL?
    
    override func loadView() {
        self.view = PreviewAudioView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationController()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    private func setupNavigationController() {
    }
}
