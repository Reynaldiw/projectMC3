//
//  CustomActionSheet.swift
//  ProjectPodcastMC3
//
//  Created by Reynaldi Wijaya on 13/08/20.
//  Copyright © 2020 Reynaldi Wijaya. All rights reserved.
//

import UIKit

class CustomActionSheet: UIView {
    
    lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = Colors.BG_SCREEN_PURPLE_GRAY
        button.layer.cornerRadius = 10
        button.isUserInteractionEnabled = true
        return button
    }()
    
    lazy var contentSheetView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.BG_SCREEN_PURPLE_GRAY
        view.layer.cornerRadius = 10
        return view
    }()
    
    lazy var stackDeleteView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.spacing = 15
        stackView.isUserInteractionEnabled = true
        return stackView
    }()
    
    lazy var imageDeleteView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "delete")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var deleteLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.text = "Delete Segment"
        return label
    }()
    
    lazy var stackRenameView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.spacing = 15
        stackView.isUserInteractionEnabled = true
        return stackView
    }()
    
    lazy var imageRenameView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "rename")
        return imageView
    }()
    
    lazy var renameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Rename Segment"
        return label
    }()

    lazy var stackEditView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.spacing = 15
        stackView.isUserInteractionEnabled = true
        return stackView
    }()
    
    lazy var imageEditView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "editScissor")
        return imageView
    }()
    
    lazy var editLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Edit Segment"
        return label
    }()

    lazy var optionsTitileLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.GRAY_COLOR
        label.text = "Options"
        return label
    }()
    
    lazy var editingsTitileLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.GRAY_COLOR
        label.text = "Editings"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
        if !UIAccessibility.isReduceTransparencyEnabled {
            let blurEffect = UIBlurEffect(style: .dark)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            
            blurEffectView.frame = self.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            self.addSubview(blurEffectView)
        }
                
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        self.addSubview(cancelButton)
        self.addSubview(contentSheetView)
        contentSheetView.addSubview(stackDeleteView)
        stackDeleteView.addArrangedSubview(imageDeleteView)
        stackDeleteView.addArrangedSubview(deleteLabel)
        contentSheetView.addSubview(stackRenameView)
        stackRenameView.addArrangedSubview(imageRenameView)
        stackRenameView.addArrangedSubview(renameLabel)
        contentSheetView.addSubview(optionsTitileLabel)
        contentSheetView.addSubview(stackEditView)
        stackEditView.addArrangedSubview(imageEditView)
        stackEditView.addArrangedSubview(editLabel)
        contentSheetView.addSubview(editingsTitileLabel)
    }
    
    private func setupConstraints() {
        cancelButton.anchor(top: nil, bottom: safeAreaLayoutGuide.bottomAnchor, leading: self.leadingAnchor, trailing: self.trailingAnchor, marginTop: 0, marginBottom: 0, marginLeading: 15, marginTrailing: -15, width: 0, height: 44, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        
        contentSheetView.anchor(top: nil, bottom: cancelButton.topAnchor, leading: self.leadingAnchor, trailing: self.trailingAnchor, marginTop: 0, marginBottom: -20, marginLeading: 15, marginTrailing: -15, width: 0, height: 280, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        
        stackDeleteView.anchor(top: nil, bottom: contentSheetView.bottomAnchor, leading: contentSheetView.leadingAnchor, trailing: contentSheetView.trailingAnchor, marginTop: 0, marginBottom: -20, marginLeading: 20, marginTrailing: -20, width: 0, height: 30, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        
        imageDeleteView.anchor(top: nil, bottom: nil, leading: nil, trailing: nil, marginTop: 0, marginBottom: 0, marginLeading: 0, marginTrailing: 0, width: 25, height: 25, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        
        stackRenameView.anchor(top: nil, bottom: stackDeleteView.topAnchor, leading: contentSheetView.leadingAnchor, trailing: contentSheetView.trailingAnchor, marginTop: 0, marginBottom: -20, marginLeading: 20, marginTrailing: -20, width: 0, height: 30, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        
        imageRenameView.anchor(top: nil, bottom: nil, leading: nil, trailing: nil, marginTop: 0, marginBottom: 0, marginLeading: 0, marginTrailing: 0, width: 25, height: 25, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        
        optionsTitileLabel.anchor(top: nil, bottom: stackRenameView.topAnchor, leading: contentSheetView.leadingAnchor, trailing: contentSheetView.trailingAnchor, marginTop: 0, marginBottom: -25, marginLeading: 20, marginTrailing: -20, width: 0, height: 30, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        
        stackEditView.anchor(top: nil, bottom: optionsTitileLabel.topAnchor, leading: contentSheetView.leadingAnchor, trailing: contentSheetView.trailingAnchor, marginTop: 0, marginBottom: -25, marginLeading: 20, marginTrailing: -20, width: 0, height: 30, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        
        imageEditView.anchor(top: nil, bottom: nil, leading: nil, trailing: nil, marginTop: 0, marginBottom: 0, marginLeading: 0, marginTrailing: 0, width: 25, height: 25, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        
        editingsTitileLabel.anchor(top: contentSheetView.topAnchor, bottom: stackEditView.topAnchor, leading: contentSheetView.leadingAnchor, trailing: contentSheetView.trailingAnchor, marginTop: 20, marginBottom: -25, marginLeading: 20, marginTrailing: -20, width: 0, height: 30, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
