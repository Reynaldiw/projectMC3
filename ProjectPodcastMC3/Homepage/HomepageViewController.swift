//
//  HomepageViewController.swift
//  ProjectPodcastMC3
//
//  Created by Mohamad Naufal Nafian on 12/08/20.
//  Copyright © 2020 Reynaldi Wijaya. All rights reserved.
//

import UIKit

class HomepageViewController: UIViewController {
    
    
    let infoLabel: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "label homepage")
        
        return img
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Theme.current.backgroundColor
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController!.navigationBar.barStyle = .black
        navigationItem.title = "Podcast Content"
        
        let button1 = UIBarButtonItem(image: UIImage(systemName: "plus.circle.fill"), style: .plain, target: self, action: #selector(handleAddButton))
        self.navigationItem.rightBarButtonItem  = button1
        
        setupLayout()
        
    }
    
    @objc func handleAddButton() {
        let navController: UINavigationController = UINavigationController()
        navController.viewControllers = [CreateViewController()]
        UIApplication.shared.windows.first?.rootViewController = navController
    }
    
    func setupLayout() {
        view.addSubview(infoLabel)
        infoLabel.anchor(top: nil, bottom: nil, leading: nil, trailing: nil, marginTop: 0, marginBottom: 0, marginLeading: 0, marginTrailing: 0, width: 200, height: 40, centerX: view.centerXAnchor, centerY: view.centerYAnchor, marginFromCenterX: 0, marginFromCenterY: 20  )
    }
    


}
