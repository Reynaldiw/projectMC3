//
//  PodcastCell.swift
//  ProjectPodcastMC3
//
//  Created by Reynaldi Wijaya on 05/08/20.
//  Copyright © 2020 Reynaldi Wijaya. All rights reserved.
//

import UIKit
import SDWebImage

class PodcastCell: UICollectionViewCell {
    
    var podcastModel: PodcastModel! {
        didSet {
            self.updateUI(podcastModel: podcastModel)
        }
    }
    
    lazy var thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var titlePodcast: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var publisherNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    lazy var separateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 12)
        label.text = "  -  "
        return label
    }()
    
    lazy var totalOfEpisode: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    lazy var stackViewVertical: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.spacing = 0
        return stackView
    }()
    
    lazy var stackViewHorizontal: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.spacing = 0
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        self.addSubview(thumbnailImageView)
        self.addSubview(stackViewVertical)
        stackViewVertical.addArrangedSubview(titlePodcast)
        stackViewVertical.addArrangedSubview(stackViewHorizontal)
        stackViewHorizontal.addArrangedSubview(publisherNameLabel)
        stackViewHorizontal.addArrangedSubview(separateLabel)
        stackViewHorizontal.addArrangedSubview(totalOfEpisode)
    }
    
    private func setupConstraints() {
        thumbnailImageView.anchor(top: self.topAnchor, bottom: self.bottomAnchor, leading: self.leadingAnchor, trailing: nil, marginTop: 0, marginBottom: 0, marginLeading: 0, marginTrailing: 0, width: 45, height: 0, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        thumbnailImageView.layer.cornerRadius = 8
        thumbnailImageView.layer.masksToBounds = true
        
        stackViewVertical.anchor(top: self.topAnchor, bottom: self.bottomAnchor, leading: thumbnailImageView.trailingAnchor, trailing: self.trailingAnchor, marginTop: 0, marginBottom: 0, marginLeading: 8, marginTrailing: 0, width: 0, height: 0, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        
        titlePodcast.widthAnchor.constraint(equalToConstant: stackViewVertical.frame.width).isActive = true
    }
    
    private func updateUI(podcastModel: PodcastModel?) {
        if let podcast = podcastModel {
            self.thumbnailImageView.sd_setImage(with: URL(string: podcast._thumbnail ?? ""))
            self.thumbnailImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            self.titlePodcast.text = podcast._title_original
            self.publisherNameLabel.text = podcast._publisher_original
            if let totalOfEpisode = podcast._total_episodes {
                self.totalOfEpisode.text = "\(totalOfEpisode) Episodes"
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
