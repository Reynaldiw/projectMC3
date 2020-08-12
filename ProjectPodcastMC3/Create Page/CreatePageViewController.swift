//
//  CreatePageVC.swift
//  ProjectPodcastMC3
//
//  Created by Mohamad Naufal Nafian on 12/08/20.
//  Copyright © 2020 Reynaldi Wijaya. All rights reserved.
//

import UIKit

class CreateViewController: UIViewController, UINavigationControllerDelegate {
    
    var isDesignReady: Bool = false
    var isAudioReady: Bool = false
    fileprivate var designResultTopAnchor: NSLayoutConstraint?
    fileprivate var designResultWidthAnchor: NSLayoutConstraint?
    fileprivate var designResultHeightAnchor1: NSLayoutConstraint?
    fileprivate var designResultHeightAnchor2: NSLayoutConstraint?
    fileprivate var designResultCenterXAnchor: NSLayoutConstraint?
    fileprivate var audioButtonTopAnchor1: NSLayoutConstraint?
    fileprivate var audioButtonTopAnchor2: NSLayoutConstraint?
    fileprivate var audioButtonLeadingAnchor: NSLayoutConstraint?
    fileprivate var audioButtonTrailingAnchor: NSLayoutConstraint?
    fileprivate var audioButtonHeightAnchor: NSLayoutConstraint?
    

    
    
    
    //DESIGN
    lazy var designButtonView: UIView = {
    
        let view = UIView()
        view.backgroundColor = Theme.current.accentColor
        view.layer.cornerRadius = 8
        view.isUserInteractionEnabled = true

        
        let tap = UITapGestureRecognizer(target: self, action: #selector(onClickDesignButton))
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        
        view.addGestureRecognizer(tap)
        
        return view
    }()

    let imageDesignButton: UIImageView = {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(onClickDesignButton))
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        
        let img = UIImageView()
        img.image = UIImage(named: "podcast")
        //img.isUserInteractionEnabled = true
        //img.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickDesignButton)))
        
        return img
    }()
    
    let titleDesignButton: UILabel = {
        let label = UILabel()
        label.text = "1. Your Design"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = UIColor.white
        return label
    }()
    
    let subtitleDesignButton: UILabel = {
        let label = UILabel()
        label.text = "We already have a template for you to use, but make it yourself is more fun."
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 2
        label.textColor = Theme.current.textColor2
        return label
    }()
    
    let confirmDesignButton: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "foursquare-check-in")
        //img.tintColor = .green
        return img
    }()
    
    let designResultImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "posters")
        return img
    }()
    
    
    
    //AUDIO
    lazy var audioButtonView: UIView = {
        let view = UIView()
        view.backgroundColor = Theme.current.accentColor
        view.layer.cornerRadius = 8
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(onClickAudioButton))
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        
        view.addGestureRecognizer(tap)
        
        return view
    }()
    
    let imageAudioButton: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "music-and-multimedia")
        img.contentMode = .scaleToFill
        
        return img
    }()
    
    let titleAudioButton: UILabel = {
        let label = UILabel()
        label.text = "2. Your Audio"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = UIColor.white
        return label
    }()
    
    let subtitleAudioButton: UILabel = {
        let label = UILabel()
        label.text = "Choose your podcast or upload an audio file then you'll able to edit your audio."
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 2
        label.textColor = Theme.current.textColor2
        return label
    }()
    
    let confirmAudioButton: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "foursquare-check-in")
        //img.tintColor = .green
        return img
    }()
    
    
    //ResultAUDIO
    let audioResultView: UIView = {
        let view = UIView()
        view.backgroundColor = Theme.current.accentColor
        view.layer.cornerRadius = 8
        //view.isHidden = true
        return view
    }()
    
    let playIconAudioResult: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "play-button")
        return img
    }()
    
    
    let titleAudioResult: UILabel = {
        let label = UILabel()
        label.text = "Audio File"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = UIColor.white
        return label
    }()
    
    let subtitleAudioResult: UILabel = {
        let label = UILabel()
        label.text = "10.00"
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 1
        label.textColor = Theme.current.textColor2
        return label
    }()
    
    let optionIconAudioResult: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "threedot")
        return img
    }()
    
    //GENERATE BUTTON
    let generateButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Generate Video", for: .normal)
        btn.backgroundColor = Theme.current.blueColor
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 19)
        btn.layer.cornerRadius = 6
        btn.alpha = 0.3

        return btn
    }()
    
    
    

        
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Theme.current.backgroundColor
        //view.backgroundColor = UIColor.white
       // navigationController?.navigationBar.barTintColor = Theme.current.backgroundColor
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController!.navigationBar.barStyle = .black
        
        //navigationController?.navigationItem.title = "cekcek"
        //self.navigationController!.navigationBar.isTranslucent = true
        navigationItem.title = "Create Page"
        dynamicAnchor()
        setupLayout()
    }
    
    
    
    func dynamicAnchor() {
        designResultTopAnchor = designResultImage.topAnchor.constraint(equalTo: designButtonView.bottomAnchor, constant: 16)
        designResultWidthAnchor = designResultImage.widthAnchor.constraint(equalToConstant: 114)
        designResultHeightAnchor1 = designResultImage.heightAnchor.constraint(equalToConstant: 200)
        designResultHeightAnchor2 = designResultImage.heightAnchor.constraint(equalToConstant: 114)
        designResultCenterXAnchor = designResultImage.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0)
        audioButtonTopAnchor1 = audioButtonView.topAnchor.constraint(equalTo: designButtonView.bottomAnchor, constant: 20)
        audioButtonTopAnchor2 = audioButtonView.topAnchor.constraint(equalTo: designResultImage.bottomAnchor, constant: 20)
        
        audioButtonLeadingAnchor = audioButtonView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        audioButtonTrailingAnchor = audioButtonView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        audioButtonHeightAnchor = audioButtonView.heightAnchor.constraint(equalToConstant: 95)
    }
    
    
    @objc func onClickDesignButton() {
        
        let davc = DesignAspectRatioViewController()
        davc.designDelegate = self
        navigationController?.pushViewController(davc, animated: true)
        
    }
    
    @objc func onClickAudioButton() {
        
        let yavc = YourAudioVC()
        yavc.designDelegate = self
        navigationController?.pushViewController(yavc, animated: true)
        
    }
    
    
    
    
    
    
    func setupLayout() {
        designButtonLayout()
        audioButtonLayout()
        generateButtonLayout()
    }
    
    func layoutDidChangeDesign() {
        
    }
    
    func designButtonLayout() {
        //FIRST BUTTON
        view.addSubview(designButtonView)
        designButtonView.anchor(top: view.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, marginTop: 158, marginBottom: 0, marginLeading: 20, marginTrailing: -20, width: 0, height: 95, centerX: view.centerXAnchor, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        
        designButtonView.addSubview(imageDesignButton)
        imageDesignButton.anchor(top: designButtonView.topAnchor, bottom: designButtonView.bottomAnchor, leading: designButtonView.leadingAnchor, trailing: nil, marginTop: 24, marginBottom: -23, marginLeading: 16, marginTrailing: -310, width: 48, height: 48, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        
        designButtonView.addSubview(titleDesignButton)
        titleDesignButton.anchor(top: designButtonView.topAnchor, bottom: nil, leading: designButtonView.leadingAnchor, trailing: nil, marginTop: 16, marginBottom: 0, marginLeading: 80, marginTrailing: 0, width: 0, height: 0, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        
        designButtonView.addSubview(subtitleDesignButton)
        subtitleDesignButton.anchor(top: titleDesignButton.bottomAnchor, bottom: designButtonView.bottomAnchor, leading: designButtonView.leadingAnchor, trailing: designButtonView.trailingAnchor, marginTop: 10, marginBottom: -18, marginLeading: 80, marginTrailing: -26, width: 0, height: 0, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        
        designButtonView.addSubview(confirmDesignButton)
        confirmDesignButton.anchor(top: designButtonView.topAnchor, bottom: nil, leading: titleDesignButton.trailingAnchor, trailing: nil, marginTop: 16, marginBottom: 0, marginLeading: 10, marginTrailing: 0, width: 21, height: 21, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        
        //IMAGE PREVIEW
        view.addSubview(designResultImage)
        designResultImage.translatesAutoresizingMaskIntoConstraints = false
        designResultTopAnchor?.isActive = false
        designResultWidthAnchor?.isActive = false
        designResultHeightAnchor1?.isActive = false
        designResultCenterXAnchor?.isActive = false
    }
    
    func audioButtonLayout() {
        
        //SECOND BUTTON
        view.addSubview(audioButtonView)
        audioButtonView.translatesAutoresizingMaskIntoConstraints = false
        confirmDesignButton.isHidden = true
        designResultImage.removeFromSuperview()
        audioButtonTopAnchor1?.isActive = true
        audioButtonLeadingAnchor?.isActive = true
        audioButtonTrailingAnchor?.isActive = true
        audioButtonHeightAnchor?.isActive = true
        
        
        audioButtonView.addSubview(imageAudioButton)
        imageAudioButton.anchor(top: audioButtonView.topAnchor, bottom: audioButtonView.bottomAnchor, leading: audioButtonView.leadingAnchor, trailing: nil, marginTop: 24, marginBottom: -23, marginLeading: 16, marginTrailing: -310, width: 48, height: 48, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        
        audioButtonView.addSubview(titleAudioButton)
        titleAudioButton.anchor(top: audioButtonView.topAnchor, bottom: nil, leading: audioButtonView.leadingAnchor, trailing: nil, marginTop: 16, marginBottom: 0, marginLeading: 80, marginTrailing: 0, width: 0, height: 0, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        
        audioButtonView.addSubview(subtitleAudioButton)
        subtitleAudioButton.anchor(top: titleAudioButton.bottomAnchor, bottom: audioButtonView.bottomAnchor, leading: audioButtonView.leadingAnchor, trailing: audioButtonView.trailingAnchor, marginTop: 10, marginBottom: -18, marginLeading: 80, marginTrailing: -26, width: 0, height: 0, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        
        audioButtonView.addSubview(confirmAudioButton)
        confirmAudioButton.anchor(top: audioButtonView.topAnchor, bottom: nil, leading: titleAudioButton.trailingAnchor, trailing: nil, marginTop: 16, marginBottom: 0, marginLeading: 10, marginTrailing: 0, width: 21, height: 21, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        
        
        //Preview Audio
        if isAudioReady == true {
            view.addSubview(audioResultView)
            audioResultView.anchor(top: audioButtonView.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, marginTop: 20, marginBottom: 0, marginLeading: 20, marginTrailing: -20, width: 0, height: 95, centerX: view.centerXAnchor, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        } else {
            confirmAudioButton.isHidden = true
            audioResultView.isHidden = true
        }
        
        audioResultView.addSubview(playIconAudioResult)
        playIconAudioResult.anchor(top: audioResultView.topAnchor, bottom: audioResultView.bottomAnchor, leading: audioResultView.leadingAnchor, trailing: audioResultView.trailingAnchor, marginTop: 24, marginBottom: -23, marginLeading: 16, marginTrailing: -310, width: 0, height: 0, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        
        
        audioResultView.addSubview(titleAudioResult)
        titleAudioResult.anchor(top: audioResultView.topAnchor, bottom: nil, leading: audioResultView.leadingAnchor, trailing: nil, marginTop: 21, marginBottom: 0, marginLeading: 80, marginTrailing: 0, width: 0, height: 0, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        
        audioResultView.addSubview(subtitleAudioResult)
        subtitleAudioResult.anchor(top: titleAudioResult.bottomAnchor, bottom: audioResultView.bottomAnchor, leading: audioResultView.leadingAnchor, trailing: nil, marginTop: 4, marginBottom: -22, marginLeading: 80, marginTrailing: -26, width: 0, height: 0, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        
        audioResultView.addSubview(optionIconAudioResult)
        optionIconAudioResult.anchor(top: nil, bottom: nil, leading: nil, trailing: audioResultView.trailingAnchor, marginTop: 0, marginBottom: 0, marginLeading: 0, marginTrailing: -20, width: 26, height: 6, centerX: nil, centerY: audioResultView.centerYAnchor, marginFromCenterX: 0, marginFromCenterY: 0)
    }
    
    func generateButtonLayout() {
        //Button
        view.addSubview(generateButton)
        generateButton.anchor(top: nil, bottom: view.bottomAnchor, leading: nil, trailing: nil, marginTop: 0, marginBottom: -74, marginLeading: 0, marginTrailing: 0, width: 300, height: 44, centerX: view.centerXAnchor, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        
        if isAudioReady == true && isDesignReady == true {
            generateButton.alpha = 1
        }
    }

}


extension CreateViewController: designReadyDelegate {
    
    
    func isDesignPotrait(potrait: Bool) {
        if potrait == false {
            designResultHeightAnchor1?.isActive = false
            designResultHeightAnchor2?.isActive = true
        } else {
            designResultHeightAnchor2?.isActive = false
            designResultHeightAnchor1?.isActive = true
            
        }
    }
    
    func imageReady(image: UIImage) {
        designResultImage.image = image
    }
    
    func didDesignReady(isReady: Bool) {
        self.isDesignReady = isReady
        if isDesignReady == true {
            confirmDesignButton.isHidden = false
            view.addSubview(designResultImage)
            designResultTopAnchor?.isActive = true
            designResultWidthAnchor?.isActive = true
            designResultHeightAnchor1?.isActive = true
            designResultCenterXAnchor?.isActive = true
            audioButtonTopAnchor1?.isActive = false
            audioButtonTopAnchor2?.isActive = true
        } else {

            confirmDesignButton.isHidden = true
            designResultImage.removeFromSuperview()
            audioButtonTopAnchor2?.isActive = false
            audioButtonTopAnchor1?.isActive = true
            audioButtonLeadingAnchor?.isActive = true
            audioButtonTrailingAnchor?.isActive = true
            audioButtonHeightAnchor?.isActive = true
        }
    }

}
