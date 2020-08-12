//
//  EditSegmentView.swift
//  ProjectPodcastMC3
//
//  Created by Reynaldi Wijaya on 11/08/20.
//  Copyright © 2020 Reynaldi Wijaya. All rights reserved.
//

import UIKit

class EditSegmentView: UIView {
    
    lazy var editSegmentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 19)
        label.textColor = Colors.GRAY_COLOR
        label.text = "You can edit where the segment starts and ends by clicking the button below"
        label.numberOfLines = 5
        label.textAlignment = .center
        return label
    }()
    
    lazy var editSegmentCV: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flowLayout.minimumInteritemSpacing = 1
        flowLayout.minimumLineSpacing = 1
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    lazy var startSegmentView = TimePickerView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = Colors.BG_EDIT_SEGMENT
        
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        self.addSubview(editSegmentView)
        editSegmentView.addSubview(infoLabel)
        editSegmentView.addSubview(editSegmentCV)
        self.addSubview(startSegmentView)
    }
    
    private func setupConstraints() {
        editSegmentView.anchor(top: self.safeAreaLayoutGuide.topAnchor, bottom: self.bottomAnchor, leading: self.leadingAnchor, trailing: self.trailingAnchor, marginTop: 0, marginBottom: 0, marginLeading: 0, marginTrailing: 0, width: 0, height: 0, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        
        infoLabel.anchor(top: editSegmentView.topAnchor, bottom: nil, leading: editSegmentView.leadingAnchor, trailing: editSegmentView.trailingAnchor, marginTop: 40, marginBottom: 0, marginLeading: 35, marginTrailing: -35, width: 0, height: 60, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        
        editSegmentCV.anchor(top: infoLabel.bottomAnchor, bottom: nil, leading: editSegmentView.leadingAnchor, trailing: editSegmentView.trailingAnchor, marginTop: 60, marginBottom: 0, marginLeading: 0, marginTrailing: 0, width: 0, height: 120, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        
        startSegmentView.anchor(top: safeAreaLayoutGuide.topAnchor, bottom: self.bottomAnchor, leading: self.leadingAnchor, trailing: self.trailingAnchor, marginTop: 0, marginBottom: 0, marginLeading: 0, marginTrailing: 0, width: 0, height: 0, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        startSegmentView.isHidden = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
