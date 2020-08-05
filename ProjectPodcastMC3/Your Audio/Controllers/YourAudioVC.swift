//
//  SearchAudioVC.swift
//  ProjectPodcastMC3
//
//  Created by Reynaldi Wijaya on 04/08/20.
//  Copyright © 2020 Reynaldi Wijaya. All rights reserved.
//

import UIKit

class YourAudioVC: UIViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var seacrhBar: UISearchBar!
    @IBOutlet weak var podcastCollectionView: UICollectionView!
    @IBOutlet weak var stackInfoView: UIStackView!
    @IBOutlet weak var labelInfo: UILabel!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    
    var audioView: YourAudioView { self.view as! YourAudioView }
    
    var seacrhPodcastView: SearchPodcastView!
    var uploadAudioView: UploadAudioView!
    
    private var podcastModels: [PodcastModel]? {
        didSet {
            podcastCollectionView.reloadData()
        }
    }
    
    // Request to get Podcast by Query
    private var request: PodcastRequest?
    
    override func loadView() {
        view = YourAudioView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationController()
        self.config(vc: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initInterfaceComponent()
        
        registerCell()
    }
    
    private func setupNavigationController() {
        title = "Audio"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.isTranslucent = true
    }
    
    private func initInterfaceComponent() {
        segmentedControl = audioView.segmentedControl
        segmentedControl.addTarget(self, action: #selector(handleSegmentedControlValueChanged(_:)), for: .valueChanged)
        seacrhBar = audioView.searchBar
        seacrhBar.delegate = self
        podcastCollectionView = audioView.searchPodcastView.podcastCollectionView
        podcastCollectionView.delegate = self
        podcastCollectionView.dataSource = self
        stackInfoView = audioView.searchPodcastView.stackView
        labelInfo = audioView.searchPodcastView.label
        loadingView = audioView.searchPodcastView.loadingView
        
        uploadAudioView = audioView.uploadAudioView
        seacrhPodcastView = audioView.searchPodcastView
    }
    
    private func registerCell() {
        podcastCollectionView.register(PodcastCell.self, forCellWithReuseIdentifier: Constants.KEY_PODCAST_CELL)
    }
    
    @objc fileprivate func handleSegmentedControlValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            seacrhBar.isHidden = false
            uploadAudioView.isHidden = true
            seacrhPodcastView.isHidden = false
        case 1:
            seacrhBar.isHidden = true
            uploadAudioView.isHidden = false
            seacrhPodcastView.isHidden = true
        default:
            return
        }
    }
    
    private func doRequestData(query: String) {
        podcastCollectionView.isHidden = true
        stackInfoView.isHidden = true
        loadingView.isHidden = false
        loadingView.startAnimating()
        request?.searchPodcast(query: query)
    }
}

extension YourAudioVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let userInput = searchBar.text
        
        if let text = userInput {
            self.doRequestData(query: text)
        }
    }
}

extension YourAudioVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return podcastModels?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.KEY_PODCAST_CELL, for: indexPath) as! PodcastCell
        
        let podcastModel = podcastModels?[indexPath.row]
        
        cell.podcastModel = podcastModel
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = podcastCollectionView.frame.width

        return CGSize(width: width, height: 50)
    }
}

extension YourAudioVC: PodcastResponse {
        
    func config(vc: YourAudioVC) {
        print("config")
        var present = PodcastPresent()
        present.output = vc
        vc.request = present
    }
    
    func displayPodcast(podcasts: [PodcastModel]) {
        loadingView.stopAnimating()
        loadingView.isHidden = true
        
        if podcasts.count != 0 {
            podcastCollectionView.isHidden = false
            podcastModels = podcasts
        } else {
            stackInfoView.isHidden = false
            labelInfo.text = "Empty Data"
        }
    }
    
    func displayError(message: String) {
        loadingView.stopAnimating()
        loadingView.isHidden = true
        stackInfoView.isHidden = false
        podcastCollectionView.isHidden = true
        labelInfo.text = message
        print(message)
    }
}
