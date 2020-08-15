//
//  ImageSquare7Template.swift
//  ProjectPodcastMC3
//
//  Created by Mohamad Naufal Nafian on 13/08/20.
//  Copyright © 2020 Reynaldi Wijaya. All rights reserved.
//

import UIKit

class ImageSquare7Template: UIView {

    let contentView = UIView()
        var backgroundImage: UIImageView = {
            let img = UIImageView()
            img.image = UIImage(named: "TemplateKotak4")
            img.contentMode = .scaleToFill
            //img.layer.applySketchShadow(color: .black, alpha: 0.11, x: -1, y: 2, blur: 3, spread: 0)
            img.addBlurEffect()
            return img
        }()
        
        var contentImage: UIImageView = {
            let img = UIImageView()
            img.image = UIImage(named: "TemplateKotak4")
            img.contentMode = .scaleToFill
            //img.layer.applySketchShadow(color: .black, alpha: 0.11, x: -1, y: 2, blur: 3, spread: 0)
            //img.addBlurEffect()
            return img
        }()
        
        var waveformImage: UIImageView = {
            let img = UIImageView()
            img.image = UIImage(named: "waveformnew3")
            img.setImageColor(color: .black)
            //img.contentMode = .scaleToFill
            //img.layer.applySketchShadow(color: .black, alpha: 0.11, x: -1, y: 2, blur: 3, spread: 0)
            //img.addBlurEffect()
            return img
        }()
    
        var contentText : UILabel = {
            let label = UILabel()
            label.text = "Talking with James"
            label.font = UIFont.boldSystemFont(ofSize: 24)
            label.textColor = UIColor.black
            return label
        }()
        
    
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            addSubview(contentView)
            contentView.anchor(top: topAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, marginTop: 0, marginBottom: 0, marginLeading: 0, marginTrailing: 0, width: 0, height: 0, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
            contentView.addSubview(backgroundImage)
            backgroundImage.anchor(top: contentView.topAnchor, bottom: contentView.bottomAnchor, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, marginTop: 0, marginBottom: 0, marginLeading: 0, marginTrailing: 0, width: 0, height: 0, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
            
            contentView.addSubview(contentImage)
            contentImage.anchor(top: nil, bottom: nil, leading: nil, trailing: nil, marginTop: 0, marginBottom: 0, marginLeading: 0, marginTrailing: 0, width: 160, height: 160, centerX: centerXAnchor, centerY: centerYAnchor, marginFromCenterX: 0, marginFromCenterY: 0)
            
            contentView.addSubview(waveformImage)
            waveformImage.anchor(top: contentView.topAnchor, bottom: nil, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, marginTop: 16, marginBottom: 0, marginLeading: 0, marginTrailing: 0, width: 0, height: 48, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
            
            contentView.addSubview(contentText)
            contentText.anchor(top: nil, bottom: contentView.bottomAnchor, leading: nil, trailing: nil, marginTop: 0, marginBottom: -26, marginLeading: 0, marginTrailing: 0, width: 0, height: 0, centerX: centerXAnchor, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        }
        
        func updateView() {
            contentImage.image = UIImage(named: "square")
            setNeedsLayout()
            print("jalan")
        }
        
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
