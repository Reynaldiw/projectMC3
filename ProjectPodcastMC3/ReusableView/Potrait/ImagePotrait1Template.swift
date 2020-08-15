//
//  ImagePotrait1Template.swift
//  ProjectPodcastMC3
//
//  Created by Mohamad Naufal Nafian on 13/08/20.
//  Copyright © 2020 Reynaldi Wijaya. All rights reserved.
//

import UIKit

class ImagePotrait1Template: UIView {
    
    
    let contentView = UIView()
    let backgroundView = UIView()
    
    let textContainer : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.applySketchShadow()
        return view
    }()
  
    var contentImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "FreddieSquare")
        img.contentMode = .scaleToFill
        img.layer.applySketchShadow(color: .black, alpha: 0.11, x: -1, y: 2, blur: 3, spread: 0)
        
        return img
    }()
    
    var titleText : UILabel = {
        let label = UILabel()
        label.text = "Lover of Life, Singer of Song"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.textColor = .black
        //label.backgroundColor = .lightGray
        return label
    }()
//
    var waveformImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "waveformnew3")

        return img
    }()
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .white
        contentView.layer.applySketchShadow(color: .black, alpha: 0.31, x: -1, y: 2, blur: 3, spread: 0)
        addSubview(contentView)
        contentView.anchor(top: topAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, marginTop: 0, marginBottom: 0, marginLeading: 0, marginTrailing: 0, width: 0, height: 0, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        
        
        backgroundView.backgroundColor = .gray
        contentView.addSubview(backgroundView)
        backgroundView.anchor(top: nil, bottom: bottomAnchor, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, marginTop: 0, marginBottom: 0, marginLeading: 0, marginTrailing: 0, width: 0, height: 420, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        
        contentView.addSubview(textContainer)
        contentView.addSubview(contentImage)
        contentImage.anchor(top: nil, bottom: nil, leading: nil, trailing: nil, marginTop: 0, marginBottom: 0, marginLeading: 0, marginTrailing: 0, width: 280, height: 280, centerX: centerXAnchor, centerY: centerYAnchor, marginFromCenterX: 0, marginFromCenterY: -120)

        
        textContainer.anchor(top: contentImage.bottomAnchor, bottom: nil, leading: nil, trailing: nil, marginTop: -60, marginBottom: 0, marginLeading: 0, marginTrailing: 0, width: 220, height: 160, centerX: centerXAnchor, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        
        textContainer.addSubview(titleText)
        titleText.anchor(top: contentImage.bottomAnchor, bottom: nil, leading: textContainer.leadingAnchor, trailing: textContainer.trailingAnchor, marginTop: 10, marginBottom: 0, marginLeading: 10, marginTrailing: -10, width: 0, height: 80, centerX: centerXAnchor, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        
        textContainer.addSubview(waveformImage)
        waveformImage.anchor(top: nil, bottom: contentView.bottomAnchor, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, marginTop: 0, marginBottom: -75, marginLeading: 32, marginTrailing: -32, width: 0, height: 60, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
