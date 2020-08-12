//
//  YourDesignViewController.swift
//  ProjectPodcastMC3
//
//  Created by Mohamad Naufal Nafian on 12/08/20.
//  Copyright © 2020 Reynaldi Wijaya. All rights reserved.
//

import UIKit


class YourDesignViewController: UIViewController {
    
    fileprivate var heightConstraintSquare: NSLayoutConstraint?
    fileprivate var heightConstraintPotrait: NSLayoutConstraint?
    var designReadyDelegate: designReadyDelegate!
    var yourDesignCVModel = [YourDesignCVModel]()
    var isPotrait: Bool = false
    var isReady: Bool = true
    var yourDesignViewCell = "DesignViewCell"
    
    
    
    let topContainer : UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    let bottomContainer : UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    
    let collectionView : UICollectionView = {
    
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.scrollDirection = .horizontal
    
        let cv = UICollectionView(frame: .zero , collectionViewLayout: layout)
        cv.backgroundColor = .clear
        return cv
    }()

    lazy var canvasView: UIView = {
    
        let view = UIView()
        view.backgroundColor = Theme.current.accentColor
        view.layer.cornerRadius = 8
        view.isUserInteractionEnabled = true
        return view
    }()
    
    let imageLayers: UIImageView = {

        let img = UIImageView()
        img.image = UIImage(named: "layers")

        return img
    }()
    
    let subLabel : UILabel = {
        let label = UILabel()
        label.text = "Create the Design you like by select the button below"
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = Theme.current.textColor2
        label.textAlignment = .center
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        print("del", delegate)
        // Do any additional setup after loading the view.
        //view.backgroundColor = Theme.current.backgroundColor
            //navigationController?.navigationBar.prefersLargeTitles = false
        
        //print("apakah potrait", isPotrait)
        navigationController?.navigationBar.barTintColor = Theme.current.backgroundColor
        navigationItem.largeTitleDisplayMode = .never
        view.backgroundColor = Theme.current.backgroundColor
        navigationItem.title = "Your Design"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButton))
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        
        yourDesignCVModel = YourDesignCVModel.getDummyData()
        
        heightConstraintSquare =  canvasView.heightAnchor.constraint(equalToConstant: 320)
        heightConstraintPotrait =  canvasView.heightAnchor.constraint(equalToConstant: 570)
        setupLayout()
        
        setupCollectionView()

        
    }
    
    @objc func doneButton() {
        
        self.designReadyDelegate?.didDesignReady(isReady: isReady)
        navigationController?.popToRootViewController(animated: true)
    }
    
    
    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(YourDesignViewCell.self, forCellWithReuseIdentifier: yourDesignViewCell)
        bottomContainer.addSubview(collectionView)
        collectionView.anchor(top: bottomContainer.topAnchor, bottom: nil, leading: bottomContainer.leadingAnchor, trailing:bottomContainer.trailingAnchor, marginTop: 0, marginBottom: -20, marginLeading: 0, marginTrailing: 0, width: 0, height: 108, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
    }
    
    
    func setupLayout() {
        
        view.addSubview(topContainer)
        topContainer.anchor(top: view.topAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, marginTop: 74, marginBottom: -178, marginLeading: 0, marginTrailing: 0, width: 0, height: 0, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        
        view.addSubview(bottomContainer)
        bottomContainer.anchor(top: topContainer.bottomAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, marginTop: 10, marginBottom: -10, marginLeading: 0, marginTrailing: 0, width: 0, height: 0, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        

        
        topContainer.addSubview(canvasView)
        canvasView.translatesAutoresizingMaskIntoConstraints = false
        canvasView.widthAnchor.constraint(equalToConstant: 320).isActive = true
        canvasView.centerXAnchor.constraint(equalTo: topContainer.centerXAnchor, constant: 0).isActive = true
        canvasView.centerYAnchor.constraint(equalTo: topContainer.centerYAnchor, constant: 0).isActive = true
        if isPotrait == true {
            heightConstraintPotrait?.isActive = true
        } else {
            heightConstraintSquare?.isActive = true
        }
        
        canvasView.addSubview(imageLayers)
        imageLayers.anchor(top: nil, bottom: nil, leading: nil, trailing: nil, marginTop: 130, marginBottom: 0, marginLeading: 0, marginTrailing: 0, width: 48, height: 48, centerX: canvasView.centerXAnchor, centerY: canvasView.centerYAnchor, marginFromCenterX: 0, marginFromCenterY: -50)
        
        canvasView.addSubview(subLabel)
        subLabel.anchor(top: imageLayers.bottomAnchor, bottom: nil, leading: canvasView.leadingAnchor, trailing: canvasView.trailingAnchor, marginTop: 20, marginBottom: 0, marginLeading: 70, marginTrailing: -70, width: 0, height: 46, centerX: canvasView.centerXAnchor, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        
        
    }
    

}

extension YourDesignViewController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return yourDesignCVModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: yourDesignViewCell, for: indexPath) as! YourDesignViewCell
        cell.backgroundColor = Theme.current.accentColor
        cell.yourDesignCVModel = yourDesignCVModel[indexPath.item]
        cell.logoImage.image = UIImage(named: yourDesignCVModel[indexPath.item].imageUrl ?? "")
        cell.logoTitle.text = yourDesignCVModel[indexPath.item].title ?? ""
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 104, height: 104)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 0 {
            let ctvc = ChooseTemplateViewController()
            ctvc.isPotrait = isPotrait
            ctvc.designReadyDelegate = designReadyDelegate
            navigationController?.pushViewController(ctvc, animated: true)
        }
    }
    
    
}
