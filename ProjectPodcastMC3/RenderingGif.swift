//
//  RenderingGif.swift
//  ProjectPodcastMC3
//
//  Created by Naratama on 13/08/20.
//  Copyright © 2020 Reynaldi Wijaya. All rights reserved.
//

import UIKit

class RenderingGif: UIView {


        let contentView = UIView()
        
        var imageView : UIImageView = {
            let jeremyGif = UIImage.gifImageWithName("giphy")
            let imageView = UIImageView(image: jeremyGif)
            return imageView
        }()
        
            var contentText : UILabel = {
                let label = UILabel()
                label.text = "Rendering…"
                label.font = UIFont.boldSystemFont(ofSize: 24)
                label.textColor = UIColor.white
                return label
            }()
        
            var contentText2 : UILabel = {
                let label = UILabel()
                label.text = "Wait a few moments for it to finish"
                label.font = UIFont.systemFont(ofSize: 16)
                label.textColor = UIColor.white
                return label
            }()
            
        
            override init(frame: CGRect) {
                super.init(frame: frame)
                
                addSubview(contentView)
                contentView.anchor(top: topAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, marginTop: 0, marginBottom: 0, marginLeading: 0, marginTrailing: 0, width: 0, height: 0, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
                
                contentView.addSubview(imageView)
                imageView.anchor(top: topAnchor, bottom: nil, leading: nil, trailing: nil, marginTop: 124, marginBottom: 0, marginLeading: 0, marginTrailing: 0, width: 326, height: 326, centerX: centerXAnchor, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
                
                contentView.addSubview(contentText)
                contentText.anchor(top: imageView.bottomAnchor, bottom: nil, leading: nil, trailing: nil, marginTop: 80, marginBottom: 0, marginLeading: 0, marginTrailing: 0, width: 0, height: 0, centerX: centerXAnchor, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
                
                contentView.addSubview(contentText2)
                contentText2.anchor(top: contentText.bottomAnchor, bottom: nil, leading: nil, trailing: nil, marginTop: 10, marginBottom: 0, marginLeading: 0, marginTrailing: 0, width: 0, height: 0, centerX: centerXAnchor, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
            }
            
            required init?(coder: NSCoder) {
                fatalError("init(coder:) has not been implemented")
            }
        }
