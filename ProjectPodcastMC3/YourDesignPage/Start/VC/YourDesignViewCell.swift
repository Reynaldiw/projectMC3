//
//  YourDesignViewCell.swift
//  ProjectPodcastMC3
//
//  Created by Mohamad Naufal Nafian on 12/08/20.
//  Copyright © 2020 Reynaldi Wijaya. All rights reserved.
//

import UIKit

class YourDesignViewCell: UICollectionViewCell {
    
    var yourDesignCVModel: YourDesignCVModel? {
        didSet {
            if yourDesignCVModel?.isClickable == false {
                contentView.alpha = 0.4
            } else {
                contentView.alpha = 1
            }
        }
    }
    
    
    let logoImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "template")
        
        return img
    }()
    
    let logoTitle: UILabel = {
        let label = UILabel()
        label.text = "template"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        label.textColor = Theme.current.textColor2
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    func setupLayout() {
        //layer.backgroundColor = Theme.current.accentColor as! CGColor
        layer.cornerRadius = 8
        
        addSubview(contentView)
        contentView.anchor(top: topAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, marginTop: 0, marginBottom: 0, marginLeading: 0, marginTrailing: 0, width: 0, height: 0, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        
        contentView.addSubview(logoImage)
        logoImage.anchor(top: contentView.topAnchor, bottom: nil, leading: nil, trailing: nil, marginTop: 20, marginBottom: 0, marginLeading: 0, marginTrailing: 0, width: 40, height: 40, centerX: centerXAnchor, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        
        contentView.addSubview(logoTitle)
        logoTitle.anchor(top: logoImage.bottomAnchor, bottom: nil, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, marginTop: 14, marginBottom: 0, marginLeading: 0, marginTrailing: 0, width: 0, height: 0, centerX: contentView.centerXAnchor, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
    }
    
    func updateUI() {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
