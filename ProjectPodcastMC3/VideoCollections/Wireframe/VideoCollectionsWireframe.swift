//
//  VideoCollectionsWireframeProtocol.swift
//  ProjectPodcastMC3
//
//  Created by Ganang Arief Pratama on 12/08/20.
//  Copyright © 2020 Reynaldi Wijaya. All rights reserved.
//

class VideoCollectionsWireframe: VideoCollectionsWireframeProtocol {
    class func createMainModule(videoCollectionsRef: VideoCollectionsViewController) {
        let presenter: VideoCollectionsPresenterProtocol = VideoCollectionsPresenter()
        
        videoCollectionsRef.presenter = presenter
        videoCollectionsRef.presenter?.wireframe = VideoCollectionsWireframe()
        videoCollectionsRef.presenter?.view = videoCollectionsRef
        videoCollectionsRef.presenter?.interactor = VideoCollectionsInteractor()
        videoCollectionsRef.presenter?.interactor?.presenter = presenter
    }
}

