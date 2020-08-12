//
//  PodcastContentController.swift
//  ProjectPodcastMC3
//
//  Created by Nani Sukma Putri Pratama on 12/08/20.
//  Copyright © 2020 Reynaldi Wijaya. All rights reserved.
//

import UIKit

class PodcastContentController: UIViewController{
    
    let podcast : UIButton = {
        let button = UIButton(type: .infoDark)
        button.adjustsImageSizeForAccessibilityContentSizeCategory = true
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 1/255, green: 0/255, blue: 17/255, alpha: 1.0)
        navigationItem.title = "NAVIGATION"
        setupPodcast()
    }
    func setupPodcast(){
        view.addSubview(podcast)
        podcast.translatesAutoresizingMaskIntoConstraints = false
        podcast.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        podcast.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -30).isActive = true
        
        podcast.addTarget(self, action: #selector(tappedButton), for: .touchUpInside)
    }
    @objc func tappedButton(){
        print("button tapped")
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let screenInfo = SecondOnBoardingController(collectionViewLayout: layout)
        screenInfo.modalPresentationStyle = .popover
        present(screenInfo, animated: true, completion: nil)

        
    }
}
