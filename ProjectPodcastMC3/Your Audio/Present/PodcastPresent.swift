//
//  PodcastPresent.swift
//  ProjectPodcastMC3
//
//  Created by Reynaldi Wijaya on 05/08/20.
//  Copyright © 2020 Reynaldi Wijaya. All rights reserved.
//

import Foundation

protocol PodcastRequest: BaseRequest {
    func searchPodcast(query: String)
}

protocol PodcastResponse: BaseResponse {
    func displayPodcast(podcasts: [PodcastModel])
}

struct PodcastPresent: PodcastRequest {
    
    weak var output: PodcastResponse?
    
    func searchPodcast(query: String) {
        PodcastWorker.searchPodcast(query: query, onSuccess: { (podcastModels) in
            self.output?.displayPodcast(podcasts: podcastModels)
        }) { (message) in
            self.output?.displayError(message: message)
        }
    }
}
