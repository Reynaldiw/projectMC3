//
//  CreatePageVC.swift
//  ProjectPodcastMC3
//
//  Created by Mohamad Naufal Nafian on 12/08/20.
//  Copyright © 2020 Reynaldi Wijaya. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

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
    
    var forSendImage: UIImage?
    var forSendWaveformPosition: String?
    var forSendWaveformColor: String?
    var forSendOrientation: String?
    var forSegmentModels: [SegmentModel]?
    
    var refreshDataDelegate: RefreshVideoCollectionsDelegate!
    var customRenderLoading: CustomLoadingRendering!
        
    //navbar
    lazy var backButton: UIButton = {
        let btn = UIButton()
        
        
        let image = UIImage(systemName:"chevron.left")
        btn.setImage(image, for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.imageEdgeInsets = UIEdgeInsets(top:0, left:0, bottom:0, right:0)
        btn.tintColor = Theme.current.blueColor
        
        
        btn.setTitle("Home Page", for: .normal)
        btn.titleEdgeInsets = UIEdgeInsets(top:0, left:0, bottom:0, right:-30)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        //btn.titleLabel?.textColor = Theme.current.blueColor
        btn.setTitleColor(Theme.current.blueColor, for: .normal)
        
        btn.addTarget(self, action: #selector(handleHomepage), for: .touchUpInside)
        
        
        return btn
    }()
    
    
    
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
        btn.addTarget(self, action: #selector(generateVideo), for: .touchUpInside)

        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Theme.current.backgroundColor
        
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.barStyle = .black
        
        let item = UIBarButtonItem(customView: backButton)
        self.navigationItem.setLeftBarButtonItems([item], animated: true)
        
        generateButton.isEnabled = false
        
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
    
    @objc func handleHomepage() {
        
        let navController: UINavigationController = UINavigationController()
        navController.viewControllers = [MainTabBarController()]
        UIApplication.shared.windows.first?.rootViewController = navController
        
        print("clik")
    }
    
    @objc func generateVideo() {
        if !isAudioReady || !isDesignReady {
            print("here")
            createAlertAndShowAlert(title: "Warning!", message: "You have to complete the design and audio", actionName: "Okay, Got It!", caller: self, handler: nil)
            return
        }
    
        
        let uid = KeychainWrapper.standard.string(forKey: Constants.KEY_UID_KEYCHAIN)
        
        print(uid ?? "nil")

        if uid == nil {

            self.navigationController?.present(LoginViewController(), animated: true, completion: nil)

        } else {
            
            showLoading()
            
            guard let waveformPosition = self.forSendWaveformPosition, let waveformColor = self.forSendWaveformColor, let dimension = self.forSendOrientation else { return }

            let params: [String : String] = ["name": "Beauty", "uid": uid!, "waveformPosition" : waveformPosition, "waveformColor" : waveformColor, "dimension" : dimension]
            
            var urls = [URL]()

            if let segmentModels = forSegmentModels {
                for i in 0..<segmentModels.count {
                    if let url = segmentModels[i].urlSegment {
                        urls.append(url)
                    }
                }
            }
            
            let myGroup = DispatchGroup()

            for i in 0..<urls.count {
                myGroup.enter()
                
                let url = urls[i]

                guard let image = forSendImage else { return }
                
                LoginWorker.submitVideo(params: params, podcast: url, designImage: image, onSuccess: { (message) in
                    print("result 1")
                    print(message)
                    myGroup.leave()
                    
                }) { (message) in
                    print(message)
                    myGroup.leave()
                }
            }
            
            myGroup.notify(queue: .main) {
                print("result success")
                self.removeLoading()
                self.refreshDataDelegate.refreshData()
                let navController: UINavigationController = UINavigationController()
                navController.viewControllers = [MainTabBarController()]
                UIApplication.shared.windows.first?.rootViewController = navController
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
    
    private func showLoading() {
        self.customRenderLoading = CustomLoadingRendering()
        view.addSubview(customRenderLoading)
        customRenderLoading.anchor(top: view.topAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, marginTop: 0, marginBottom: 0, marginLeading: 0, marginTrailing: 0, width: 0, height: 0, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        backButton.isHidden = true
    }
    
    private func removeLoading() {
        customRenderLoading.removeFromSuperview()
        backButton.isHidden = false
        customRenderLoading = nil
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
        
        updateStatusOfGenerateButton()
    }
    
    private func updateStatusOfGenerateButton() {
        if isAudioReady && isDesignReady {
            generateButton.isEnabled = true
            generateButton.alpha = 1
        } else {
            generateButton.isEnabled = false
            generateButton.alpha = 0.3
        }
    }

}


extension CreateViewController: designReadyDelegate {
    
    func waveformColor(color: UIColor) {
        let hexString = color.toHexString()
        self.forSendWaveformColor = hexString
    }
    
    func waveformPosition(position: String) {
        self.forSendWaveformPosition = position
    }
    
    func imageForSend(image: UIImage) {
        self.forSendImage = image
    }
    
    
    
    func isDesignPotrait(potrait: Bool) {
        if potrait == false {
            self.forSendOrientation = "square"
            designResultHeightAnchor1?.isActive = false
            designResultHeightAnchor2?.isActive = true
            
        } else {
            self.forSendOrientation = "potrait"
            designResultHeightAnchor2?.isActive = false
            designResultHeightAnchor1?.isActive = true
        }
    }
    
    func imageReady(image: UIImage) {
        designResultImage.image = image

    }
    
    func didDesignReady(isReady: Bool) {
        self.isDesignReady = isReady
        
        updateStatusOfGenerateButton()
        
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
    
    func didAudioReady(isReady: Bool) {
        self.isAudioReady = isReady
        
        updateStatusOfGenerateButton()
        
        if isAudioReady {
            view.addSubview(audioResultView)
            audioResultView.anchor(top: audioButtonView.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, marginTop: 20, marginBottom: 0, marginLeading: 20, marginTrailing: -20, width: 0, height: 95, centerX: view.centerXAnchor, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
            confirmAudioButton.isHidden = false
            audioResultView.isHidden = false
        } else {
            confirmAudioButton.isHidden = true
            audioResultView.isHidden = true
            audioResultView.removeFromSuperview()
        }
    }
    
    func audioReady(model: [SegmentModel]) {
        forSegmentModels = model
    }

}
