//
//  CollectionCell.swift
//  ProjectPodcastMC3
//
//  Created by Ganang Arief Pratama on 12/08/20.
//  Copyright © 2020 Reynaldi Wijaya. All rights reserved.
//

import UIKit

class VideoCollectionCell: BaseCell {
    
    let placeholderImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .gray
        imageView.isUserInteractionEnabled = true
        
        return imageView
    }()
    
    let shareButton: CustomButton = {
        let button = CustomButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Share", for: .normal)
        button.tintColor = .white
        button.backgroundColor = Colors.BG_SCREEN_PURPLE_GRAY
        
        return button
    }()
    
    let playButton: CustomButton = {
        let button = CustomButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "play.circle"), for: .normal)
        button.tintColor = .white
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        
        return button
    }()
    
    override func setupViews() {
        setupInterfaceComponent()
        setupConstraints()
    }
    
    func setupInterfaceComponent() {
        addSubview(placeholderImageView)
        placeholderImageView.addSubview(shareButton)
        placeholderImageView.addSubview(playButton)
    }
    
    func setupConstraints() {
        placeholderImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        placeholderImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        placeholderImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        placeholderImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        playButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        playButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        playButton.centerXAnchor.constraint(equalTo: placeholderImageView.centerXAnchor).isActive = true
        playButton.centerYAnchor.constraint(equalTo: placeholderImageView.centerYAnchor).isActive = true
        
        shareButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        shareButton.leadingAnchor.constraint(equalTo: placeholderImageView.leadingAnchor).isActive = true
        shareButton.trailingAnchor.constraint(equalTo: placeholderImageView.trailingAnchor).isActive = true
        shareButton.bottomAnchor.constraint(equalTo: placeholderImageView.bottomAnchor).isActive = true
    }

}
