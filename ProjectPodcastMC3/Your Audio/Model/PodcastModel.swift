//
//  PodcastModel.swift
//  ProjectPodcastMC3
//
//  Created by Reynaldi Wijaya on 05/08/20.
//  Copyright © 2020 Reynaldi Wijaya. All rights reserved.
//

import Foundation

struct PodcastModel: Codable {
    public let _rss: String?
    public let _description_original: String?
    public let _title_original: String?
    public let _publisher_original: String?
    public let _thumbnail: String?
    public let _id: String?
    public let _total_episodes: Int?
}
