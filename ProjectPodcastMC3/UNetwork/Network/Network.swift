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
    
    var method : HTTPMethod {
        switch self {
        case .searchPodcast(_,_):
            return .get
        }
    }
    
    var res: (path: String, params: [String : Any]) {
        switch self {
        case .searchPodcast(let query, let type):
            switch type {
            case .Podcast:
                return ("search", ["type" : "podcast", "q" : query])
            default:
                return ("search", ["type" : "episode", "q" : query])
            }
        }
    }
    
    public func asURLRequest() throws -> URLRequest {
        var url: URL?
        var urlRequest: URLRequest?
        url = try Network.baseURLString.asURL()
        
        urlRequest = URLRequest(url: (url?.appendingPathComponent(res.path))!)
        urlRequest?.httpMethod = method.rawValue
        urlRequest?.setValue(Network.baseApiKey, forHTTPHeaderField: "X-ListenAPI-Key")
        
        // Append Param
        urlRequest = try URLEncoding.default.encode(urlRequest!, with: res.params)
        
        return urlRequest!
    }
}
