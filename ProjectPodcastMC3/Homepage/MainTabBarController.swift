//
//  MainTabBarController.swift
//  ProjectPodcastMC3
//
//  Created by Mohamad Naufal Nafian on 12/08/20.
//  Copyright © 2020 Reynaldi Wijaya. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    var isLogin: Bool = false
    
    override func viewDidLoad(){
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        //self.navigationController?.setNavigationBarHidden(true, animated: animated)
        
        setupTabBar()
    }
    
    func setupTabBar() {
        tabBar.tintColor = Theme.current.blueColor
        tabBar.barTintColor = Theme.current.accentColor
        
        let podcast = UINavigationController(rootViewController: VideoCollectionsViewController())
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
        if selectedIndex == 0 {
        } else {
            let alert = UIAlertController(title: "Account Setting", message: nil, preferredStyle: .actionSheet)
            
            let keyOfLogin = KeychainWrapper.standard.string(forKey: Constants.KEY_UID_KEYCHAIN)
            
            isLogin = keyOfLogin != nil
            
            let message: String?
            if isLogin == true {
                message = "Logout"
            } else {
                message = "Login"
            }
            
            alert.addAction(UIAlertAction(title: message, style: .default, handler: { (alertAction) in
                if !self.isLogin {
                    let vc = LoginViewController()
                    vc.callback = { isLogin in
                        self.isLogin = isLogin
                    }
                    self.navigationController?.present(vc, animated: true, completion: nil)
                } else {
                    KeychainWrapper.standard.removeObject(forKey: Constants.KEY_UID_KEYCHAIN)
                    createAlertAndShowAlert(title: nil, message: "Success to Logout!", actionName: "Okay", caller: self, handler: nil)
                }
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

            self.present(alert, animated: true)
        }
    }
    
    
}
