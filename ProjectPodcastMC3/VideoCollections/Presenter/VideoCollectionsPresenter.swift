//
//  VideoCollectionsPresenter.swift
//  ProjectPodcastMC3
//
//  Created by Ganang Arief Pratama on 12/08/20.
//  Copyright © 2020 Reynaldi Wijaya. All rights reserved.
//

import UIKit

class VideoCollectionsPresenter: VideoCollectionsPresenterProtocol {
    var interactor: VideoCollectionsInteractorProtocol?
    weak var view: VideoCollectionsViewControllerProtocol?
    var wireframe: VideoCollectionsWireframeProtocol?
    
    func getCollections(_ params: [String : Any]) {
        interactor?.getCollections(params)
    }
    
    func displayVideos(_ videos: [VideoModel]) {
        view?.displayVideos(videos)
    }
}
