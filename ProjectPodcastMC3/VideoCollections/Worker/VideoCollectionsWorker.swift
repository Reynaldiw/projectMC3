//
//  VideoCollectionsWorker.swift
//  ProjectPodcastMC3
//
//  Created by Ganang Arief Pratama on 12/08/20.
//  Copyright © 2020 Reynaldi Wijaya. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class VideoCollectionsWorker {
    
    func getCollections( onSuccess: @escaping((_ result: [VideoModel]) -> Void), onFailed: @escaping((_ erorr: String) -> Void), _ params: [String: Any]
    ) {
        AF.request(VideoNetwork.getCollections(params: params)).responseJSON { (response) in
            switch response.result {
            case .success(_):
                let videosResponseJSON: JSON = JSON(response.value ?? "")
                
                VideoCollectionsWorker.changeJSONToVideoModel(json: videosResponseJSON, onSuccess: { (videoModels) in
                    onSuccess(videoModels)
                }) { (message) in
                    onFailed(message)
                }
                
            case .failure(let error):
                onFailed(error.localizedDescription)
            }
        }
    }
    
    private static func changeJSONToVideoModel(
        json: JSON,
        onSuccess: @escaping(_ result: [VideoModel]) -> Void,
        onFailed: @escaping(_ message: String) -> Void) {
        
        let responseDAO = DAOVideoBaseClass(json: json)
        
        var videoModels = [VideoModel]()
        
        if let results = responseDAO.collections {
            if results.count != 0 {
                for data in results {
                    let model = VideoModel(_name: data.name, _video: data.video, _image: data.image, _timestamp: data.timestamp)

                    videoModels.append(model)
                }
            }
        } else {
            onFailed("Empty Data")
        }
        
        onSuccess(videoModels)
    }
}


