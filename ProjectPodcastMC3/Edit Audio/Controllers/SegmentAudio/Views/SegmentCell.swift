//
//  SegmentCell.swift
//  ProjectPodcastMC3
//
//  Created by Reynaldi Wijaya on 12/08/20.
//  Copyright © 2020 Reynaldi Wijaya. All rights reserved.
//

import UIKit

class SegmentCell: UICollectionViewCell {
    
    var segmentModel: SegmentModel? {
        didSet {
            updateUI()
        }
    }
        
    lazy var playButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "playPurple"), for: .normal)
        return button
    }()
    
    lazy var stackVerticalView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .equalSpacing
        stackView.spacing = 0
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()
    
    lazy var rangeTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    lazy var moreButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "more"), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = Colors.BG_SEGMENT_CELL
        self.layer.cornerRadius = 10
        
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        self.addSubview(playButton)
        self.addSubview(moreButton)
        self.addSubview(stackVerticalView)
        stackVerticalView.addArrangedSubview(titleLabel)
        stackVerticalView.addArrangedSubview(rangeTimeLabel)
    }
    
    private func setupConstraints() {
        playButton.anchor(top: self.topAnchor, bottom: self.bottomAnchor, leading: self.leadingAnchor, trailing: nil, marginTop: 15, marginBottom: -15, marginLeading: 15, marginTrailing: 0, width: 40, height: 0, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        
        moreButton.anchor(top: self.topAnchor, bottom: self.bottomAnchor, leading: nil, trailing: self.trailingAnchor, marginTop: 0, marginBottom: 0, marginLeading: 0, marginTrailing: -15, width: 26, height: 0, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        
        stackVerticalView.anchor(top: self.topAnchor, bottom: self.bottomAnchor, leading: playButton.trailingAnchor, trailing: moreButton.trailingAnchor, marginTop: 17, marginBottom: -17, marginLeading: 15, marginTrailing: 8, width: 0, height: 0, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
    }
        
    private func updateUI() {
        titleLabel.text = segmentModel?.nameSegment
        let (_,sM,sS) = secondsToHoursMinutesSeconds(seconds: segmentModel?.startTimeSeconds ?? 0)
        let (_,eM,eS) = secondsToHoursMinutesSeconds(seconds: segmentModel?.endTimeSeconds ?? 0)
        
        let startMinutes = checkTimeIs2DigitOrNot(time: sM)
        let startSeconds = checkTimeIs2DigitOrNot(time: sS)
        
        let endMinutes = checkTimeIs2DigitOrNot(time: eM)
        let endSeconds = checkTimeIs2DigitOrNot(time: eS)
        
        rangeTimeLabel.text = "\(startMinutes):\(startSeconds) - \(endMinutes):\(endSeconds)"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
