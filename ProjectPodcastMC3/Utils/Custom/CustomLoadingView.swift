//
//  CustomLoadingView.swift
//  ProjectPodcastMC3
//
//  Created by Reynaldi Wijaya on 14/08/20.
//  Copyright © 2020 Reynaldi Wijaya. All rights reserved.
//

import UIKit

class CustomLoadingView: UIView {
    
    lazy var loadingContentView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.BG_SCREEN_PURPLE_GRAY
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 1.5
        return view
    }()
    
    lazy var loadingLabel: UILabel = {
        let label = UILabel()
        label.text = "Loading"
        label.textColor = .white
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.text = "Please wait, Rendering!"
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 4
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if !UIAccessibility.isReduceTransparencyEnabled {
            let blurEffect = UIBlurEffect(style: .dark)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            
            blurEffectView.frame = self.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            self.addSubview(blurEffectView)
        }
        
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        self.addSubview(loadingContentView)
        loadingContentView.addSubview(loadingLabel)
        loadingContentView.addSubview(messageLabel)
    }
    
    private func setupConstraints() {
        loadingContentView.anchor(top: nil, bottom: nil, leading: leadingAnchor, trailing: trailingAnchor, marginTop: 0, marginBottom: 0, marginLeading: 25, marginTrailing: -25, width: 0, height: 130, centerX: nil, centerY: self.centerYAnchor, marginFromCenterX: 0, marginFromCenterY: 0)
        
        loadingLabel.anchor(top: nil, bottom: nil, leading: nil, trailing: nil, marginTop: 0, marginBottom: 0, marginLeading: 0, marginTrailing: 0, width: 0, height: 0, centerX: loadingContentView.centerXAnchor, centerY: loadingContentView.centerYAnchor, marginFromCenterX: 0, marginFromCenterY: -20)
        
        messageLabel.anchor(top: loadingLabel.bottomAnchor, bottom: nil, leading: nil, trailing: nil, marginTop: 10, marginBottom: 0, marginLeading: 0, marginTrailing: 0, width: 0, height: 0, centerX: loadingContentView.centerXAnchor, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
