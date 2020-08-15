//
//  ImageSquare6Template.swift
//  ProjectPodcastMC3
//
//  Created by Mohamad Naufal Nafian on 13/08/20.
//  Copyright © 2020 Reynaldi Wijaya. All rights reserved.
//
import UIKit

class ImageSquare6Template: UIView {

    let contentView = UIView()
        var backgroundImage: UIImageView = {
            let img = UIImageView()
            img.image = UIImage(named: "TemplateKotak5")
            img.contentMode = .scaleToFill
            //img.layer.applySketchShadow(color: .black, alpha: 0.11, x: -1, y: 2, blur: 3, spread: 0)
            //img.addBlurEffect()
            return img
        }()
    
        var boxBlack: UIView = {
            let box = UIView()
            box.backgroundColor = .white
            return box
        }()
        
        var waveformImage: UIImageView = {
            let img = UIImageView()
            img.image = UIImage(named: "waveformnew3")
            img.setImageColor(color: .white)
            //img.contentMode = .scaleToFill
            //img.layer.applySketchShadow(color: .black, alpha: 0.11, x: -1, y: 2, blur: 3, spread: 0)
            //img.addBlurEffect()
            return img
        }()
    
        var contentText : UILabel = {
            let label = UILabel()
            label.text = "Ep 22 : Mental Health"
            label.font = UIFont.systemFont(ofSize: 24)
            label.textColor = UIColor.black
            return label
        }()
        
    
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            addSubview(contentView)
            contentView.anchor(top: topAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, marginTop: 0, marginBottom: 0, marginLeading: 0, marginTrailing: 0, width: 0, height: 0, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
            
            
            contentView.addSubview(backgroundImage)
            backgroundImage.anchor(top: contentView.topAnchor, bottom: contentView.bottomAnchor, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, marginTop: 0, marginBottom: 0, marginLeading: 0, marginTrailing: 0, width: 0, height: 0, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)

            
            contentView.addSubview(waveformImage)
            waveformImage.anchor(top: nil, bottom: contentView.bottomAnchor, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, marginTop: 0, marginBottom: -96, marginLeading: 0, marginTrailing: 0, width: 0, height: 48, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
            
            
            contentView.addSubview(boxBlack)
            boxBlack.anchor(top: nil, bottom: contentView.bottomAnchor, leading: nil, trailing: nil, marginTop: 0, marginBottom: -24, marginLeading: 0, marginTrailing: 0, width: 272, height: 48, centerX: centerXAnchor, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
            
            
            contentView.addSubview(contentText)
            contentText.anchor(top: nil, bottom: contentView.bottomAnchor, leading: nil, trailing: nil, marginTop: 0, marginBottom: -34, marginLeading: 0, marginTrailing: 0, width: 0, height: 0, centerX: centerXAnchor, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        }
        
        func updateView() {
            //contentImage.image = UIImage(named: "square")
            setNeedsLayout()
            print("jalan")
        }
        
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
