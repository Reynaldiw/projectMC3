//
//  ViewController.swift
//  ProjectPodcastMC3
//
//  Created by Reynaldi Wijaya on 27/07/20.
//  Copyright © 2020 Reynaldi Wijaya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var RenderGif : RenderingGif!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        self.RenderGif = RenderingGif()
        
        view.addSubview(RenderGif)
        RenderGif.translatesAutoresizingMaskIntoConstraints = false
        RenderGif.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        RenderGif.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        RenderGif.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        RenderGif.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        
    }


}

