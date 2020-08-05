//
//  UploadAudioView.swift
//  ProjectPodcastMC3
//
//  Created by Reynaldi Wijaya on 04/08/20.
//  Copyright © 2020 Reynaldi Wijaya. All rights reserved.
//

import UIKit

class UploadAudioView: UIView {
    
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

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = Colors.BG_SCREEN_PURPLE_GRAY
        self.layer.cornerRadius = 8
        
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        
    }
    
    private func setupConstraints() {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
