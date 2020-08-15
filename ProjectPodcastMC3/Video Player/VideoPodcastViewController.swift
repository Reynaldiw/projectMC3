//
//  VideoPodcastViewController.swift
//  ProjectPodcastMC3
//
//  Created by Ganang Arief Pratama on 13/08/20.
//  Copyright © 2020 Reynaldi Wijaya. All rights reserved.
//

import UIKit

class VideoPodcastViewController: UIViewController {
    
    var videoUrl: String?
    var videoPodcastView: VideoPodcastView!
    
    let backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "arrow.left.circle.fill"), for: .normal)
        button.tintColor = .gray
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: #selector(backButtonOnClick), for: .touchUpInside)
        
        return button
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationController()
        
        UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPlayer()
        setupViews()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        self.videoPodcastView.pause()
    }
    
    @objc func backButtonOnClick() {
        self.navigationController?.popViewController(animated: true)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    private func setupNavigationController() {
        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.isToolbarHidden = true
    }
    
    func setupPlayer() {
        self.videoPodcastView = VideoPodcastView(videoUrl: self.videoUrl!)
    }
    
    func setupViews() {
        setupInterfaceComponents()
        setupConstraints()
    }
    
    func setupInterfaceComponents() {
        view.backgroundColor = Colors.BG_SCREEN_DARK_PURPLE
        view.addSubview(videoPodcastView)
        view.addSubview(backButton)
    }
    
    func setupConstraints() {
        videoPodcastView.translatesAutoresizingMaskIntoConstraints = false
        videoPodcastView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        videoPodcastView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        videoPodcastView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        videoPodcastView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 48).isActive = true
        backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
}
