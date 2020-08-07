//
//  EpisodePodcastView.swift
//  ProjectPodcastMC3
//
//  Created by Reynaldi Wijaya on 07/08/20.
//  Copyright © 2020 Reynaldi Wijaya. All rights reserved.
//

import UIKit

class EpisodePodcastView: UIView {
    
    lazy var imageThumbnailView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "closeButton"), for: .normal)
        return button
    }()
    
    lazy var loadingView: UIActivityIndicatorView = {
        let loadingView = UIActivityIndicatorView()
        loadingView.hidesWhenStopped = true
        loadingView.isHidden = true
        return loadingView
    }()
    
    lazy var episodeCV: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        flowLayout.minimumInteritemSpacing = 8
        flowLayout.minimumLineSpacing = 8
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = Colors.BG_SCREEN_PURPLE_GRAY
        layer.cornerRadius = 8
        
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        self.addSubview(imageThumbnailView)
        self.addSubview(closeButton)
        self.addSubview(episodeCV)
        self.addSubview(loadingView)
    }
    
    private func setupConstraints() {
        imageThumbnailView.anchor(top: self.topAnchor, bottom: nil, leading: self.leadingAnchor, trailing: self.trailingAnchor, marginTop: 0, marginBottom: 0, marginLeading: 0, marginTrailing: 0, width: 0, height: 120, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        imageThumbnailView.layer.masksToBounds = false
        
        closeButton.anchor(top: self.topAnchor, bottom: nil, leading: self.leadingAnchor, trailing: nil, marginTop: 8, marginBottom: 0, marginLeading: 8, marginTrailing: 0, width: 24, height: 24, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        
        episodeCV.anchor(top: imageThumbnailView.bottomAnchor, bottom: self.bottomAnchor, leading: self.leadingAnchor, trailing: self.trailingAnchor, marginTop: 5, marginBottom: 0, marginLeading: 0, marginTrailing: 0, width: 0, height: 0, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        
        loadingView.anchor(top: nil, bottom: nil, leading: nil, trailing: nil, marginTop: 0, marginBottom: 0, marginLeading: 0, marginTrailing: 0, width: 0, height: 0, centerX: self.centerXAnchor, centerY: self.centerYAnchor, marginFromCenterX: 0, marginFromCenterY: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
