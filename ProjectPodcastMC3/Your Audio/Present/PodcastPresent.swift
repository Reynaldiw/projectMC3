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
    func doRequestEpisodeById(id: String)
}

protocol PodcastResponse: BaseResponse {
    func displayPodcast(podcasts: [PodcastModel])
    func displayEpisode(episodes: [EpisodeModel])
}

struct PodcastPresent: PodcastRequest {
    
    weak var output: PodcastResponse?
    
    func searchPodcast(query: String) {
        PodcastWorker.searchPodcast(query: query, onSuccess: { (podcastModels) in
            self.output?.displayPodcast(podcasts: podcastModels)
        }) { (message) in
            self.output?.displayError(message: message, type: TypeOfResponse.searchPodcast)
        }
    }
    
    func doRequestEpisodeById(id: String) {
        print("request podcast")
        PodcastWorker.doRequestEpisodesById(id: id, onSuccess: { (episodeModels) in
            self.output?.displayEpisode(episodes: episodeModels)
        }) { (message) in
            self.output?.displayError(message: message, type: .episodeById)
        }
    }
}
