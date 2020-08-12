//
//  SquareReusableView.swift
//  ProjectPodcastMC3
//
//  Created by Mohamad Naufal Nafian on 12/08/20.
//  Copyright © 2020 Reynaldi Wijaya. All rights reserved.
//

import UIKit

class ImageSquare1Template: UIView {
    
    let pictString: String = "FreddieSquare"
    let exText: String = "Lover of Life Singer of Song"
    
    let contentView = UIView()
    var backgroundImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "FreddieSquare")
        img.contentMode = .scaleToFill
        //img.layer.applySketchShadow(color: .black, alpha: 0.11, x: -1, y: 2, blur: 3, spread: 0)
        img.addBlurEffect()
        return img
    }()
    
    var contentImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "FreddieSquare")
        img.contentMode = .scaleToFill
        img.layer.applySketchShadow(color: .black, alpha: 0.11, x: -1, y: 2, blur: 3, spread: 0)
        //img.addBlurEffect()
        return img
    }()
    
    var waveformImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "waveformnew3")
        //img.tintColor = .red
        //img.contentMode = .scaleToFill
        //img.layer.applySketchShadow(color: .black, alpha: 0.11, x: -1, y: 2, blur: 3, spread: 0)
        //img.addBlurEffect()
        return img
    }()
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(contentView)
        contentView.anchor(top: topAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, marginTop: 0, marginBottom: 0, marginLeading: 0, marginTrailing: 0, width: 0, height: 0, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        contentView.addSubview(backgroundImage)
        backgroundImage.anchor(top: contentView.topAnchor, bottom: contentView.bottomAnchor, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, marginTop: 0, marginBottom: 0, marginLeading: 0, marginTrailing: 0, width: 0, height: 0, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        
        contentView.addSubview(contentImage)
        contentImage.anchor(top: nil, bottom: nil, leading: nil, trailing: nil, marginTop: 0, marginBottom: 0, marginLeading: 0, marginTrailing: 0, width: 220, height: 220, centerX: centerXAnchor, centerY: centerYAnchor, marginFromCenterX: 0, marginFromCenterY: -30)
        
        contentView.addSubview(waveformImage)
        waveformImage.anchor(top: nil, bottom: nil, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, marginTop: 20, marginBottom: -75, marginLeading: 32, marginTrailing: -32, width: 0, height: 60, centerX: nil, centerY: bottomAnchor, marginFromCenterX: 0, marginFromCenterY: -50)
        //waveformImage.setImageColor(color: .red)
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


class ImageSquare2Template: UIView {
    
    let pictString: String = "FreddieSquare"
    let exText: String = "Lover of Life Singer of Song"
    
    let contentView = UIView()
    
    let textContainer : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.applySketchShadow()
        return view
    }()
    
    var titleText : UILabel = {
        let label = UILabel()
        label.text = "Lover of Life, Singer of Song"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .black
        //label.backgroundColor = .lightGray
        
        
        return label
    }()
    
    
    var backgroundImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "FreddieSquare")
        img.contentMode = .scaleToFill
        //img.layer.applySketchShadow(color: .black, alpha: 0.11, x: -1, y: 2, blur: 3, spread: 0)
        img.addBlurEffect()
        return img
    }()
    
    var contentImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "FreddieSquare")
        img.contentMode = .scaleToFill
        img.layer.applySketchShadow(color: .black, alpha: 0.11, x: -1, y: 2, blur: 3, spread: 0)
        //img.addBlurEffect()
        return img
    }()
    
    var waveformImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "waveformnew3")
        //img.contentMode = .scaleToFill
        //img.layer.applySketchShadow(color: .black, alpha: 0.11, x: -1, y: 2, blur: 3, spread: 0)
        //img.addBlurEffect()
        return img
    }()
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(contentView)
        contentView.anchor(top: topAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, marginTop: 0, marginBottom: 0, marginLeading: 0, marginTrailing: 0, width: 0, height: 0, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        contentView.addSubview(backgroundImage)
        backgroundImage.anchor(top: contentView.topAnchor, bottom: contentView.bottomAnchor, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, marginTop: 0, marginBottom: 0, marginLeading: 0, marginTrailing: 0, width: 0, height: 0, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        
        contentView.addSubview(textContainer)
        textContainer.anchor(top: contentView.topAnchor, bottom: nil, leading: nil, trailing: nil, marginTop: 20, marginBottom: 0, marginLeading: 0, marginTrailing: 0, width: 268, height: 32, centerX: contentView.centerXAnchor, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        
        textContainer.addSubview(titleText)
        titleText.anchor(top: nil, bottom: nil, leading: textContainer.leadingAnchor, trailing: textContainer.trailingAnchor, marginTop: 0, marginBottom: 0, marginLeading: 0, marginTrailing: 0, width: 0, height: 0, centerX: nil, centerY: textContainer.centerYAnchor, marginFromCenterX: 0, marginFromCenterY: 0)
        
        contentView.addSubview(contentImage)
        contentImage.anchor(top: textContainer.bottomAnchor, bottom: nil, leading: nil, trailing: nil, marginTop: 16, marginBottom: 0, marginLeading: 0, marginTrailing: 0, width: 220, height: 220, centerX: contentView.centerXAnchor, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        
        contentView.addSubview(waveformImage)
        waveformImage.anchor(top: nil, bottom: nil, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, marginTop: 20, marginBottom: -75, marginLeading: 32, marginTrailing: -32, width: 0, height: 60, centerX: nil, centerY: bottomAnchor, marginFromCenterX: 0, marginFromCenterY: -50)
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
