//
//  StartSegmentView.swift
//  ProjectPodcastMC3
//
//  Created by Reynaldi Wijaya on 12/08/20.
//  Copyright © 2020 Reynaldi Wijaya. All rights reserved.
//

import UIKit

class TimePickerView: UIView {
    
    lazy var timePicker: UIPickerView = {
        let timePicker = UIPickerView()
        timePicker.backgroundColor = .black
        timePicker.setValue(UIColor.white, forKeyPath: "textColor")
        return timePicker
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = Colors.BG_EDIT_SEGMENT
        
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        self.addSubview(timePicker)
    }
    
    private func setupConstraints() {
        let viewSize = self.bounds
        let height = viewSize.height / 2
        
        timePicker.anchor(top: self.topAnchor, bottom: nil, leading: self.leadingAnchor, trailing: self.trailingAnchor, marginTop: 0, marginBottom: 0, marginLeading: 0, marginTrailing: 0, width: 0, height: height, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
