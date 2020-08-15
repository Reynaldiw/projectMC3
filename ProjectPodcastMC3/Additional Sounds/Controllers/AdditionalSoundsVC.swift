//
//  AdditionalSoundsVC.swift
//  ProjectPodcastMC3
//
//  Created by Reynaldi Wijaya on 13/08/20.
//  Copyright © 2020 Reynaldi Wijaya. All rights reserved.
//

import UIKit
import AVFoundation

class AdditionalSoundsVC: UIViewController {
    
    var additionalSoundView: AdditionalSoundsView { self.view as! AdditionalSoundsView }
    
    @IBOutlet weak var additionalSoundsCollectionView: UICollectionView!
    @IBOutlet weak var playCellButton: UIButton!
    
    var soundsModel = [AdditionalSoundModel]()
    var urlAudio: URL? {
        didSet {
            preparePlayer()
        }
    }
        
    var callback: ((AdditionalSoundModel) -> Void)?
    
    var player: AVAudioPlayer?
    var isPlaying = false
    
    var indexPath: IndexPath?
    
    override func loadView() {
        self.view = AdditionalSoundsView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationController()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initInterfaceComponent()
        
        initData()
        additionalSoundsCollectionView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if let player = player {
            if player.isPlaying {
                player.pause()
                self.player = nil
            }
        }
    }
    
    private func setupNavigationController() {
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        title = "Sounds"
        
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.isTranslucent = true
        
        let closeButton = UIBarButtonItem(image: UIImage(named: "close"), style: .done, target: self, action: #selector(closeButtonPressed(_:)))
        self.navigationItem.leftBarButtonItem = closeButton
        self.navigationItem.leftBarButtonItem?.tintColor = .gray
    }
    
    private func initInterfaceComponent() {
        additionalSoundsCollectionView = additionalSoundView.addtionalSoundsCV
        additionalSoundsCollectionView.register(SegmentCell.self, forCellWithReuseIdentifier: Constants.KEY_SEGMENT_CELL)
        additionalSoundsCollectionView.delegate = self
        additionalSoundsCollectionView.dataSource = self
    }
    
    private func initData() {
        self.soundsModel = AdditionalSoundModel.getModel()
    }
    
    @objc private func closeButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

extension AdditionalSoundsVC {
    private func preparePlayer() {
        guard let safeURLAudio = urlAudio else { return }
    
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: safeURLAudio)
            player?.prepareToPlay()
            
            NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: .AVPlayerItemDidPlayToEndTime, object: nil)
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @objc private func playerDidFinishPlaying() {
        if let indexPath = indexPath {
            self.additionalSoundsCollectionView.performBatchUpdates({
                self.additionalSoundsCollectionView.reloadItems(at: [indexPath])
                isPlaying = false
            }) { (finish) in
                print(finish)
            }
        }
    }
}

extension AdditionalSoundsVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return soundsModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.KEY_SEGMENT_CELL, for: indexPath) as! SegmentCell
        
        let soundModel = soundsModel[indexPath.row]
        
        cell.playButton.setImage(UIImage(named: "playButtonRed"), for: .normal)
        cell.moreButton.setImage(UIImage(named: "add"), for: .normal)
        cell.titleLabel.text = soundModel.nameOfSounds
                
        let (_, M, S) = secondsToHoursMinutesSeconds(seconds: soundModel.duration ?? 0)
        
        let minuteString = checkTimeIs2DigitOrNot(time: M)
        let secondString = checkTimeIs2DigitOrNot(time: S)
        
        cell.rangeTimeLabel.text = "\(minuteString):\(secondString)"
    
        cell.playButton.addTarget(self, action: #selector(playButtonPressed(_:)), for: .touchUpInside)
        
        return cell
    }
    
    @objc private func playButtonPressed(_ sender: Any) {
        if let player = player {
            if player.isPlaying {
                isPlaying = false
                player.pause()
                self.player = nil
            }
        }
        
        if let indexPath = indexPath {
            self.additionalSoundsCollectionView.performBatchUpdates({
                self.additionalSoundsCollectionView.reloadItems(at: [indexPath])
            }) { (finish) in
                print(finish)
            }
        }
        
        if let button = sender as? UIButton {
            let point: CGPoint = button.convert(.zero, to: self.additionalSoundsCollectionView)
            if let indexPath = self.additionalSoundsCollectionView!.indexPathForItem(at: point) {
                
                self.indexPath = indexPath
                
                
                let cell = self.additionalSoundsCollectionView!.cellForItem(at: indexPath) as! SegmentCell
                                
                let model = soundsModel[indexPath.row]
                urlAudio = model.url
                
                playCellButton = cell.playButton
                
                guard let player = player else {
                    return
                }
                
                player.play()
                changeBGPlayPauseButton(isPlaying: isPlaying, playPauseButton: playCellButton)
                isPlaying = true
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            createAlertAndShowAlert(title: "Add to Audio", message: "This Sound will be added to your audio", actionName: "Yes", caller: self) { (action) in
                self.callback?(self.soundsModel[indexPath.row])
                self.navigationController?.popViewController(animated: true)
            }
    }
}

extension AdditionalSoundsVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenSize = UIScreen.main.bounds
        
        return CGSize(width: screenSize.width - 30, height: 70)
    }
}
