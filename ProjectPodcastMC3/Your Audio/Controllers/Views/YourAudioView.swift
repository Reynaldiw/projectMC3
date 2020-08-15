//
//  SearchAudioView.swift
//  ProjectPodcastMC3
//
//  Created by Reynaldi Wijaya on 04/08/20.
//  Copyright © 2020 Reynaldi Wijaya. All rights reserved.
//

import UIKit

class YourAudioView: UIView {
    
    lazy var searchPodcastView: SearchPodcastView = SearchPodcastView()
    lazy var uploadAudioView: UploadAudioView = UploadAudioView()
    lazy var episodePodcastView: EpisodePodcastView = EpisodePodcastView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = Colors.BG_SCREEN_DARK_PURPLE
        
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        self.addSubview(segmentedControl)
        self.addSubview(searchPodcastView)
        self.addSubview(searchBar)
        self.addSubview(uploadAudioView)
        self.addSubview(episodePodcastView)
    }
    
    private func setupConstraints() {
        setupSegmentedControlConstraint()
        setupSearchPodcastViewConstraint()
        setupSearchBarConstraint()
        setupUploadAudioViewConstraint()
        setupEpisodePodcastViewConstraint()
    }
    
    lazy var segmentedControl: UISegmentedControl = {
        var itemsSegmentedControl = ["Search", "Upload"]
        
        let segmentedControl = UISegmentedControl(items: itemsSegmentedControl)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.layer.cornerRadius = 10
        segmentedControl.selectedSegmentTintColor = .systemBlue
        segmentedControl.backgroundColor = Colors.BG_SCREEN_PURPLE_GRAY
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        segmentedControl.layer.masksToBounds = true
        return segmentedControl
    }()
    
    private func setupSegmentedControlConstraint() {
        segmentedControl.anchor(top: safeAreaLayoutGuide.topAnchor, bottom: nil, leading: self.leadingAnchor, trailing: self.trailingAnchor, marginTop: 20, marginBottom: 0, marginLeading: 40, marginTrailing: -40, width: 0, height: 30, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
    }
    
    lazy var searchBar: UISearchBar = {
        let searchbar = UISearchBar()
        searchbar.backgroundImage = UIImage()
        searchbar.placeholder = "Enter your podcast name or RSSD Feed"
        searchbar.searchTextField.textColor = .white
        return searchbar
    }()
    
    private func setupSearchBarConstraint() {
        searchBar.anchor(top: segmentedControl.bottomAnchor, bottom: nil, leading: self.leadingAnchor, trailing: self.trailingAnchor, marginTop: 13, marginBottom: 0, marginLeading: 20, marginTrailing: -20, width: 0, height: 0, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
    }
    
    private func setupSearchPodcastViewConstraint() {
        searchPodcastView.anchor(top: searchBar.bottomAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, leading: self.leadingAnchor, trailing: self.trailingAnchor, marginTop: 10, marginBottom: -10, marginLeading: 20, marginTrailing: -20, width: 0, height: 0, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
    }
    
    private func setupUploadAudioViewConstraint() {
        uploadAudioView.anchor(top: searchBar.bottomAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, leading: self.leadingAnchor, trailing: self.trailingAnchor, marginTop: 10, marginBottom: -10, marginLeading: 20, marginTrailing: -20, width: 0, height: 0, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        uploadAudioView.isHidden = true
    }
    
    private func setupEpisodePodcastViewConstraint() {
        episodePodcastView.anchor(top: segmentedControl.bottomAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, leading: self.leadingAnchor, trailing: self.trailingAnchor, marginTop: 13, marginBottom: -10, marginLeading: 20, marginTrailing: -20, width: 0, height: 0, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        episodePodcastView.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
