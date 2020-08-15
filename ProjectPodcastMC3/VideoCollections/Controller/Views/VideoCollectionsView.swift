//
//  CollectionsView.swift
//  ProjectPodcastMC3
//
//  Created by Ganang Arief Pratama on 12/08/20.
//  Copyright © 2020 Reynaldi Wijaya. All rights reserved.
//

import UIKit

class VideoCollectionsView: BaseView {
    
    let loadingView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.BG_SCREEN_DARK_PURPLE.withAlphaComponent(0.5)
        
        return view
    }()
    
    let containerLoadingView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        
        return view
    }()
    
    let loadingIndicatorView: UIActivityIndicatorView = {
        let activityView = UIActivityIndicatorView()
        activityView.translatesAutoresizingMaskIntoConstraints = false
        activityView.color = .white
        activityView.style = .large
        
        return activityView
    }()
    
    let informationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Please wait we are processing your video ..."
        label.textColor = .white
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 3
        
        return label
    }()
    
    lazy var videoCollectionView: UICollectionView = {
        let customFlowLayout = UICollectionViewFlowLayout()
        customFlowLayout.sectionInsetReference = .fromContentInset // .fromContentInset is default
        customFlowLayout.minimumLineSpacing = 16
        customFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: customFlowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        return collectionView
    }()
    
    func showSpinner() {
        addSubview(loadingView)
        addSubview(containerLoadingView)
        containerLoadingView.addSubview(loadingIndicatorView)
        containerLoadingView.addSubview(informationLabel)
        loadingIndicatorView.startAnimating()
        
        loadingView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        loadingView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        loadingView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        loadingView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        containerLoadingView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        containerLoadingView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        containerLoadingView.widthAnchor.constraint(equalToConstant: frame.width - 72).isActive = true
        containerLoadingView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        containerLoadingView.layer.cornerRadius = 8
        
        loadingIndicatorView.topAnchor.constraint(equalTo: containerLoadingView.topAnchor, constant: 16).isActive = true
        loadingIndicatorView.centerXAnchor.constraint(equalTo: containerLoadingView.centerXAnchor).isActive = true
        
        informationLabel.topAnchor.constraint(equalTo: loadingIndicatorView.bottomAnchor, constant: 16).isActive = true
        informationLabel.centerXAnchor.constraint(equalTo: containerLoadingView.centerXAnchor).isActive = true
    
    }
    
    func hideSpinner() {
        loadingView.removeFromSuperview()
        containerLoadingView.removeFromSuperview()
        loadingIndicatorView.stopAnimating()
    }
    
    override func setupViews() {
        
        addSubview(videoCollectionView)
        videoCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        videoCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        videoCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        videoCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}
