//
//  EditSegmentCell.swift
//  ProjectPodcastMC3
//
//  Created by Reynaldi Wijaya on 12/08/20.
//  Copyright © 2020 Reynaldi Wijaya. All rights reserved.
//

import UIKit

class EditSegmentCell: UICollectionViewCell {
    
    lazy var segmentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.spacing = 0
        return stackView
    }()
    
    lazy var segmentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    lazy var timeSegmentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    lazy var rightArrow: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "rightArrow")
        return image
    }()
    
    lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.BG_LINE
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(red: 0.17, green: 0.17, blue: 0.18, alpha: 1.00)
        
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        self.addSubview(segmentStackView)
        self.addSubview(rightArrow)
        segmentStackView.addArrangedSubview(segmentLabel)
        segmentStackView.addArrangedSubview(timeSegmentLabel)
        self.addSubview(separatorView)
    }
    
    private func setupConstraints() {
        segmentStackView.anchor(top: self.topAnchor, bottom: self.bottomAnchor, leading: self.leadingAnchor, trailing: rightArrow.leadingAnchor, marginTop: 0, marginBottom: 0, marginLeading: 15, marginTrailing: -15, width: 0, height: 0, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        
        rightArrow.anchor(top: self.topAnchor, bottom: self.bottomAnchor, leading: nil, trailing: self.trailingAnchor, marginTop: 0, marginBottom: 0, marginLeading: 0, marginTrailing: -10, width: 12, height: 0, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        
        separatorView.anchor(top: segmentStackView.bottomAnchor, bottom: nil, leading: self.leadingAnchor, trailing: self.trailingAnchor, marginTop: 0, marginBottom: 0, marginLeading: 0, marginTrailing: 0, width: 0, height: 0.5, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
