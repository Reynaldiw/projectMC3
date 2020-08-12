//
//  HomepageViewController.swift
//  ProjectPodcastMC3
//
//  Created by Mohamad Naufal Nafian on 12/08/20.
//  Copyright © 2020 Reynaldi Wijaya. All rights reserved.
//

import UIKit

class HomepageViewController: UIViewController {
    
//    let addButton: UIButton = {
//        let btn = UIButton()
//        btn.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
//        btn.tintColor = Theme.current.blueColor
//        btn.frame = CGRect(x: 20, y: 0, width: 100, height: 100)
//        return btn
//    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Theme.current.backgroundColor
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController!.navigationBar.barStyle = .black
        navigationItem.title = "Podcast Content"
        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(infoButton))
        let button1 = UIBarButtonItem(image: UIImage(systemName: "plus.circle.fill"), style: .plain, target: self, action: #selector(handleAddButton))
        //let button2 = UIBarButtonItem(customView: addButton)
        self.navigationItem.rightBarButtonItem  = button1
        
    }
    
    @objc func handleAddButton() {
        print("click")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
