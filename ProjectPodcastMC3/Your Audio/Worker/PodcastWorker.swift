//
//  PodcastWorker.swift
//  ProjectPodcastMC3
//
//  Created by Reynaldi Wijaya on 05/08/20.
//  Copyright © 2020 Reynaldi Wijaya. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct PodcastWorker {
    
    public static func searchPodcast(query: String, onSuccess: @escaping(_ result: [PodcastModel]) -> Void, onFailed: @escaping(_ message: String) -> Void) {
        
        AF.request(Network.searchPodcast(query: query, type: .Podcast)).responseJSON { (response) in
            switch response.result {
            case .success(_):
                let podcastResponseJSON: JSON = JSON(response.value ?? "")
                
                changeJSONToPodcastModel(query: query, json: podcastResponseJSON, onSuccess: { (podcastModels) in
                    onSuccess(podcastModels)
                }) { (message) in
                    onFailed(message)
                }
                
            case .failure(let error):
                onFailed(error.localizedDescription)
            }
        }
    }
    
    public static func doRequestEpisodesById(id: String, onSuccess: @escaping(_ result: [EpisodeModel]) -> Void, onFailed: @escaping(_ message: String) -> Void) {
        
        AF.request(Network.doRequestEpisodesByPodcastName(id: id)).responseJSON { (response) in
            switch response.result {
            case .success(_):
                let episodeResponseJSON: JSON = JSON(response.value ?? "")
                
                changeJSONToEpisodeModels(json: episodeResponseJSON, onSuccess: { (episodeModels) in
                    onSuccess(episodeModels)
                }) { (message) in
                    onFailed(message)
                }
                
            case .failure(let error):
                onFailed(error.localizedDescription)
            }
        }
    }
    
    public static func doRequestAdditionalEpisodeByNextEpsiode(id: String, idNext: String, onSuccess: @escaping(_ result: [EpisodeModel]) -> Void, onFailed: @escaping(_ message: String) -> Void) {
        
        AF.request(Network.doRequestAdditionalEpisodeByNextEpisode(idEpisode: id, idNextEpisode: idNext)).responseJSON { (response) in
            switch response.result {
            case .success(_):
                let episodeResponseJSON: JSON = JSON(response.value ?? "")
                
                changeJSONToEpisodeModels(json: episodeResponseJSON, onSuccess: { (episodeModels) in
                    onSuccess(episodeModels)
                }) { (message) in
                    onFailed(message)
                }
                
            case .failure(let error):
                onFailed(error.localizedDescription)
            }
        }
    }
    
    private static func changeJSONToPodcastModel(
        query: String,
        json: JSON,
        onSuccess: @escaping(_ results: [PodcastModel]) -> Void,
        onFailed: @escaping(_ message: String) -> Void) {
        
        let responseDAO = DAOPodcastsBaseClass(json: json)
        
        var podcastModels = [PodcastModel]()
        
        if let results = responseDAO.results {
            if results.count != 0 {
                for data in results {
                    if (data.titleOriginal?.contains(query) ?? false) {
                        let model = PodcastModel(_rss: data.rss, _description_original: data.descriptionOriginal, _title_original: data.titleOriginal, _publisher_original: data.publisherOriginal, _thumbnail: data.thumbnail, _id: data.id, _total_episodes: data.totalEpisodes)
                        
                        podcastModels.append(model)
                    } else {
                        continue
                    }
                }
            }
        } else {
            onFailed("Empty Data")
        }
        
        onSuccess(podcastModels)
    }
    
    private static func changeJSONToEpisodeModels(
        json: JSON,
        onSuccess: @escaping(_ results: [EpisodeModel]) -> Void,
        onFailed: @escaping(_ message: String) -> Void
    ) {
        
        let responseDAO = DAOEpisodesBaseClass(json: json)
        
        var episodeModels = [EpisodeModel]()
        
        if let episodes = responseDAO.episodes {
            if let nextEpisodePubDate = responseDAO.nextEpisodePubDate {
                if episodes.count != 0 {
                    for data in episodes {
                        let model = EpisodeModel(_idEpisode: data.id, _title: data.title, _desc: data.descriptionValue, _thumbnail: data.thumbnail, _audioURL: data.audio, _audioLengthSec: data.audioLengthSec, _pubDateMs: data.pubDateMs, _nextEpisodePubDate: nextEpisodePubDate)
                        episodeModels.append(model)
                    }
                } else {
                    onFailed("Empty Data")
                }
            }
        } else {
            onFailed("Empty Data")
        }
        
        onSuccess(episodeModels)
    }
}
