//
//  SearchAudioVC.swift
//  ProjectPodcastMC3
//
//  Created by Reynaldi Wijaya on 04/08/20.
//  Copyright © 2020 Reynaldi Wijaya. All rights reserved.
//

import UIKit
import MobileCoreServices
import AVFoundation

class YourAudioVC: UIViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var podcastCollectionView: UICollectionView!
    @IBOutlet weak var stackInfoView: UIStackView!
    @IBOutlet weak var labelInfo: UILabel!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    @IBOutlet weak var buttonUploadAudio: UIButton!
    @IBOutlet weak var stackUploadView: UIStackView!
    @IBOutlet weak var closeButtonEpisode: UIButton!
    @IBOutlet weak var imageThumbnailEpisode: UIImageView!
    @IBOutlet weak var episodeCollectionView: UICollectionView!
    @IBOutlet weak var loadingEpisodeView: UIActivityIndicatorView!
    
    var audioView: YourAudioView { self.view as! YourAudioView }
    var loadingCustomView = CustomLoadingView()
    
    var designDelegate: designReadyDelegate?
    var seacrhPodcastView: SearchPodcastView!
    var uploadAudioView: UploadAudioView!
    var episodePodcastView: EpisodePodcastView!
    
    var idPodcast: String?
    
    private var podcastModels: [PodcastModel]? {
        didSet {
            podcastCollectionView.reloadData()
        }
    }
    
    private var episodeModels: [EpisodeModel]? {
        didSet {
            episodeCollectionView.reloadData()
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
        
        self.hideKeyboardWhenTappedAround()
        
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
        
        searchBar = audioView.searchBar
        searchBar.delegate = self
        
        podcastCollectionView = audioView.searchPodcastView.podcastCollectionView
        podcastCollectionView.delegate = self
        podcastCollectionView.dataSource = self
        
        episodeCollectionView = audioView.episodePodcastView.episodeCV
        episodeCollectionView.delegate = self
        episodeCollectionView.dataSource = self
        
        buttonUploadAudio = audioView.uploadAudioView.buttonUpload
        buttonUploadAudio.addTarget(self, action: #selector(uploadButtonPressed(_:)), for: .touchUpInside)
        
        closeButtonEpisode = audioView.episodePodcastView.closeButton
        closeButtonEpisode.addTarget(self, action: #selector(closeButtonPressed(_:)), for: .touchUpInside)
        
        stackInfoView = audioView.searchPodcastView.stackView
        labelInfo = audioView.searchPodcastView.label
        loadingView = audioView.searchPodcastView.loadingView
        stackUploadView = audioView.uploadAudioView.stackView
        uploadAudioView = audioView.uploadAudioView
        seacrhPodcastView = audioView.searchPodcastView
        imageThumbnailEpisode = audioView.episodePodcastView.imageThumbnailView
        loadingEpisodeView = audioView.episodePodcastView.loadingView
        episodePodcastView = audioView.episodePodcastView
    }
    
    private func registerCell() {
        podcastCollectionView.register(PodcastCell.self, forCellWithReuseIdentifier: Constants.KEY_PODCAST_CELL)
        episodeCollectionView.register(PodcastCell.self, forCellWithReuseIdentifier: Constants.KEY_PODCAST_CELL)
    }
    
    @objc fileprivate func handleSegmentedControlValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            searchBar.isHidden = false
            uploadAudioView.isHidden = true
            seacrhPodcastView.isHidden = false
        case 1:
            searchBar.isHidden = true
            uploadAudioView.isHidden = false
            seacrhPodcastView.isHidden = true
        default:
            return
        }
    }
    
    @objc fileprivate func uploadButtonPressed(_ sender: UIButton) {
        let documentPicker = UIDocumentPickerViewController(documentTypes: [(kUTTypeAudio as String)], in: .import)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        present(documentPicker, animated: true, completion: nil)
    }
    
    @objc private func closeButtonPressed(_ sender: UIButton) {
        episodePodcastView.isHidden = true
        searchBar.isHidden = false
    }
    
    private func doSearchPodcastByName(query: String) {
        podcastCollectionView.isHidden = true
        stackInfoView.isHidden = true
        loadingView.isHidden = false
        loadingView.startAnimating()
        request?.searchPodcast(query: query)
    }
    
    private func doGetEpisodesById(id: String) {
        searchBar.isHidden = true
        loadingEpisodeView.isHidden = false
        loadingEpisodeView.startAnimating()
        request?.doRequestEpisodeById(id: id)
    }
    
    private func doGetAdditionalEpisodeByNextId(id: String, idNext: String) {
        searchBar.isHidden = true
        loadingEpisodeView.isHidden = false
        loadingEpisodeView.startAnimating()
        request?.doRequestAdditionalEpisodeByNextId(id: id, idNext: idNext)
    }
}

extension YourAudioVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let userInput = searchBar.text
        
        if let text = userInput {
            self.doSearchPodcastByName(query: text)
        }
    }
}

extension YourAudioVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == episodeCollectionView {
            return episodeModels?.count ?? 0
        }
        
        return podcastModels?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.KEY_PODCAST_CELL, for: indexPath) as! PodcastCell
        
        if collectionView == episodeCollectionView {
            let episodeModel = episodeModels?[indexPath.row]
            cell.titlePodcast.text = episodeModel?._title
            
            let timeInterval = Double(episodeModel?._pubDateMs ?? 0)
            let date = Date(timeIntervalSince1970: timeInterval)
            let dayTimePeriodFormatter = DateFormatter()
            dayTimePeriodFormatter.dateFormat = "MMM dd YYYY"
            let dateString = dayTimePeriodFormatter.string(from: date)
            
            cell.publisherNameLabel.text = "\(dateString)"
            
            if let audioLengthSec = episodeModel?._audioLengthSec {
                let minutes = (audioLengthSec % 3600) / 60
                cell.totalOfEpisode.text = "\(minutes) Mins"
            }
            
            cell.thumbnailImageView.sd_setImage(with: URL(string: episodeModel?._thumbnail ?? ""))
            
            if indexPath.row + 1 == episodeModels?.count {
                if let nextId = episodeModel?._nextEpisodePubDate {
                    guard let id = idPodcast else { return cell }
                    
                    doGetAdditionalEpisodeByNextId(id: id, idNext: String(nextId))
                }
            }
            
            return cell
        }
        
        let podcastModel = podcastModels?[indexPath.row]
        cell.podcastModel = podcastModel
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                
        if collectionView == podcastCollectionView {
            episodePodcastView.isHidden = false
            
            let model = podcastModels?[indexPath.row]
            episodePodcastView.imageThumbnailView.sd_setImage(with: URL(string: model?._thumbnail ?? ""))
    
            guard let id = model?._id else { return }
            self.idPodcast = id
            
            self.doGetEpisodesById(id: id)
        } else if collectionView == episodeCollectionView {
            
            let model = episodeModels?[indexPath.row]
            guard let url = model?._audioURL else { return }
            print(url)
            
            PreviewAudioWireframe.performToPreviewAudio(durationSeconds: model?._audioLengthSec, delegate: designDelegate ,caller: self, urlAudio: URL(string: url)!)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = podcastCollectionView.frame.width - 20

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
    
    func displayEpisode(episodes: [EpisodeModel]) {
        loadingEpisodeView.stopAnimating()
        loadingEpisodeView.isHidden = true
        
        if episodes.count != 0 {
            episodeCollectionView.isHidden = false
            episodeModels = episodes
            print(episodes.count)
        } else {
            print("Empty Data")
        }
    }
    
    func displayAddEpisode(episodes: [EpisodeModel]) {
        loadingEpisodeView.stopAnimating()
        loadingEpisodeView.isHidden = true
        
        if episodes.count != 0 {
            episodeCollectionView.isHidden = false
            episodeModels?.append(contentsOf: episodes)
            print(episodes.count)
        } else {
            print("Empty Data")
        }
    }
    
    func displayError(message: String, type: TypeOfResponse) {
        switch type {
        case .searchPodcast:
            loadingView.stopAnimating()
            loadingView.isHidden = true
            stackInfoView.isHidden = false
            podcastCollectionView.isHidden = true
            labelInfo.text = message
            
        case .episodeById:
            loadingEpisodeView.stopAnimating()
            loadingEpisodeView.isHidden = true
            episodeCollectionView.isHidden = true
            
        case .addEpisodeByNextId:
            loadingEpisodeView.stopAnimating()
            loadingEpisodeView.isHidden = true
            episodeCollectionView.isHidden = true
        }
        print(message)
    }
}

extension YourAudioVC: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        
        let url = urls.first
        
        guard let urlAudio = url else { return }
        
        let asset = AVAsset(url: urlAudio)
        let durationAsset = asset.duration.seconds
        let duration = Int(durationAsset)
        print(duration)
        
        PreviewAudioWireframe.performToPreviewAudio(durationSeconds: duration, delegate: designDelegate ,caller: self, urlAudio: urls.first)
        
    }
}
