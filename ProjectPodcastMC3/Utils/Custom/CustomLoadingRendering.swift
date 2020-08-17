//
//  CustomLoadingRendering.swift
//  ProjectPodcastMC3
//
//  Created by Reynaldi Wijaya on 16/08/20.
//  Copyright © 2020 Reynaldi Wijaya. All rights reserved.
//

import UIKit

class CustomLoadingRendering: UIView {
    
    lazy var imageViewRender: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "render")
        return imageView
    }()
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 22)
        label.textAlignment = .center
        label.textColor = .white
        label.text = "Rendering..."
        return label
    }()
    
    lazy var subTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = .white
        label.text = "Wait a few moments for it to finish"
        label.numberOfLines = 5
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .black
        
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        self.addSubview(imageViewRender)
        self.addSubview(title)
        self.addSubview(subTitle)
    }
    
    private func setupConstraints() {
        imageViewRender.anchor(top: nil, bottom: nil, leading: self.leadingAnchor, trailing: self.trailingAnchor, marginTop: 0, marginBottom: 0, marginLeading: 25, marginTrailing: -25, width: 0, height: frame.height / 3, centerX: nil, centerY: self.centerYAnchor, marginFromCenterX: 0, marginFromCenterY: -50)
        
        title.anchor(top: imageViewRender.bottomAnchor, bottom: nil, leading: nil, trailing: nil, marginTop: 10, marginBottom: 0, marginLeading: 0, marginTrailing: 0, width: 0, height: 0, centerX: self.centerXAnchor, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        
        subTitle.anchor(top: title.bottomAnchor, bottom: nil, leading: self.leadingAnchor, trailing: self.trailingAnchor, marginTop: 10, marginBottom: 0, marginLeading: 20, marginTrailing: -20, width: 0, height: 0, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
