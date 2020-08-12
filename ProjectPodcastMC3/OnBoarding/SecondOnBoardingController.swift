//
//  SecondOnBoardingController.swift
//  ProjectPodcastMC3
//
//  Created by Nani Sukma Putri Pratama on 12/08/20.
//  Copyright © 2020 Reynaldi Wijaya. All rights reserved.
//

import UIKit

class SecondOnBoardingController: UICollectionViewController , UICollectionViewDelegateFlowLayout {
    
    let infos = [SecondCell(imageContent: "igtvPromo", sizeContent: "1080x1920 pixels", durationContent: "recommended duration 60s", explainationContent: "This new marketing tool is quite exciting and can unlock loads of potential for podcasters. attract your audience with your 1 minute best piece of your podcast clip."),
    SecondCell(imageContent: "igtvMini", sizeContent: "1080x1920 pixels", durationContent: "recommended duration 3 min", explainationContent: "Mini episodes are amazing way to recap episodes you’ve recorded. its not promo content, put the best part from your podcast here."),
    SecondCell(imageContent: "igStory", sizeContent: "1080x1920 pixels", durationContent: "recommended duration 15s", explainationContent: "The first few seconds of your Instagram Story is crucial for capturing and maintaining your audience’s attention. create your fascinating podcast promo content here"),
    SecondCell(imageContent: "feedPromo", sizeContent: "1080x1080 pixels", durationContent: "recommended duration 3 min", explainationContent: "The posts you share to your Instagram feed live on your profile forever. Give your audience the best impression with Instagram feeds promo content")]

    private lazy var pageControl : UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = infos.count
        pc.pageIndicatorTintColor = .gray
        pc.currentPageIndicatorTintColor = .white
       return pc
       }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Content Type"
        label.font = UIFont.boldSystemFont(ofSize: 21.0)
//        Setup font based on design
//        label.font = UIFont(name:"SF Pro Display-Semibold", size: 21.0)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    private let dismissButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "close") as UIImage?
        button.setImage(image, for: .normal)
        return button
        }()
    
    private lazy var gotIt : UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 36/255, green: 84/255, blue: 227/255, alpha: 1.0)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 19.0)
        button.setTitle("Got it, thanks!", for: .normal)
        button.layer.cornerRadius = 5.0
        return button
    }()
    
    func controlPage(){
        view.addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
      }
    func controlButtonDismiss(){
        view.addSubview(dismissButton)
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        dismissButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor , constant: 20).isActive = true
        dismissButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        dismissButton.widthAnchor.constraint(equalTo: dismissButton.widthAnchor, constant: 24).isActive = true
         dismissButton.addTarget(self, action: #selector(tappedButton), for: .touchUpInside)
        
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor , constant: 20).isActive = true
        
    }
    @objc func tappedButton(){
        print("button tapped")
        self.dismiss(animated: true, completion: nil)
    }
    
    func controlButton(){
        view.addSubview(gotIt)
        gotIt.translatesAutoresizingMaskIntoConstraints = false
        gotIt.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        gotIt.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -60).isActive = true
        gotIt.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 60).isActive = true
        gotIt.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -60).isActive = true
        gotIt.heightAnchor.constraint(equalToConstant: 40).isActive = true
        gotIt.addTarget(self, action: #selector(tappedButton), for: .touchUpInside)
    }
    func showButton(){
        controlButton()
        if pageControl.currentPage == 3{
            gotIt.isHidden = false
        }else{
            gotIt.isHidden = true
        }
    }
    
    // Setting spacing between collection to 0 (spacing will invisible)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // Setting up amount of page based on amount of image and title of onBoarding that already set before
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return infos.count
    }
    
    //Setting up view of screen based on couple of image and title of onboarding
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! SecondOnBoardingCell
        let info = infos[indexPath.item]
        cell.info = info
        return cell
    }
    
    // Setting up size of width and height of Collection View
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    // Setting up page control if screen swipe
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        pageControl.currentPage = Int(x / view.frame.width)
        showButton()
    }
    
    //What will show in screen
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = UIColor(red: 1/255, green: 0/255, blue: 17/255, alpha: 1.0)
        collectionView?.register(SecondOnBoardingCell.self, forCellWithReuseIdentifier: "cellID")
        collectionView?.isPagingEnabled = true
        controlPage()
        controlButtonDismiss()
    }
    
}
