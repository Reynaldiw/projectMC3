//
//  PotraitTemplateCell.swift
//  ProjectPodcastMC3
//
//  Created by Mohamad Naufal Nafian on 12/08/20.
//  Copyright © 2020 Reynaldi Wijaya. All rights reserved.
//

import UIKit

class PotraitTemplateViewCell: UICollectionViewCell {
    
    var potraitTemplateModel: PotraitTemplateModel? {
        didSet {

            imageView.image = UIImage(named: potraitTemplateModel?.imageUrl ?? "defaultimage")
        }
    }
    
    
    let imageView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "defaultimage")
        img.contentMode = .scaleAspectFit
        
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
        //contentView.backgroundColor = .red
        setupLayout()
    }
    
    func showSelection() {
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = CGColor.rgb(red: 255, green: 255, blue: 255, alpha: 1)
    }
    
    func hideSelection() {
        contentView.layer.borderWidth = 0
    }
    
    func setupLayout() {
        //layer.backgroundColor = Theme.current.accentColor as! CGColor
        layer.cornerRadius = 8
        
        addSubview(contentView)
        contentView.anchor(top: topAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, marginTop: 0, marginBottom: 0, marginLeading: 0, marginTrailing: 0, width: 0, height: 0, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        
        contentView.addSubview(imageView)
        imageView.anchor(top: contentView.topAnchor, bottom: contentView.bottomAnchor, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, marginTop: 0, marginBottom: 0, marginLeading: 0, marginTrailing: 0, width: 0, height: 0, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        
        
    }
    
    func updateUI() {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

