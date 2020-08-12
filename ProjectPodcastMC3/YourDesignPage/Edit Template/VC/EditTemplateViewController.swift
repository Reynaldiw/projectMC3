//
//  EditTemplateViewController.swift
//  ProjectPodcastMC3
//
//  Created by Mohamad Naufal Nafian on 12/08/20.
//  Copyright © 2020 Reynaldi Wijaya. All rights reserved.
//

import UIKit




class EditTemplateViewController: UIViewController, UINavigationControllerDelegate {
    
    fileprivate var heightConstraintSquare: NSLayoutConstraint?
    fileprivate var heightConstraintPotrait: NSLayoutConstraint?
    fileprivate var colorBoxTopAnchor1: NSLayoutConstraint?
    fileprivate var colorBoxTopAnchor2: NSLayoutConstraint?
    
    var designReadyDelegate: designReadyDelegate!
    //var designReadyDelegate: designReadyDelegate!
    var yourDesignCVModel = [YourDesignCVModel]()
    var potraitTemplateModel = [PotraitTemplateModel]()
    var squareTemplateModel = [SquareTemplateModel]()
    var isPotrait: Bool = false
    var isReady: Bool = true
    var yourDesignViewCell = "DesignViewCell"
    var potraitTemplateCell = "potraitTemplateCell"
    var squareTemplateCell = "squareTemplateCell"
    var templatePicked : Int?
    var potraitTemplateSelected: PotraitTemplateModel?
    var squareTemplateSelected: SquareTemplateModel?
    var titleText: String = ""
    var colorPicked: UIColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 1)
    
    
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
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
    

    lazy var canvasView: UIView = {
    
        let view = UIView()
        view.backgroundColor = Theme.current.accentColor
        view.layer.cornerRadius = 8
        view.isUserInteractionEnabled = true
        return view
    }()
    
    var image0square: ImageSquare1Template!
    var image1square: ImageSquare1Template!
    var image2square: ImageSquare2Template!
    
    var image0potrait: ImagePotrait1Template!
    var image1potrait: ImagePotrait1Template!
    var image2potrait: ImagePotrait2Template!
    
    
    
    var collectionUIView = [UIView]()
    
    
    
    lazy var customizeTemplateView: UIView = {
        let view = UIView()
        view.backgroundColor = Theme.current.accentColor
        view.layer.cornerRadius = 8
        view.isUserInteractionEnabled = true
        return view
    }()
    
    
    var templatePickedView: UIView!
    
    
    var customizeTemplateTitle : UILabel = {
        let label = UILabel()
        label.text = "CUSTOMIZE TEMPLATE"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        label.textColor = Theme.current.textColor1
        return label
    }()
    
    var uploadButtonTitle : UILabel = {
        let label = UILabel()
        label.text = "BACKGROUND IMAGE"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = Theme.current.textColor1
        return label
    }()
    
    var uploadButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Upload Image", for: .normal)
        btn.setTitleColor(Theme.current.textColor1, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.backgroundColor = Theme.current.purpleColor
        btn.layer.cornerRadius = 26
        btn.addTarget(self, action: #selector(uploadImage), for: .touchUpInside)
        return btn
    }()
    
    var uploadedImageBox: UIImageView = {
        let images = UIImageView()
        images.image = UIImage(named: "FreddieSquare")
        images.contentMode = .scaleToFill
        images.layer.borderWidth = 2
        images.isHidden = true
        
        return images
    }()
    
    var titleTextFieldTitle : UILabel = {
        let label = UILabel()
        label.text = "TITLE"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = Theme.current.textColor1
        return label
    }()
    
    var titleTextField: UITextField = {
        let tf = UITextField()
        tf.layer.borderWidth = 1
        tf.layer.borderColor = CGColor.rgb(red: 255, green: 255, blue: 255, alpha: 1)
        tf.layer.cornerRadius = 2
        
        tf.attributedPlaceholder = NSAttributedString(string: "Podcast", attributes: [NSAttributedString.Key.foregroundColor : Theme.current.textColor2, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)])
        tf.autocorrectionType = UITextAutocorrectionType.no
        tf.keyboardType = UIKeyboardType.default
        tf.returnKeyType = UIReturnKeyType.done
        tf.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        
        tf.layer.backgroundColor = Theme.current.backgroundColor.cgColor
        tf.setLeftPaddingPoints(10)
        tf.backgroundColor = .clear
        tf.textColor = Theme.current.textColor1
        tf.addTarget(self, action: #selector(EditTemplateViewController.titleTextFieldDidChange(_:)), for: .editingChanged)
        
        return tf
    }()
    
    
    var colorPickerTitle : UILabel = {
        let label = UILabel()
        label.text = "COLOR PICKER"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = Theme.current.textColor1
        return label
    }()
    

    
    lazy var colorBox: UIView = {
        let view = UIView()

        view.layer.borderWidth = 2
        view.layer.borderColor = CGColor.rgb(red: 255, green: 255, blue: 255, alpha: 1)
        view.backgroundColor = .white
        view.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(onClickColorButton))
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1

        view.addGestureRecognizer(tap)
        
        return view
    }()
    
    var generateButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Generate Template", for: .normal)
        btn.setTitleColor(Theme.current.textColor1, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 19)
        btn.backgroundColor = Theme.current.purpleColor
        btn.layer.cornerRadius = 6
        btn.addTarget(self, action: #selector(generateButtonHandler), for: .touchUpInside)
        return btn
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //print("apakah potrait", isPotrait)

        navigationController?.navigationBar.barTintColor = Theme.current.backgroundColor
        navigationItem.largeTitleDisplayMode = .never
        view.backgroundColor = Theme.current.backgroundColor
        navigationItem.title = "Template"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Choose", style: .plain, target: self, action: #selector(chooseButton))
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        
        
        self.image0square = ImageSquare1Template()
        self.image1square = ImageSquare1Template()
        self.image2square = ImageSquare2Template()
        
        self.image0potrait = ImagePotrait1Template()
        self.image1potrait = ImagePotrait1Template()
        self.image2potrait = ImagePotrait2Template()
        
        //self.collectionUIView = [self.image0, self.image1, self.image2]
        
        if isPotrait == true {
            
            switch templatePicked {
            case 1:
                self.templatePickedView = self.image1potrait
            case 2:
                self.templatePickedView = self.image2potrait
            default:
                self.templatePickedView = self.image1potrait
            }
            
        } else {
            switch templatePicked {
            case 1:
                self.templatePickedView = self.image1square
            case 2:
                self.templatePickedView = self.image2square
            default:
                self.templatePickedView = self.image1square
            }
        }

        
        
        
        
        
        
        titleTextField.delegate = self
        //descTextField.delegate = self
        
        yourDesignCVModel = YourDesignCVModel.getDummyData()
        potraitTemplateModel = PotraitTemplateModel.getDummyData()
        squareTemplateModel = SquareTemplateModel.getDummyData()
        
        colorBoxTopAnchor1 = colorPickerTitle.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 24)
        colorBoxTopAnchor2 = colorPickerTitle.topAnchor.constraint(equalTo: uploadButton.bottomAnchor, constant: 24)
        
        
        heightConstraintSquare =  canvasView.heightAnchor.constraint(equalToConstant: 374)
        heightConstraintPotrait =  canvasView.heightAnchor.constraint(equalToConstant: 640)
        setupScrollView()
        setupLayout()
        
        //print("adakah TF1", squareTemplateSelected?.isTextField1)

        
        //collectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .left)
    }
    
    @objc func chooseButton() {
        
        print(designReadyDelegate)
        
        UIGraphicsBeginImageContext(canvasView.frame.size)
        canvasView.layer.render(in: UIGraphicsGetCurrentContext()!)
        
        
        
        
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return }
        UIGraphicsEndImageContext()
        
        designReadyDelegate.isDesignPotrait(potrait: isPotrait)
        designReadyDelegate.imageReady(image: image)
        designReadyDelegate.didDesignReady(isReady: true)
        navigationController?.popToRootViewController(animated: true)
        
    }
    
    @objc func onClickColorButton() {
        let cc = ChromaColor()
        
        cc.selectedColorDelegate = self
        navigationController?.pushViewController(cc, animated: true)
    }
    
    @objc func uploadImage() {
        showImagePickerControllerAlert()
    }
    
    @objc func titleTextFieldDidChange(_ textField: UITextField) {
        //print(textField.text)
        self.titleText = textField.text ?? ""
        
    }
    
    @objc func generateButtonHandler() {
        
        
        if isPotrait == true {
            switch templatePicked {
            case 1:
                self.image1potrait.contentImage.image = uploadedImageBox.image
                //self.image1potrait.backgroundImage.image = uploadedImageBox.image
                self.image1potrait.waveformImage.setImageColor(color: colorPicked)
                self.image1potrait.titleText.text = titleText
            case 2:
                self.image2potrait.contentImage.image = uploadedImageBox.image
                //self.image2potrait.backgroundImage.image = uploadedImageBox.image
                self.image2potrait.titleText.text = titleText
                self.image2potrait.waveformImage.setImageColor(color: colorPicked)
            default:
                self.image1potrait.contentImage.image = uploadedImageBox.image
                //self.image1potrait.backgroundImage.image = uploadedImageBox.image
                self.image1potrait.waveformImage.setImageColor(color: colorPicked)
                self.image1potrait.titleText.text = titleText
            }
        } else {
                switch templatePicked {
                case 1:
                    self.image1square.contentImage.image = uploadedImageBox.image
                    self.image1square.backgroundImage.image = uploadedImageBox.image
                    self.image1square.waveformImage.setImageColor(color: colorPicked)
                case 2:
                    self.image2square.contentImage.image = uploadedImageBox.image
                    self.image2square.backgroundImage.image = uploadedImageBox.image
                    self.image2square.titleText.text = titleText
                    self.image2square.waveformImage.setImageColor(color: colorPicked)
                default:
                    self.image1square.contentImage.image = uploadedImageBox.image
                    self.image1square.backgroundImage.image = uploadedImageBox.image
                    self.image1square.waveformImage.setImageColor(color: colorPicked)
                }
            }
            
        }
        
        

    
    
    
    
    func setupScrollView(){

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = Theme.current.backgroundColor
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = Theme.current.backgroundColor
        
        view.addSubview(scrollView)

        
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        //scrollView.isScrollEnabled = true
        
        scrollView.addSubview(contentView)
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        //contentView.heightAnchor.constraint(equalToConstant: 1000).isActive = true
        
        if isPotrait == true {
            contentView.heightAnchor.constraint(equalToConstant: 1300).isActive = true
        } else {
            contentView.heightAnchor.constraint(equalToConstant: 1300).isActive = false
            contentView.heightAnchor.constraint(equalToConstant: 1000).isActive = true
        }
    }
    
//
    
    func setupLayout() {
        
        contentView.addSubview(topContainer)
        topContainer.anchor(top: contentView.topAnchor, bottom: nil, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, marginTop: 0, marginBottom: 0, marginLeading: 0, marginTrailing: 0, width: 0, height: 1369-577-40, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        
        contentView.addSubview(bottomContainer)
        bottomContainer.anchor(top: topContainer.bottomAnchor, bottom: contentView.bottomAnchor, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, marginTop: 10, marginBottom: 0, marginLeading: 0, marginTrailing: 0, width: 0, height: 0, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        
        contentView.addSubview(canvasView)

        canvasView.translatesAutoresizingMaskIntoConstraints = false
        canvasView.widthAnchor.constraint(equalToConstant: 374).isActive = true
        canvasView.centerXAnchor.constraint(equalTo: topContainer.centerXAnchor, constant: 0).isActive = true
        canvasView.topAnchor.constraint(equalTo: topContainer.topAnchor, constant: 24).isActive = true
        //canvasView.centerYAnchor.constraint(equalTo: topContainer.centerYAnchor, constant: 0).isActive = true
        if isPotrait == true {
            heightConstraintPotrait?.isActive = true
        } else {
            heightConstraintSquare?.isActive = true
        }
        

        
//        canvasView.addSubview(image2)
//        image2.anchor(top: canvasView.topAnchor, bottom: canvasView.bottomAnchor, leading: canvasView.leadingAnchor, trailing: canvasView.trailingAnchor, marginTop: 0, marginBottom: 0, marginLeading: 0, marginTrailing: 0, width: 0, height: 0, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        
        canvasView.addSubview(templatePickedView)
        templatePickedView.anchor(top: canvasView.topAnchor, bottom: canvasView.bottomAnchor, leading: canvasView.leadingAnchor, trailing: canvasView.trailingAnchor, marginTop: 0, marginBottom: 0, marginLeading: 0, marginTrailing: 0, width: 0, height: 0, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        
        
        contentView.addSubview(customizeTemplateView)
        customizeTemplateView.anchor(top: canvasView.bottomAnchor, bottom: bottomContainer.bottomAnchor, leading: bottomContainer.leadingAnchor, trailing: bottomContainer.trailingAnchor, marginTop: 48, marginBottom: -74, marginLeading: 20, marginTrailing: -20, width: 0, height: 0, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        
        customizeTemplateView.addSubview(customizeTemplateTitle)
        customizeTemplateTitle.anchor(top: customizeTemplateView.topAnchor, bottom: nil, leading: customizeTemplateView.leadingAnchor, trailing: customizeTemplateView.trailingAnchor, marginTop: 24, marginBottom: 0, marginLeading: 8, marginTrailing: -8, width: 0, height: 0, centerX: customizeTemplateView.centerXAnchor, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        
        
        customizeTemplateView.addSubview(uploadButtonTitle)
        uploadButtonTitle.anchor(top: customizeTemplateTitle.bottomAnchor, bottom: nil, leading: customizeTemplateView.leadingAnchor, trailing: nil, marginTop: 56, marginBottom: 0, marginLeading: 20, marginTrailing: 0, width: 0, height: 0, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        
        customizeTemplateView.addSubview(uploadButton)
        uploadButton.anchor(top: uploadButtonTitle.bottomAnchor, bottom: nil, leading: customizeTemplateView.leadingAnchor, trailing: nil, marginTop: 16, marginBottom: 0, marginLeading: 20, marginTrailing: 0, width: 142, height: 40, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        
        customizeTemplateView.addSubview(uploadedImageBox)
        uploadedImageBox.anchor(top: uploadButton.topAnchor, bottom: nil, leading: uploadButton.trailingAnchor, trailing: nil, marginTop: 0, marginBottom: 0, marginLeading: 20, marginTrailing: 0, width: 40, height: 40, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        
        customizeTemplateView.addSubview(titleTextFieldTitle)
        titleTextFieldTitle.anchor(top: uploadButton.bottomAnchor, bottom: nil, leading: customizeTemplateView.leadingAnchor, trailing: nil, marginTop: 24, marginBottom: 0, marginLeading: 20, marginTrailing: 0, width: 0, height: 0, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        
        customizeTemplateView.addSubview(titleTextField)
        titleTextField.anchor(top: titleTextFieldTitle.bottomAnchor, bottom: nil, leading: customizeTemplateView.leadingAnchor, trailing: nil, marginTop: 16, marginBottom: 0, marginLeading: 20, marginTrailing: 0, width: 334, height: 40, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        
        customizeTemplateView.addSubview(colorPickerTitle)
        colorPickerTitle.translatesAutoresizingMaskIntoConstraints = false
        
        print("square textfield", squareTemplateSelected?.isTextField1)
        print("potrait textfield", potraitTemplateSelected?.isTextField1)
        
        if squareTemplateSelected?.isTextField1 == true || potraitTemplateSelected?.isTextField1 == true {
            colorBoxTopAnchor1?.isActive = true
            colorPickerTitle.leadingAnchor.constraint(equalTo: customizeTemplateView.leadingAnchor, constant: 20).isActive = true
        } else {
            titleTextField.removeFromSuperview()
            titleTextFieldTitle.removeFromSuperview()
            colorBoxTopAnchor1?.isActive = false
            colorBoxTopAnchor2?.isActive = true
            colorPickerTitle.leadingAnchor.constraint(equalTo: customizeTemplateView.leadingAnchor, constant: 20).isActive = true
        }
        
        customizeTemplateView.addSubview(colorBox)
        colorBox.anchor(top: colorPickerTitle.bottomAnchor, bottom: nil, leading: customizeTemplateView.leadingAnchor, trailing: nil, marginTop: 16, marginBottom: 0, marginLeading: 20, marginTrailing: 0, width: 40, height: 40, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        
        customizeTemplateView.addSubview(generateButton)
        generateButton.anchor(top: nil, bottom: customizeTemplateView.bottomAnchor, leading: nil, trailing: nil, marginTop: 0, marginBottom: -32, marginLeading: 0, marginTrailing: 0, width: 300, height: 44, centerX: customizeTemplateView.centerXAnchor, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        
    }
    

    
}




extension EditTemplateViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
}

extension EditTemplateViewController: colorPickedChromaDelegate {
    func didColorChoices(color: UIColor) {
        print("Color in ViewController", color)
        colorBox.backgroundColor = color
        self.colorPicked = color
    }

}

extension EditTemplateViewController : UIImagePickerControllerDelegate {
    
    
    func showImagePickerControllerAlert() {
        
        let photoLibraryAction = UIAlertAction(title: "Choose From Library", style: .default) { (action) in
            self.showImagePickerController(sourceType: .photoLibrary)
        }
        
        let cameraAction = UIAlertAction(title: "Choose From Camera", style: .default) { (action) in
            self.showImagePickerController(sourceType: .camera)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        AlertService.showAlert(style: .actionSheet, title: "Choose your Image", message: nil, actions: [photoLibraryAction, cameraAction, cancelAction], completion: nil)
    }
    
    func showImagePickerController(sourceType: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    //dismiss after picking
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true, completion: nil)
        
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            uploadedImageBox.image = editedImage
        } else if let oriImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            uploadedImageBox.image = oriImage
        }
        
        uploadedImageBox.isHidden = false
        
    }
}

