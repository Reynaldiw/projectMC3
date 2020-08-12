//
//  MainTabBarController.swift
//  ProjectPodcastMC3
//
//  Created by Mohamad Naufal Nafian on 12/08/20.
//  Copyright © 2020 Reynaldi Wijaya. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        
        setupTabBar()
    }
    
    func setupTabBar() {
        tabBar.tintColor = Theme.current.blueColor
        tabBar.barTintColor = Theme.current.accentColor
        //tabBar.backgroundColor = Theme.current.accentColor
       // navigationController?.navigationBar.isHidden = true
        
        let podcast = UINavigationController(rootViewController: HomepageViewController())
        podcast.tabBarItem.image = UIImage(systemName: "house")
        podcast.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        
        let account = UINavigationController(rootViewController: HomepageViewController())
        account.tabBarItem.image = UIImage(systemName: "person.circle")
        account.tabBarItem.selectedImage = UIImage(systemName: "person.circle.fill")
        
        viewControllers = [podcast, account]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    
    override var selectedViewController: UIViewController? {
        didSet {
            tabChangedTo(selectedIndex: selectedIndex)
        }
    }
    
    override var selectedIndex: Int {
        didSet {
            tabChangedTo(selectedIndex: selectedIndex)
        }
    }
    
    func tabChangedTo(selectedIndex: Int) {
            
    }
    
    
}
