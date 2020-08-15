//
//  AdditionalSoundsView.swift
//  ProjectPodcastMC3
//
//  Created by Reynaldi Wijaya on 13/08/20.
//  Copyright © 2020 Reynaldi Wijaya. All rights reserved.
//

import UIKit

class AdditionalSoundsView: UIView {
    
    lazy var addtionalSoundsCV: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        flowLayout.minimumInteritemSpacing = 12
        flowLayout.minimumLineSpacing = 12
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        self.addSubview(addtionalSoundsCV)
    }
    
    private func setupConstraints() {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
