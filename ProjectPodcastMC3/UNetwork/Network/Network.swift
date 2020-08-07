//
//  Network.swift
//  ProjectPodcastMC3
//
//  Created by Reynaldi Wijaya on 05/08/20.
//  Copyright © 2020 Reynaldi Wijaya. All rights reserved.
//

import Foundation
import Alamofire

public enum TypeOfSearch {
    case Episode
    case Podcast
}

public enum Network: URLRequestConvertible {
    
    static let baseURLString = ConfigApps.getUrl()
    static let baseApiKey = ConfigApps.getApiKey()
    
    case searchPodcast(query: String, type: TypeOfSearch)
    case doRequestEpisodesByPodcastName(id: String)
    
    var method : HTTPMethod {
        switch self {
        case .searchPodcast(_,_):
            return .get
        case .doRequestEpisodesByPodcastName(_):
            return.get
        }
    }
    
    var res: (path: String, params: [String : Any]?) {
        switch self {
        case .searchPodcast(let query, let type):
            switch type {
            case .Podcast:
                return ("search", ["type" : "podcast", "q" : query])
            default:
                return ("search", ["type" : "episode", "q" : query])
            }
        case .doRequestEpisodesByPodcastName(_):
            return ("podcasts", nil)
        }
    }
    
    public func asURLRequest() throws -> URLRequest {
        var url: URL?
        var urlRequest: URLRequest?
        url = try Network.baseURLString.asURL()
        url?.appendPathComponent(res.path)
        
        switch self {
        case .doRequestEpisodesByPodcastName(let id):
            url?.appendPathComponent(id)
        default:
            break
        }
        
        urlRequest = URLRequest(url: url!)
        urlRequest?.httpMethod = method.rawValue
        urlRequest?.setValue(Network.baseApiKey, forHTTPHeaderField: "X-ListenAPI-Key")
        
        // Append Param
        if let params = res.params {
            urlRequest = try URLEncoding.default.encode(urlRequest!, with: params)
        }
        
        print("\(urlRequest?.url)")
        
        return urlRequest!
    }
}
