//
//  CollectionsViewController.swift
//  ProjectPodcastMC3
//
//  Created by Ganang Arief Pratama on 12/08/20.
//  Copyright © 2020 Reynaldi Wijaya. All rights reserved.
//

import UIKit
import Photos
import SwiftKeychainWrapper

protocol RefreshVideoCollectionsDelegate {
    func refreshData()
}

class VideoCollectionsViewController: UIViewController {
    
    var presenter: VideoCollectionsPresenterProtocol?
    private var videoCollectionsView: VideoCollectionsView!
    private var videos = [VideoModel]()
    
    override func loadView() {
        self.videoCollectionsView = VideoCollectionsView()
        view = self.videoCollectionsView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
        setupWorker()
        initInterfaceComponent()
        registerCell()
        checkPhotoLibraryPermission()
    }
    
    private func checkPhotoLibraryPermission() {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized: break
        //handle authorized status
        case .denied, .restricted : break
        //handle denied status
        case .notDetermined:
            // ask for permissions
            PHPhotoLibrary.requestAuthorization { status in
                switch status {
                case .authorized: break
                // as above
                case .denied, .restricted: break
                // as above
                case .notDetermined: break
                // won't happen but still
                @unknown default:
                    print("ERROR")
                }
            }
        @unknown default:
            print("ERROR")
        }
    }
    
    private func config() {
        VideoCollectionsWireframe.createMainModule(videoCollectionsRef: self)
    }
    
    private func setupWorker() {
        let uid = KeychainWrapper.standard.string(forKey: Constants.KEY_UID_KEYCHAIN)
        
        if uid == nil {
            return
        } else {
            let params = ["uid": uid!]
            presenter?.getCollections(params)
        }
    }
    
    private func setupNavigationController() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.barStyle = .black
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationItem.title = "Podcast Content"
        
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus.circle.fill"), style: .plain, target: self, action: #selector(handleAddButton))
        self.navigationItem.rightBarButtonItem  = addButton
    }
    
    @objc func handleAddButton() {
        let vc = CreateViewController()
        vc.refreshDataDelegate = self
        
        let navController: UINavigationController = UINavigationController()
        navController.viewControllers = [vc]
        UIApplication.shared.windows.first?.rootViewController = navController
    }
    
    private func initInterfaceComponent() {
        self.videoCollectionsView.videoCollectionView.delegate = self
        self.videoCollectionsView.videoCollectionView.dataSource = self
    }
    
    private func registerCell() {
        self.videoCollectionsView.videoCollectionView.register(VideoCollectionCell.self, forCellWithReuseIdentifier: Constants.KEY_VIDEO_COLLECTION_CELL)
    }
    
    @objc func shareToSocialMedia(_ sender: CustomButton) {
        self.videoCollectionsView.showSpinner()
        
        let videoURL = sender.videoData?._video

        DispatchQueue.global(qos: .background).async {
            if let url = URL(string: videoURL!),
                let urlData = NSData(contentsOf: url) {
                let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0];
                let filePath="\(documentsPath)/tempFile.mp4"
                
                DispatchQueue.main.async {
                    urlData.write(toFile: filePath, atomically: true)
                    PHPhotoLibrary.shared().performChanges({
                        PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: URL(fileURLWithPath: filePath))
                    }) { completed, error in
                        if completed {
                            self.shareToInstagram(filePath)
                        } else {
                            print(error?.localizedDescription)
                        }
                    }
                }
            }
        }
        
    }
    
    func shareToInstagram(_ filePath: String) {
        let instagramURL = NSURL(string: "instagram://app")
        
        DispatchQueue.main.async {
            self.videoCollectionsView.hideSpinner()
            if (UIApplication.shared.canOpenURL(instagramURL! as URL)) {
                
                let url = URL(string: ("instagram://library?AssetPath="+filePath))
                
                if UIApplication.shared.canOpenURL(url!) {
                    UIApplication.shared.open(url!, options: [:], completionHandler:nil)
                }
                
            } else {
                print(" Instagram isn't installed ")
            }
        }
    }
    
    @objc func playButtonOnClick(_ sender: CustomButton) {
        let videoURL = sender.videoData?._video
        let videoPodcastVC = VideoPodcastViewController()
        videoPodcastVC.videoUrl = videoURL
        videoPodcastVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(videoPodcastVC, animated: true)
    }
    
}

extension VideoCollectionsViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count
    }

    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.KEY_VIDEO_COLLECTION_CELL, for: indexPath) as! VideoCollectionCell
        
        cell.placeholderImageView.sd_setImage(with: URL(string: videos[indexPath.row]._image ?? ""))
        cell.shareButton.videoData = videos[indexPath.row]
        cell.shareButton.addTarget(self, action: #selector(shareToSocialMedia), for: .touchUpInside)
        cell.playButton.videoData = videos[indexPath.row]
        cell.playButton.addTarget(self, action: #selector(playButtonOnClick), for: .touchUpInside)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.videoCollectionsView.videoCollectionView.frame.width - 20
        
        return CGSize(width: width, height: 374)
    }
}

extension VideoCollectionsViewController: VideoCollectionsViewControllerProtocol {
    func displayVideos(_ videos: [VideoModel]) {
        DispatchQueue.main.async {
            self.videos = videos
            self.videoCollectionsView.videoCollectionView.reloadData()
        }
    }
}

extension VideoCollectionsViewController: RefreshVideoCollectionsDelegate {
    func refreshData() {
        setupWorker()
    }
}

