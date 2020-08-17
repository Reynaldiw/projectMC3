//
//  VideoNetwork.swift
//  ProjectPodcastMC3
//
//  Created by Ganang Arief Pratama on 12/08/20.
//  Copyright © 2020 Reynaldi Wijaya. All rights reserved.
//

import Foundation
import Alamofire

public enum VideoNetwork: URLRequestConvertible {
    
    static let baseURLString = ConfigApps.getUrlVideo()
    
    case loginApple(code: String)
    case submitVideo(params: [String: Any])
    case getCollections(params: [String: Any])
    
    var method : HTTPMethod {
        switch self {
        case .loginApple(_):
            return .get
        case .submitVideo(_):
            return .post
        case .getCollections(_):
            return .get
        }
        
    }
    
    var res: (path: String, params: [String : Any]?) {
        switch self {
        case .loginApple(let code):
            return ("auth/apple/callback", ["code": code])
        case .submitVideo(let params):
            return ("submit", params)
        case .getCollections(let params):
            return ("collections", params)
        }
    }
    
    public func asURLRequest() throws -> URLRequest {
        var url: URL?
        var urlRequest: URLRequest?
        url = try VideoNetwork.baseURLString.asURL()
        url?.appendPathComponent(res.path)
        
        urlRequest = URLRequest(url: url!)
        urlRequest?.httpMethod = method.rawValue
        
        print(res.params)
        
        // Append Param
        if let params = res.params {
            print(params)
            urlRequest = try URLEncoding.default.encode(urlRequest!, with: params)
        }
        
        print("urlRequest: \(urlRequest?.url)")
        
        return urlRequest!
    }
}
