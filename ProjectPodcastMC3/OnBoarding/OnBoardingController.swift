//
//  OnBoardingController.swift
//  ProjectPodcastMC3
//
//  Created by Nani Sukma Putri Pratama on 12/08/20.
//  Copyright © 2020 Reynaldi Wijaya. All rights reserved.
//

import UIKit

class OnBoardingController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        podcastHomeAppear()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Show Onboarding if he/she is a new user
        if Core.shared.isNewUser(){
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            let swipeController = FirstOnBoardingController(collectionViewLayout: layout)
            swipeController.modalPresentationStyle = .fullScreen
            present(swipeController, animated: true, completion: nil)
        }else{
            podcastHomeAppear()
        }
        
    }
    
    func podcastHomeAppear(){
        let navController: UINavigationController = UINavigationController()
        navController.viewControllers = [MainTabBarController()]
        UIApplication.shared.windows.first?.rootViewController = navController
    }
}


class Core {
    static let shared = Core()
    
    func isNewUser() -> Bool {
        return !UserDefaults.standard.bool(forKey: "isNewUser")
    }
    func isNotNewUser(){
        UserDefaults.standard.set(true, forKey: "isNewUser")
    }
}
