//
//  FirstOnBoardingController.swift
//  ProjectPodcastMC3
//
//  Created by Nani Sukma Putri Pratama on 12/08/20.
//  Copyright © 2020 Reynaldi Wijaya. All rights reserved.
//

import UIKit
class FirstOnBoardingController: UICollectionViewController , UICollectionViewDelegateFlowLayout{
    //view of each collectionview
    let pages = [FirstCell(imageName: "image_1", titleImageOnboarding: "1. Choose your content format."),
    FirstCell(imageName: "image_2", titleImageOnboarding: "2. Select or create your own design."),
    FirstCell(imageName: "image_3", titleImageOnboarding: "3. Search or import your podcast."),
    FirstCell(imageName: "image_4", titleImageOnboarding: "4. In the edit audio menu, you’ll ableto trim and merge, split into multiple parts and add sounds."),
    FirstCell(imageName: "image_5", titleImageOnboarding: "5. Distribute your podcast content to your social media.")]
    
    //BottomStackView Member
    //Button PREV
    let buttonPrev : UIButton = {
        let prev = UIButton(type: .system)
        prev.setTitleColor(.white, for: .normal)
        prev.titleLabel?.font = .systemFont(ofSize: 16)
        //Setup font based on design
//        prev.titleLabel?.font = UIFont(name: "SF Pro Text-Semibold", size: 16)
        prev.addTarget(self, action: #selector(handlePrev), for: .touchUpInside)
        return prev
        }()
    //IF Button PREV Pressed
    @objc private func handlePrev(){
        let prevIndex = max(pageControl.currentPage - 1, 0)
        let indexPath = IndexPath(item: prevIndex, section: 0)
        pageControl.currentPage = prevIndex
        apperButton()
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    //Button NEXT
    let buttonNext : UIButton = {
        let next = UIButton(type: .system)
        next.setTitle("NEXT", for: .normal)
        next.titleLabel?.font = .systemFont(ofSize: 16)
        //Setup font based on design
//        next.titleLabel?.font = UIFont(name: "SF Pro Text-Semibold", size: 16)
        next.setTitleColor(.white, for: .normal)
        next.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        return next
       }()
    // Button Next Pressed
    @objc private func handleNext(){
        print("CURRENT\(pageControl.currentPage)")
        //Check if user pressed the last onboarding view and take a action after that
        guard pageControl.currentPage < 4 else {
            Core.shared.isNotNewUser()
            print("success go to view controller")
            let podcastView = PodcastContentController()
            podcastView.modalPresentationStyle = .fullScreen
            present(podcastView, animated: true, completion: nil)
            return
        }
        // if user still in onboarding view
        print("Try to go to NEXT page")
        let nextIndex = min(pageControl.currentPage + 1, pages.count - 1)
        let indexPath = IndexPath(item: nextIndex , section: 0)
        pageControl.currentPage = nextIndex
        apperButton()
        print("NEXTINDEX\(nextIndex), CURRENT PAGE\(pageControl.currentPage)")
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
    }
    // Page Control
    private lazy var pageControl : UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = pages.count
        pc.pageIndicatorTintColor = .gray
        pc.currentPageIndicatorTintColor = .white
        return pc
    }()
    // Button PREV show up and Button NEXT will change to DONE in last onBoarding screen
    func apperButton(){
        if pageControl.currentPage == 0{
            buttonPrev.setTitle("", for: .normal)
        }else{
            buttonPrev.setTitle("PREV", for: .normal)
        }
        if pageControl.currentPage == 4{
            buttonNext.setTitle("DONE", for: .normal)
        }else{
            buttonNext.setTitle("NEXT", for: .normal)
        }
    }
    
    // Setting up PREV button, Page control, and NEXT button in bottom of screen
    private func setupBottomStack(){
        let bottomStack = UIStackView(arrangedSubviews: [buttonPrev,pageControl,buttonNext])
        view.addSubview(bottomStack)
        bottomStack.translatesAutoresizingMaskIntoConstraints = false
        bottomStack.distribution = .fillEqually
        bottomStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        bottomStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        bottomStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor , constant: -40).isActive = true
    }
    
    // Setting spacing between collection to 0 (spacing will invisible)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // Setting up amount of page based on amount of image and title of onBoarding that already set before
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    //Setting up view of screen based on couple of image and title of onboarding
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! FirstOnBoardingCell
        let page = pages[indexPath.item]
        cell.page = page
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
        apperButton()
        print("OVERRIDE SCROLL \(pageControl.currentPage)")
    }
    
    //What will show in screen
    override func viewDidLoad() {
        super.viewDidLoad()
//        collectionView?.backgroundColor = .brown
        collectionView?.register(FirstOnBoardingCell.self, forCellWithReuseIdentifier: "cellID")
        collectionView?.isPagingEnabled = true
        setupBottomStack()
    }
   
}
