//
//  SearchPodcastView.swift
//  ProjectPodcastMC3
//
//  Created by Reynaldi Wijaya on 04/08/20.
//  Copyright © 2020 Reynaldi Wijaya. All rights reserved.
//

import UIKit

class SearchPodcastView: UIView {
    
    lazy var podcastCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        flowLayout.minimumInteritemSpacing = 8
        flowLayout.minimumLineSpacing = 8
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.spacing = 12
        return stackView
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "search")
        return imageView
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 21)
        label.text = "Search your Podcast by Name or Enter your RSS Feed"
        label.numberOfLines = 5
        label.textAlignment = .center
        return label
    }()
    
    lazy var loadingView: UIActivityIndicatorView = {
        let loadingView = UIActivityIndicatorView()
        loadingView.hidesWhenStopped = true
        loadingView.isHidden = true
        return loadingView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = Colors.BG_SCREEN_PURPLE_GRAY
        self.layer.cornerRadius = 8
        
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        self.addSubview(podcastCollectionView)
        self.addSubview(stackView)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(label)
        self.addSubview(loadingView)
    }
    
    private func setupConstraints() {
        podcastCollectionView.anchor(top: self.topAnchor, bottom: self.bottomAnchor, leading: self.leadingAnchor, trailing: self.trailingAnchor, marginTop: 8, marginBottom: 8, marginLeading: 8, marginTrailing: 8, width: 0, height: 0, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        podcastCollectionView.isHidden = true
        
        stackView.anchor(top: nil, bottom: nil, leading: self.leadingAnchor, trailing: self.trailingAnchor, marginTop: 0, marginBottom: 0, marginLeading: 20, marginTrailing: -20, width: 0, height: 120, centerX: nil, centerY: self.centerYAnchor, marginFromCenterX: 0, marginFromCenterY: -18)
        
        loadingView.anchor(top: nil, bottom: nil, leading: nil, trailing: nil, marginTop: 0, marginBottom: 0, marginLeading: 0, marginTrailing: 0, width: 0, height: 0, centerX: self.centerXAnchor, centerY: self.centerYAnchor, marginFromCenterX: 0, marginFromCenterY: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
