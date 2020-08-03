//
//  AudioEditingViewController.swift
//  ProjectPodcastMC3
//
//  Created by Reynaldi Wijaya on 03/08/20.
//  Copyright © 2020 Reynaldi Wijaya. All rights reserved.
//

import UIKit

class AudioEditingVC: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var audioImageView: UIImageView!
    @IBOutlet weak var saveButton: UIButton!
    
    var audioEditingView: AudioEditingView { self.view as! AudioEditingView }
    
    var counter: Int = 0
    var arrayView = [UIView]()
    var centerArrayView = [CGFloat]()
    
    let audioURL = URL.init(fileURLWithPath: Bundle.main.path(forResource: "stuck-on-u", ofType: "mp3")!)
    
    override func loadView() {
        self.view = AudioEditingView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        
        setupNavigationController()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioImageView = audioEditingView.audioImageView
        saveButton = audioEditingView.saveButton
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        doubleTap.numberOfTapsRequired = 2
        audioImageView.addGestureRecognizer(doubleTap)
        
        saveButton.addTarget(self, action: #selector(save), for: .touchUpInside)

    }
    
    private func setupNavigationController() {
        self.navigationController?.isNavigationBarHidden = false
        title = "Edit Audio"
        self.navigationController?.navigationBar.barTintColor = Colors.BG_COLOR_NAVBAR
        
        let rightBarButtonItem = UIBarButtonItem(customView: audioEditingView.saveButton)
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    @objc func save() {
        centerArrayView = []
        
        for splitView in arrayView {
            let centerX: CGFloat = splitView.center.x
            
            centerArrayView.append(centerX)
        }
            
        print(centerArrayView.sorted())
        
        let totalOfSplit = arrayView.count
        
        if totalOfSplit != 0 {
            if totalOfSplit % 2 == 0 {
                let divededByTwo = totalOfSplit / 2
                
                var rangeTimes = [RangeTime]()
                
                for _ in 0..<divededByTwo {
                    let range = RangeTime(startTime: 0, endTime: 5)
                    rangeTimes.append(range)
                }
                
                let outputFileName = EditAudioRepositoryClass.getNumberForFileManager()
                
                EditAudioRepositoryClass.editAudioForIGStory(urlAudio: audioURL, ranges: rangeTimes, outputFileName: String(outputFileName), successEditAudio: { (url) in
                    print(url)
                }) { (message) in
                    print(message)
                }
                
            } else {
                print("Less Split")
            }
        } else {
            print("Please split the audio u want to")
        }
    }
    
    @objc func imageTapped(_ sender: UITapGestureRecognizer) {
        counter += 1
        let position = sender.location(in: view)
        
        let splitView = UIView(frame: CGRect(x: position.x, y: audioImageView.frame.origin.y, width: 5, height: audioImageView.frame.height))
        splitView.tag = counter
        splitView.backgroundColor = .systemRed
        
        // Add move gesture
        let moveGS = UIPanGestureRecognizer(target: self, action: #selector(self.gestureMoveObject(_:)))
        moveGS.delegate = self
        splitView.addGestureRecognizer(moveGS)
        
        view.addSubview(splitView)
        arrayView.append(splitView)
    }
    
    @objc func gestureMoveObject(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self.audioImageView)
        let moveableView = sender.view
        let centerX: Double = Double((moveableView?.center.x)!) as Double
        
        if (centerX < 64) {
            moveableView?.center = CGPoint(x: 64, y: (moveableView?.center.y)!)
        } else if (centerX > Double(self.audioImageView.frame.size.width) + 64) {
            moveableView?.center = CGPoint(x: self.audioImageView.frame.size.width + 64, y: (moveableView?.center.y)!)
        } else {
            moveableView?.center = CGPoint(x: (moveableView?.center.x)! + translation.x, y: (moveableView?.center.y)!)
        }
        
        sender.setTranslation(CGPoint.zero, in: self.audioImageView)
    }
    
    
}

