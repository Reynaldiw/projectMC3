//
//  ChooseTemplateViewController.swift
//  ProjectPodcastMC3
//
//  Created by Mohamad Naufal Nafian on 12/08/20.
//  Copyright © 2020 Reynaldi Wijaya. All rights reserved.
//

import UIKit

class ChooseTemplateViewController: UIViewController {
    
    fileprivate var heightConstraintSquare: NSLayoutConstraint?
    fileprivate var heightConstraintPotrait: NSLayoutConstraint?
    var designReadyDelegate: designReadyDelegate!
    var yourDesignCVModel = [YourDesignCVModel]()
    var potraitTemplateModel = [PotraitTemplateModel]()
    var squareTemplateModel = [SquareTemplateModel]()
    var isPotrait: Bool = false
    var isReady: Bool = true
    var yourDesignViewCell = "DesignViewCell"
    var potraitTemplateCell = "potraitTemplateCell"
    var squareTemplateCell = "squareTemplateCell"
    var selectedIndexPath:NSIndexPath?
    var potraitTemplateSelectedNumber: Int?
    var squareTemplateSelectedNumber: Int?
    var potraitTemplateSelected : PotraitTemplateModel?
    var squareTemplateSelected : SquareTemplateModel?
 
    
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
    
    lazy var imageSelected: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "empty")
        img.contentMode = .scaleAspectFit
        return img
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
        
        view.backgroundColor = .red
        navigationController?.navigationBar.barTintColor = Theme.current.backgroundColor
        navigationItem.largeTitleDisplayMode = .never
        view.backgroundColor = Theme.current.backgroundColor
        navigationItem.title = "Template"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Choose", style: .plain, target: self, action: #selector(chooseButton))
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        yourDesignCVModel = YourDesignCVModel.getDummyData()
        potraitTemplateModel = PotraitTemplateModel.getDummyData()
        squareTemplateModel = SquareTemplateModel.getDummyData()
        
        
        heightConstraintSquare =  canvasView.heightAnchor.constraint(equalToConstant: 320)
        heightConstraintPotrait =  canvasView.heightAnchor.constraint(equalToConstant: 568)
        setupLayout()
        setupCollectionView()
        
    }
    
    @objc func chooseButton() {
        let etvc = EditTemplateViewController()
        etvc.isPotrait = isPotrait
        etvc.designReadyDelegate = designReadyDelegate
        
        if isPotrait == true {
            etvc.templatePicked = potraitTemplateSelectedNumber
            etvc.potraitTemplateSelected = potraitTemplateSelected
            
            
            if potraitTemplateSelectedNumber != 0 {
                navigationController?.pushViewController(etvc, animated: true)
            }
        } else {
            etvc.templatePicked = squareTemplateSelectedNumber
            etvc.squareTemplateSelected = squareTemplateSelected
            if squareTemplateSelectedNumber != 0 {
                navigationController?.pushViewController(etvc, animated: true)
            }
        }

    }
    
    
    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PotraitTemplateViewCell.self, forCellWithReuseIdentifier: potraitTemplateCell)
        collectionView.register(SquareTemplateViewCell.self, forCellWithReuseIdentifier: squareTemplateCell)
        
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
//
        canvasView.addSubview(imageLayers)
        imageLayers.anchor(top: nil, bottom: nil, leading: nil, trailing: nil, marginTop: 130, marginBottom: 0, marginLeading: 0, marginTrailing: 0, width: 48, height: 48, centerX: canvasView.centerXAnchor, centerY: canvasView.centerYAnchor, marginFromCenterX: 0, marginFromCenterY: -50)

        canvasView.addSubview(subLabel)
        subLabel.anchor(top: imageLayers.bottomAnchor, bottom: nil, leading: canvasView.leadingAnchor, trailing: canvasView.trailingAnchor, marginTop: 20, marginBottom: 0, marginLeading: 70, marginTrailing: -70, width: 0, height: 46, centerX: canvasView.centerXAnchor, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        
        view.addSubview(imageSelected)
        imageSelected.anchor(top: canvasView.topAnchor, bottom: canvasView.bottomAnchor, leading: canvasView.leadingAnchor, trailing: canvasView.trailingAnchor, marginTop: 0, marginBottom: 0, marginLeading: 0, marginTrailing: 0, width: 0, height: 0, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        
        
    }
    
}


extension ChooseTemplateViewController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isPotrait == true {
            return potraitTemplateModel.count
        } else {
            return squareTemplateModel.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if isPotrait == true {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: potraitTemplateCell, for: indexPath) as! PotraitTemplateViewCell
            cell.potraitTemplateModel = potraitTemplateModel[indexPath.item]
            
            if let selectedIndexPath =  self.selectedIndexPath, indexPath.item == selectedIndexPath.item {
                cell.alpha = 0
            } else {
                cell.alpha = 1
            }
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: squareTemplateCell, for: indexPath) as! SquareTemplateViewCell
            cell.squareTemplateModel = squareTemplateModel[indexPath.item]

            if let selectedIndexPath =  self.selectedIndexPath, indexPath.item == selectedIndexPath.item {
                cell.alpha = 0
            } else {
                cell.alpha = 1
            }
            
            return cell
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 104, height: 104)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
    }
    

    
    /// - Tag: selection
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if isPotrait == true {
            if let cell = collectionView.cellForItem(at: indexPath) as? PotraitTemplateViewCell {
                cell.showSelection()
                canvasView.isHidden = true
                self.imageSelected.image = cell.imageView.image
                self.potraitTemplateSelectedNumber = indexPath.item
                self.potraitTemplateSelected = potraitTemplateModel[indexPath.item]

                //print("potrait selected", potraitTemplateSelected)
            }
        } else {
            if let cell = collectionView.cellForItem(at: indexPath) as? SquareTemplateViewCell {
                cell.showSelection()
                canvasView.isHidden = true
                self.imageSelected.image = cell.imageView.image
                self.squareTemplateSelectedNumber = indexPath.item
                
                self.squareTemplateSelected = squareTemplateModel[indexPath.item]
                //squareTemplateModel[indexPath.item]
                
//                print(squareTemplateModel[indexPath.item])
            }
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if isPotrait == true {
            if let cell = collectionView.cellForItem(at: indexPath) as? PotraitTemplateViewCell {
                cell.hideSelection()
            }
        } else {
            if let cell = collectionView.cellForItem(at: indexPath) as? SquareTemplateViewCell {
                cell.hideSelection()
            }
        }

    }
    
    
    
    
}
