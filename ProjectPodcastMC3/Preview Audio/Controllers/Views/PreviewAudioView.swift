//
//  PreviewAudioView.swift
//  ProjectPodcastMC3
//
//  Created by Reynaldi Wijaya on 07/08/20.
//  Copyright © 2020 Reynaldi Wijaya. All rights reserved.
//

import UIKit

class PreviewAudioView: UIView {
    
    lazy var playAudioButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "play"), for: .normal)
        return button
    }()
    
    lazy var timeLengthAudioLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    lazy var editStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    lazy var editLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Edit"
        label.textAlignment = .center
        return label
    }()
    
    lazy var buttonEdit: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "scissor"), for: .normal)
        return button
    }()
    
    lazy var audioStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }()
    
    lazy var audioLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Audio"
        label.textAlignment = .center
        return label
    }()
    
    lazy var buttonAudio: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "audio"), for: .normal)
        return button
    }()
    
    lazy var segmentCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        flowLayout.minimumInteritemSpacing = 8
        flowLayout.minimumLineSpacing = 8
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = Colors.BG_SCREEN_DARK_PURPLE
        
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        self.addSubview(playAudioButton)
        self.addSubview(timeLengthAudioLabel)
        self.addSubview(editStackView)
        editStackView.addArrangedSubview(buttonEdit)
        editStackView.addArrangedSubview(editLabel)
        self.addSubview(audioStackView)
        audioStackView.addArrangedSubview(buttonAudio)
        audioStackView.addArrangedSubview(audioLabel)
        self.addSubview(segmentCollectionView)
    }
    
    private func setupConstraints() {
        playAudioButton.layer.cornerRadius = 41
        buttonEdit.layer.cornerRadius = 24
        buttonAudio.layer.cornerRadius = 24
        
        playAudioButton.anchor(top: nil, bottom: nil, leading: nil, trailing: nil, marginTop: 0, marginBottom: 0, marginLeading: 0, marginTrailing: 0, width: 82, height: 86, centerX: self.centerXAnchor, centerY: self.centerYAnchor, marginFromCenterX: 0, marginFromCenterY: -20)
        
        timeLengthAudioLabel.anchor(top: playAudioButton.bottomAnchor, bottom: nil, leading: self.leadingAnchor, trailing: self.trailingAnchor, marginTop: 8, marginBottom: 0, marginLeading: 30, marginTrailing: -30, width: 0, height: 0, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        
        editStackView.anchor(top: nil, bottom: safeAreaLayoutGuide.bottomAnchor, leading: self.leadingAnchor, trailing: nil, marginTop: 0, marginBottom: -35, marginLeading: 35, marginTrailing: 0, width: 48, height: 75, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        
        audioStackView.anchor(top: nil, bottom: safeAreaLayoutGuide.bottomAnchor, leading: nil, trailing: self.trailingAnchor, marginTop: 0, marginBottom: -35, marginLeading: 0, marginTrailing: -35, width: 48, height: 75, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        
        segmentCollectionView.anchor(top: safeAreaLayoutGuide.topAnchor, bottom: editStackView.topAnchor, leading: self.leadingAnchor, trailing: self.trailingAnchor, marginTop: 20, marginBottom: 20, marginLeading: 0, marginTrailing: 0, width: 0, height: 0, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        segmentCollectionView.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
