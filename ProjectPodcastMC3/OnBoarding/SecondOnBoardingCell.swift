//
//  SecondOnBoardingCell.swift
//  ProjectPodcastMC3
//
//  Created by Nani Sukma Putri Pratama on 12/08/20.
//  Copyright © 2020 Reynaldi Wijaya. All rights reserved.
//

import UIKit
class SecondOnBoardingCell: UICollectionViewCell {
    
    var info : SecondCell?{
        didSet{
            guard let unwrapped = info else {return
            }
            contentImage.image = UIImage(named: unwrapped.imageContent)
            sizeLabel.text = unwrapped.sizeContent
            recommendedLabel.text = unwrapped.durationContent
            explainLabel.text = unwrapped.explainationContent
            
        }
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let contentImage : UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "image_4"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let sizeLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 21.0)
        //Setup font based on design
//        label.font = UIFont(name:"SF Pro Display-Semibold", size: 21.0)
        label.textAlignment = .center
        return label
    }()
    private let recommendedLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
         //Setup font based on design
//        label.font = UIFont(name:"SF Pro Display-Light", size: 21.0)
        label.font = label.font.withSize(21)
        label.textAlignment = .center
            return label
        }()
    private let explainLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 5
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
//        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        label.textAlignment = .center
//      //Setup font based on design
//        label.font = UIFont(name:"SF Pro Text-Regular", size: 16.0)
        return label
    }()

    private lazy var setupRecommended : UIStackView = {
        let recommendStack = UIStackView(arrangedSubviews: [sizeLabel, recommendedLabel])
//        addSubview(recommendStack)
        recommendStack.translatesAutoresizingMaskIntoConstraints = false
        recommendStack.distribution = .fill
        recommendStack.spacing = 0
        recommendStack.axis = .vertical
        return recommendStack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setupContent()
        setupComponentStack()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupComponentStack(){
        //for title
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
//        for image
        contentImage.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        contentImage.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5).isActive = true
        
        //for center of stackview
        setupRecommended.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        // For explainLabel
        explainLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
    }
    
    private func setupContent(){
        let content = UIStackView(arrangedSubviews: [titleLabel,contentImage,setupRecommended, explainLabel])
        addSubview(content)
        content.translatesAutoresizingMaskIntoConstraints = false
        content.distribution = .fillProportionally
        content.axis = .vertical
        content.spacing = 25
        content.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor , constant: 30).isActive = true
        content.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
        content.topAnchor.constraint(equalTo:  safeAreaLayoutGuide.topAnchor , constant: 70).isActive = true
        content.centerYAnchor.constraint(greaterThanOrEqualTo: centerYAnchor, constant: -100).isActive = true
            
    }
    
}


