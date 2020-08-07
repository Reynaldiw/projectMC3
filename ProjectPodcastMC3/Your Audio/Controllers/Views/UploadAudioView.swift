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
        stackView.spacing = 0
        return stackView
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "upload")
        return imageView
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 21)
        label.text = "Upload your Podcast Audio"
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    lazy var buttonUpload: UIButton = {
        let button = UIButton()
        button.setTitle("Choose File", for: .normal)
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.backgroundColor = .systemBlue
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = Colors.BG_SCREEN_PURPLE_GRAY
        self.layer.cornerRadius = 8
        
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        self.addSubview(stackView)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(buttonUpload)
    }
    
    private func setupConstraints() {
        imageView.anchor(top: nil, bottom: nil, leading: nil, trailing: nil, marginTop: 0, marginBottom: 0, marginLeading: 0, marginTrailing: 0, width: 44, height: 48, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        
        stackView.anchor(top: nil, bottom: nil, leading: self.leadingAnchor, trailing: self.trailingAnchor, marginTop: 0, marginBottom: 0, marginLeading: 20, marginTrailing: -20, width: 0, height: 150, centerX: nil, centerY: self.centerYAnchor, marginFromCenterX: 0, marginFromCenterY: -18)
        
        buttonUpload.anchor(top: nil, bottom: nil, leading: nil, trailing: nil, marginTop: 0, marginBottom: 0, marginLeading: 0, marginTrailing: 0, width: 80, height: 0, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
