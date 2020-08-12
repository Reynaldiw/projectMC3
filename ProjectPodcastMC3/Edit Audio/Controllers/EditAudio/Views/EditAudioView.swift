//
//  EditAudioView.swift
//  ProjectPodcastMC3
//
//  Created by Reynaldi Wijaya on 10/08/20.
//  Copyright © 2020 Reynaldi Wijaya. All rights reserved.
//

import UIKit

class EditAudioView: UIView {
    
    lazy var doneButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Colors.PURPLE_COLOR
        button.setTitle("Done", for: .normal)
        button.titleLabel?.textColor = .white
        return button
    }()
    
    lazy var view: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.BG_SCREEN_PURPLE_GRAY
        return view
    }()
    
    lazy var slider: UISlider = {
        let slider = UISlider()
        return slider
    }()
    
    lazy var waveFormImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "waveForm")
        return imageView
    }()
    
    lazy var timeLengthOfAudio: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.textColor = .gray
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }()
    
    lazy var leftControlOfAudioStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.spacing = 0
        return stackView
    }()
    
    lazy var rightControlOfAudioStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.spacing = 0
        return stackView
    }()
    
    lazy var playPauseButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "play"), for: .normal)
        return button
    }()
    
    lazy var reverseButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "reverse"), for: .normal)
        return button
    }()
    
    lazy var fastRightButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "fastRight"), for: .normal)
        return button
    }()
    
    lazy var previeousLeftButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "previeousLeft"), for: .normal)
        return button
    }()
    
    lazy var nextRightButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "nextRight"), for: .normal)
        return button
    }()
    
    lazy var addSegmentButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle("Add Segment", for: .normal)
        button.titleLabel?.textColor = .white
        return button
    }()

    lazy var viewOfCollectionView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var segmentCV: UICollectionView = {
       let flowLayout = UICollectionViewFlowLayout()
       flowLayout.scrollDirection = .vertical
       flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
       flowLayout.minimumInteritemSpacing = 8
       flowLayout.minimumLineSpacing = 8
       
       let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
       collectionView.backgroundColor = .clear
       return collectionView
    }()
    
    lazy var stackInfoSegmentView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.spacing = 12
        return stackView
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "search")
        return imageView
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 17)
        label.text = "Still Empty, let's create a segment"
        label.numberOfLines = 5
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Colors.BG_SCREEN_DARK_PURPLE
        
        setupView()
        setupConstraints()
    }
    
    private func setupView() {
        self.addSubview(doneButton)
        self.addSubview(view)
        view.addSubview(slider)
        view.addSubview(waveFormImageView)
        view.addSubview(timeLengthOfAudio)
        view.addSubview(playPauseButton)
        view.addSubview(leftControlOfAudioStackView)
        leftControlOfAudioStackView.addArrangedSubview(previeousLeftButton)
        leftControlOfAudioStackView.addArrangedSubview(reverseButton)
        view.addSubview(rightControlOfAudioStackView)
        rightControlOfAudioStackView.addArrangedSubview(fastRightButton)
        rightControlOfAudioStackView.addArrangedSubview(nextRightButton)
        view.addSubview(addSegmentButton)
        view.addSubview(viewOfCollectionView)
        viewOfCollectionView.addSubview(segmentCV)
        viewOfCollectionView.addSubview(stackInfoSegmentView)
        stackInfoSegmentView.addArrangedSubview(imageView)
        stackInfoSegmentView.addArrangedSubview(label)
    }
    
    private func setupConstraints() {
        doneButton.layer.cornerRadius = 7
        doneButton.anchor(top: nil, bottom: self.safeAreaLayoutGuide.bottomAnchor, leading: self.leadingAnchor, trailing: self.trailingAnchor, marginTop: 0, marginBottom: -10, marginLeading: 30, marginTrailing: -30, width: 0, height: 44, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        
        view.layer.cornerRadius = 7
        view.anchor(top: safeAreaLayoutGuide.topAnchor, bottom: doneButton.topAnchor, leading: self.leadingAnchor, trailing: self.trailingAnchor, marginTop: 15, marginBottom: -22, marginLeading: 30, marginTrailing: -30, width: 0, height: 0, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        
        slider.anchor(top: view.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, marginTop: 13, marginBottom: 0, marginLeading: 15, marginTrailing: -15, width: 0, height: 0, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        
        waveFormImageView.anchor(top: slider.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, marginTop: 30, marginBottom: 0, marginLeading: 25, marginTrailing: -25, width: 0, height: 48, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        
        timeLengthOfAudio.anchor(top: waveFormImageView.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, marginTop: 40, marginBottom: 0, marginLeading: 15, marginTrailing: -15, width: 0, height: 20, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        
        playPauseButton.anchor(top: timeLengthOfAudio.bottomAnchor, bottom: nil, leading: nil, trailing: nil, marginTop: 18, marginBottom: 0, marginLeading: 0, marginTrailing: 0, width: 48, height: 48, centerX: view.centerXAnchor, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        
        leftControlOfAudioStackView.anchor(top: timeLengthOfAudio.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: playPauseButton.leadingAnchor, marginTop: 18, marginBottom: 0, marginLeading: 15, marginTrailing: -8, width: 0, height: 50, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        
        rightControlOfAudioStackView.anchor(top: timeLengthOfAudio.bottomAnchor, bottom: nil, leading: playPauseButton.trailingAnchor, trailing: view.trailingAnchor, marginTop: 18, marginBottom: 0, marginLeading: 8, marginTrailing: -15, width: 0, height: 50, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        
        addSegmentButton.anchor(top: nil, bottom: view.bottomAnchor, leading: nil, trailing: nil, marginTop: 0, marginBottom: -15, marginLeading: 0, marginTrailing: 0, width: 0, height: 40, centerX: view.centerXAnchor, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        addSegmentButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        addSegmentButton.layer.cornerRadius = 20
        addSegmentButton.layer.borderWidth = 1
        addSegmentButton.layer.borderColor = UIColor.white.cgColor
        
        viewOfCollectionView.anchor(top: playPauseButton.bottomAnchor, bottom: addSegmentButton.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, marginTop: 25, marginBottom: -20, marginLeading: 0, marginTrailing: 0, width: 0, height: 0, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        
        segmentCV.anchor(top: viewOfCollectionView.topAnchor, bottom: viewOfCollectionView.bottomAnchor, leading: viewOfCollectionView.leadingAnchor, trailing: viewOfCollectionView.trailingAnchor, marginTop: 0, marginBottom: 0, marginLeading: 0, marginTrailing: 0, width: 0, height: 0, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        segmentCV.isHidden = true
        
        stackInfoSegmentView.anchor(top: nil, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, marginTop: 0, marginBottom: 0, marginLeading: 20, marginTrailing: -20, width: 0, height: 80, centerX: nil, centerY: viewOfCollectionView.centerYAnchor, marginFromCenterX: 0, marginFromCenterY: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
