//
//  AudioEditingView.swift
//  ProjectPodcastMC3
//
//  Created by Reynaldi Wijaya on 03/08/20.
//  Copyright © 2020 Reynaldi Wijaya. All rights reserved.
//

import UIKit

class AudioEditingView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    func setupView() {
        
        self.backgroundColor = .white
        
        self.addSubview(audioImageView)
        self.addSubview(saveButton)
        
        audioImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 64).isActive = true
        audioImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -64).isActive = true
        audioImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 64).isActive = true
        audioImageView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -64).isActive = true
        audioImageView.layer.masksToBounds = true
        audioImageView.layer.cornerRadius = 10
        
        saveButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        saveButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    lazy var audioImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "waveform")
        imageView.tintColor = .white
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    let saveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("SAVE", for: .normal)
        button.titleLabel?.textColor = .white
        button.backgroundColor = .clear
        return button
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
