//
//  VideoCollectionsInteractor.swift
//  ProjectPodcastMC3
//
//  Created by Ganang Arief Pratama on 12/08/20.
//  Copyright © 2020 Reynaldi Wijaya. All rights reserved.
//

import UIKit

class VideoCollectionsInteractor: VideoCollectionsInteractorProtocol {
    
    weak var presenter: VideoCollectionsPresenterProtocol?
    private var videoCollectionsWorker = VideoCollectionsWorker()
    
    func getCollections(_ params: [String: Any]) {
        videoCollectionsWorker.getCollections(onSuccess: { (videoModels) in
            self.presenter?.displayVideos(videoModels)
        }, onFailed: { (error) in
//            self.presenter
        }, params)

    }
    
}
