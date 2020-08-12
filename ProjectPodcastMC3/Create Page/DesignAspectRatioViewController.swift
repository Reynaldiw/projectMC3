//
//  DesignAspectRatioViewController.swift
//  ProjectPodcastMC3
//
//  Created by Mohamad Naufal Nafian on 12/08/20.
//  Copyright © 2020 Reynaldi Wijaya. All rights reserved.
//

import UIKit

class DesignAspectRatioViewController: UIViewController {
    
    var isPotraitActive = true
    var designDelegate: designReadyDelegate?

    lazy var potraitImage: UIImageView = {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(onClickPotrait))
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        
        let img = UIImageView()
        img.image = UIImage(named: "potrait")
        //img.alpha = 0.6
        img.isUserInteractionEnabled = true
        img.addGestureRecognizer(tap)
        
        return img
    }()
    
    lazy var squareImage: UIImageView = {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(onClickSquare))
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        
        let img = UIImageView()
        img.image = UIImage(named: "square")
        img.alpha = 0.6
        img.isUserInteractionEnabled = true
        img.addGestureRecognizer(tap)
        
        return img
    }()
    
    let typeLabel : UILabel = {
        let label = UILabel()
        label.text = "POTRAIT"
        label.font = UIFont.boldSystemFont(ofSize: 21)
        label.textColor = Theme.current.textColor1
        label.textAlignment = .center
        
        return label
    }()
    
    let ratioLabel : UILabel = {
        let label = UILabel()
        label.text = "1080 x 1080 pixels"
        label.font = UIFont.systemFont(ofSize: 21)
        label.textColor = Theme.current.textColor1
        label.textAlignment = .center
        return label
    }()
    
    let subLabel : UILabel = {
        let label = UILabel()
        label.text = "Recommended for Instagram Story & IGTV"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = Theme.current.textColor2
        label.textAlignment = .center
        return label
    }()
    
    
    //GENERATE BUTTON
    let nextButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Next", for: .normal)
        btn.backgroundColor = Theme.current.blueColor
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 19)
        btn.layer.cornerRadius = 6
        //btn.alpha = 0.3
        btn.addTarget(self, action: #selector(onClickNext), for: .touchUpInside)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Theme.current.backgroundColor
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Choose Aspect Ratio"
        //print("delegete", designDelegate)
        
        setupLayout()
    }
    
    @objc func onClickPotrait() {
        //change to Potrait
        potraitImage.alpha = 1
        squareImage.alpha = 0.6
        typeLabel.text = "POTRAIT"
        ratioLabel.text = "1080 x 1920 pixels"
        subLabel.text = "Recommended for Instagram Story & IGTV"
        isPotraitActive = true
    }
    
    @objc func onClickSquare() {
        //change to Square
        potraitImage.alpha = 0.6
        squareImage.alpha = 1
        typeLabel.text = "SQUARE"
        ratioLabel.text = "1080 x 1080 pixels"
        subLabel.text = "Recommended for Instagram Feed"
        isPotraitActive = false
    }
    
    @objc func onClickNext() {
        
        let ydv = YourDesignViewController()
        ydv.isPotrait = isPotraitActive
        ydv.designReadyDelegate = designDelegate
        
        //print("apakah potrait aktif di vc1", isPotraitActive)
        navigationController?.pushViewController(ydv, animated: true)
    }
    
    func setupLayout() {
        view.addSubview(potraitImage)
        potraitImage.anchor(top: view.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: nil, marginTop: 205, marginBottom: 0, marginLeading: 52, marginTrailing: 0, width: 120, height: 160, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        
        view.addSubview(squareImage)
        squareImage.anchor(top: view.topAnchor, bottom: nil, leading: nil, trailing: view.trailingAnchor, marginTop: 205, marginBottom: 0, marginLeading: 0, marginTrailing: -32, width: 160, height: 160, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        
        view.addSubview(typeLabel)
        typeLabel.anchor(top: potraitImage.bottomAnchor, bottom: nil, leading: nil, trailing: nil, marginTop: 48, marginBottom: 0, marginLeading: 0, marginTrailing: 0, width: 0, height: 0, centerX: view.centerXAnchor, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        
        view.addSubview(ratioLabel)
        ratioLabel.anchor(top: typeLabel.bottomAnchor, bottom: nil, leading: nil, trailing: nil, marginTop: 8, marginBottom: 0, marginLeading: 0, marginTrailing: 0, width: 0, height: 0, centerX: view.centerXAnchor, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        
        view.addSubview(subLabel)
        subLabel.anchor(top: ratioLabel.bottomAnchor, bottom: nil, leading: nil, trailing: nil, marginTop: 20, marginBottom: 0, marginLeading: 0, marginTrailing: 0, width: 0, height: 0, centerX: view.centerXAnchor, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        
        view.addSubview(nextButton)
        nextButton.anchor(top: nil, bottom: view.bottomAnchor, leading: nil, trailing: nil, marginTop: 0, marginBottom: -74, marginLeading: 0, marginTrailing: 0, width: 300, height: 44, centerX: view.centerXAnchor, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
    }
    

}

