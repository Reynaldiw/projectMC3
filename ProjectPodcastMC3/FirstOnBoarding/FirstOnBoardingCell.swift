//
//  FirstOnBoardingCell.swift
//  ProjectPodcastMC3
//
//  Created by Nani Sukma Putri Pratama on 12/08/20.
//  Copyright © 2020 Reynaldi Wijaya. All rights reserved.
//

import UIKit
class FirstOnBoardingCell: UICollectionViewCell {
    
    var page : FirstCell?{
        didSet{
            guard let unwrapped = page else {return
            }
            onBoardingImage.image = UIImage(named: unwrapped.imageName)
            titleImageOnBoarding.text = unwrapped.titleImageOnboarding
        }
    }
    
    private let onBoardingImage: UIImageView = {
         let imageView = UIImageView(image: #imageLiteral(resourceName: "image_1"))
         imageView.translatesAutoresizingMaskIntoConstraints = false
         imageView.contentMode = .scaleAspectFit
         return imageView
     }()
     
    private let titleOnboarding : UILabel = {
        let textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textColor = .white
        textView.font = UIFont.boldSystemFont(ofSize: 12)
        //Setup font based on design
//        textView.font = UIFont(name:"SF Pro Display-Bold", size: 12.0)
        textView.text = "HOW TO MAKE PODCAST CONTENT FOR SOCIAL MEDIA IN 5 EASY STEP"
        textView.numberOfLines = 2
        textView.textAlignment = .center
        
     return textView
     }()
     private let titleImageOnBoarding : UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .white
        textLabel.textAlignment = .center
        textLabel.numberOfLines = 4
        textLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        //Setup font based on design
//        textLabel.font = UIFont(name:"SF Pro Display-Semibold", size: 16.0)
        return textLabel
     }()
    private func setupContentStack(){
        let contentStack = UIStackView(arrangedSubviews: [titleOnboarding,titleImageOnBoarding,onBoardingImage])
         addSubview(contentStack)
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.distribution = .fillProportionally
        contentStack.axis = .vertical
        contentStack.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        contentStack.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        contentStack.topAnchor.constraint(equalTo:  safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        let height = safeAreaLayoutGuide.heightAnchor
        contentStack.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        contentStack.heightAnchor.constraint(equalTo: height, multiplier: 0.6).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 28/255, green: 28/255, blue: 30/255, alpha: 1.0)
        setupContentStack()
        setupLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout(){
        //for textOnBoarding
        titleOnboarding.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleOnboarding.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.6).isActive = true
        
        //for textImageOnBoarding
        titleImageOnBoarding.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleImageOnBoarding.leftAnchor.constraint(equalTo: leftAnchor, constant: 50).isActive = true
        titleImageOnBoarding.rightAnchor.constraint(equalTo: rightAnchor, constant: -50).isActive = true
        
        //for image
        onBoardingImage.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
         onBoardingImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3).isActive = true
    }
}
