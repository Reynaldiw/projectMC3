//
//  VideoCollectionsProtocol.swift
//  ProjectPodcastMC3
//
//  Created by Ganang Arief Pratama on 12/08/20.
//  Copyright © 2020 Reynaldi Wijaya. All rights reserved.
//

import UIKit

protocol VideoCollectionsViewControllerProtocol: class {
    func displayVideos(_ videos: [VideoModel])
}

protocol VideoCollectionsPresenterProtocol: class {
    var interactor: VideoCollectionsInteractorProtocol? { get set }
    var view: VideoCollectionsViewControllerProtocol? { get set }
    var wireframe: VideoCollectionsWireframeProtocol? { get set }
    
    func getCollections(_ params: [String: Any])
    func displayVideos(_ videos: [VideoModel])
}

protocol VideoCollectionsInteractorProtocol: class {
    var presenter: VideoCollectionsPresenterProtocol? { get set }
    
    func getCollections(_ params: [String: Any])
}

protocol VideoCollectionsWireframeProtocol: class {
    
}
