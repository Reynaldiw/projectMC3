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
    var yourDesignCVModel = [YourDesignCVModel]()
    var potraitTemplateModel = [PotraitTemplateModel]()
    var squareTemplateModel = [SquareTemplateModel]()
    var isPotrait: Bool = false
    var isReady: Bool = true
    var templatePicked : Int?
    var potraitTemplateSelected: PotraitTemplateModel?
    var squareTemplateSelected: SquareTemplateModel?
    var titleText: String = ""
    var colorPicked: UIColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 1)
    var imageForSend : UIImage?
    var templatePickedView: UIView!
    var templatePickedViewForSend: UIView!
    var waveformPosition: String?
    
    
    
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
    
    var image0square: ImageSquare1Template! = ImageSquare1Template()
    var image1square: ImageSquare1Template! = ImageSquare1Template()
    var image2square: ImageSquare2Template! = ImageSquare2Template()
    var image3square: ImageSquare3Template! = ImageSquare3Template()
    var image4square: ImageSquare4Template! = ImageSquare4Template()
    var image5square: ImageSquare5Template! = ImageSquare5Template()
    var image6square: ImageSquare6Template! = ImageSquare6Template()
    var image7square: ImageSquare7Template! = ImageSquare7Template()
    
    var image0squareForSend: ImageSquare1Template! = ImageSquare1Template()
    var image1squareForSend: ImageSquare1Template! = ImageSquare1Template()
    var image2squareForSend: ImageSquare2Template! = ImageSquare2Template()
    var image3squareForSend: ImageSquare3Template! = ImageSquare3Template()
    var image4squareForSend: ImageSquare4Template! = ImageSquare4Template()
    var image5squareForSend: ImageSquare5Template! = ImageSquare5Template()
    var image6squareForSend: ImageSquare6Template! = ImageSquare6Template()
    var image7squareForSend: ImageSquare7Template! = ImageSquare7Template()

    
    var image0potrait: ImagePotrait1Template! = ImagePotrait1Template()
    var image1potrait: ImagePotrait1Template! = ImagePotrait1Template()
    var image2potrait: ImagePotrait2Template! = ImagePotrait2Template()
    var image3potrait: ImagePotrait3Template! = ImagePotrait3Template()
    var image4potrait: ImagePotrait4Template! = ImagePotrait4Template()
    var image5potrait: ImagePotrait5Template! = ImagePotrait5Template()
    var image6potrait: ImagePotrait6Template! = ImagePotrait6Template()
    
    var image0potraitForSend: ImagePotrait1Template! = ImagePotrait1Template()
    var image1potraitForSend: ImagePotrait1Template! = ImagePotrait1Template()
    var image2potraitForSend: ImagePotrait2Template! = ImagePotrait2Template()
    var image3potraitForSend: ImagePotrait3Template! = ImagePotrait3Template()
    var image4potraitForSend: ImagePotrait4Template! = ImagePotrait4Template()
    var image5potraitForSend: ImagePotrait5Template! = ImagePotrait5Template()
    var image6potraitForSend: ImagePotrait6Template! = ImagePotrait6Template()

    

    lazy var customizeTemplateView: UIView = {
        let view = UIView()
        view.backgroundColor = Theme.current.accentColor
        view.layer.cornerRadius = 8
        view.isUserInteractionEnabled = true
        return view
    }()

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
        


        navigationController?.navigationBar.barTintColor = Theme.current.backgroundColor
        navigationItem.largeTitleDisplayMode = .never
        view.backgroundColor = Theme.current.backgroundColor
        navigationItem.title = "Template"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Choose", style: .plain, target: self, action: #selector(chooseButton))
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
       
        fillTemplatePickedView()
        titleTextField.delegate = self

        yourDesignCVModel = YourDesignCVModel.getDummyData()
        potraitTemplateModel = PotraitTemplateModel.getDummyData()
        squareTemplateModel = SquareTemplateModel.getDummyData()
        
        fillWaveformPosition()
        
        colorBoxTopAnchor1 = colorPickerTitle.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 24)
        colorBoxTopAnchor2 = colorPickerTitle.topAnchor.constraint(equalTo: uploadButton.bottomAnchor, constant: 24)
        
        
        heightConstraintSquare =  canvasView.heightAnchor.constraint(equalToConstant: 374)
        heightConstraintPotrait =  canvasView.heightAnchor.constraint(equalToConstant: 640)
        setupScrollView()
        setupLayout()
        
    }
    
    @objc func chooseButton() {
        
        
        
        UIGraphicsBeginImageContext(canvasView.frame.size)
        canvasView.layer.render(in: UIGraphicsGetCurrentContext()!)
        

        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return }
        UIGraphicsEndImageContext()
        
        designReadyDelegate.isDesignPotrait(potrait: isPotrait)
        designReadyDelegate.imageReady(image: image)
        designReadyDelegate.didDesignReady(isReady: true)
        designReadyDelegate.didAudioReady(isReady: true)
        designReadyDelegate.waveformColor(color: colorPicked)
        designReadyDelegate.waveformPosition(position: waveformPosition!)
        
        
        

        //send the image disnt have waveform for the BE
        //fill imagepotraitforsend and dismiss the waveform
        eraseWaveform()
        //convert as an image
        templatePickedViewForSend.alpha = 1
        imageForSend = templatePickedViewForSend.asImage()
        //make not visible in  view
        templatePickedViewForSend.alpha = 0
        designReadyDelegate.imageForSend(image: imageForSend!)
        uploadedImageBox.image = imageForSend
        uploadedImageBox.isHidden = false
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
        self.titleText = textField.text ?? ""
        
    }
    
    @objc func generateButtonHandler() {
        
        //generate the edited template
        generateTemplateEdited()
        templatePickedViewForSend.alpha = 0
        
        
    }
    
    
    func fillWaveformPosition() {
        if isPotrait == true {
            self.waveformPosition = potraitTemplateModel[templatePicked!].waveformPosition
        } else {
            self.waveformPosition = squareTemplateModel[templatePicked!].waveformPosition
        }
    }
    
    func fillTemplatePickedView() {
        if isPotrait == true {
            switch templatePicked {
            case 1:
                self.templatePickedView = self.image1potrait
                self.templatePickedViewForSend = self.image1potraitForSend
                self.uploadedImageBox.image = self.image1potrait.contentImage.image
                self.titleText = self.image1potrait.titleText.text!
            case 2:
                self.templatePickedView = self.image2potrait
                self.templatePickedViewForSend = self.image2potraitForSend
                self.uploadedImageBox.image = self.image2potrait.contentImage.image
            case 3:
                self.templatePickedView = self.image3potrait
                self.templatePickedViewForSend = self.image3potraitForSend
                self.uploadedImageBox.image = self.image3potrait.contentImage.image
                self.titleText = self.image3potrait.contentText.text!
            case 4:
                self.templatePickedView = self.image4potrait
                self.templatePickedViewForSend = self.image4potraitForSend
                self.uploadedImageBox.image = self.image4potrait.backgroundImage.image
                self.titleText = self.image4potrait.contentText.text!
            case 5:
                self.templatePickedView = self.image5potrait
                self.templatePickedViewForSend = self.image5potraitForSend
                self.uploadedImageBox.image = self.image5potrait.backgroundImage.image
                self.titleText = self.image5potrait.contentText.text!
            case 6:
                self.templatePickedView = self.image6potrait
                self.templatePickedViewForSend = self.image6potraitForSend
                self.uploadedImageBox.image = self.image6potrait.contentImage.image
                self.titleText = self.image6potrait.contentText.text!
            default:
                self.templatePickedView = self.image1potrait
                self.templatePickedViewForSend = self.image1potraitForSend
                self.uploadedImageBox.image = self.image1potrait.contentImage.image
                self.titleText = self.image1potrait.titleText.text!
            }
            
        } else {
            switch templatePicked {
            case 1:
                self.templatePickedView = self.image1square
                self.templatePickedViewForSend = self.image1squareForSend
                self.uploadedImageBox.image = self.image1square.contentImage.image
            case 2:
                self.templatePickedView = self.image2square
                self.templatePickedViewForSend = self.image2squareForSend
                self.uploadedImageBox.image = self.image2square.contentImage.image
                self.titleText = self.image2square.titleText.text!
            case 3:
                self.templatePickedView = self.image3square
                self.templatePickedViewForSend = self.image3squareForSend
                self.uploadedImageBox.image = self.image3square.contentImage.image
            case 4:
                self.templatePickedView = self.image4square
                self.templatePickedViewForSend = self.image4squareForSend
                self.uploadedImageBox.image = self.image4square.contentImage.image
                self.titleText = self.image4square.contentText.text!
            case 5:
                self.templatePickedView = self.image5square
                self.templatePickedViewForSend = self.image5squareForSend
                self.uploadedImageBox.image = self.image5square.backgroundImage.image
                self.titleText = self.image5square.contentText.text!
            case 6:
                self.templatePickedView = self.image6square
                self.templatePickedViewForSend = self.image6squareForSend
                self.uploadedImageBox.image = self.image6square.backgroundImage.image
                self.titleText = self.image6square.contentText.text!
            case 7:
                self.templatePickedView = self.image7square
                self.templatePickedViewForSend = self.image7squareForSend
                self.uploadedImageBox.image = self.image7square.contentImage.image
                self.titleText = self.image7square.contentText.text!
                self.titleText = self.image7square.contentText.text!
            default:
                self.templatePickedView = self.image1square
                self.templatePickedViewForSend = self.image1squareForSend
                self.uploadedImageBox.image = self.image1square.contentImage.image
                
            }
        }
    }
    
    func eraseWaveform() {
        
        if isPotrait == true {
            switch templatePicked {
            case 1:
                self.image1potraitForSend.contentImage.image = uploadedImageBox.image
                self.image1potraitForSend.titleText.text = titleText
                self.image1potraitForSend.waveformImage.isHidden = true
            case 2:
                self.image2potraitForSend.contentImage.image = uploadedImageBox.image
                //                   self.image2potraitForSend.titleText.text = titleText
                self.image2potraitForSend.waveformImage.isHidden = true
            case 3:
                self.image3potraitForSend.contentImage.image = uploadedImageBox.image
                self.image3potraitForSend.contentText.text = titleText
                self.image3potraitForSend.waveformImage.isHidden = true
            case 4:
                self.image4potraitForSend.backgroundImage.image = uploadedImageBox.image
                self.image4potraitForSend.contentText.text = titleText
                self.image4potraitForSend.waveformImage.isHidden = true
            case 5:
                self.image5potraitForSend.backgroundImage.image = uploadedImageBox.image
                self.image5potraitForSend.contentText.text = titleText
                self.image5potraitForSend.waveformImage.isHidden = true
            case 6:
                self.image6potraitForSend.contentImage.image = uploadedImageBox.image
                self.image6potraitForSend.contentText.text = titleText
                self.image6potraitForSend.waveformImage.isHidden = true
            default:
                self.image1potraitForSend.contentImage.image = uploadedImageBox.image
                self.image1potraitForSend.titleText.text = titleText
                self.image1potraitForSend.waveformImage.isHidden = true
            }
        } else {
            switch templatePicked {
            case 1:
                self.image1squareForSend.contentImage.image = uploadedImageBox.image
                self.image1squareForSend.backgroundImage.image = uploadedImageBox.image
                self.image1squareForSend.waveformImage.isHidden = true
            case 2:
                self.image2squareForSend.contentImage.image = uploadedImageBox.image
                self.image2squareForSend.backgroundImage.image = uploadedImageBox.image
                self.image2squareForSend.titleText.text = titleText
                self.image2squareForSend.waveformImage.isHidden = true
            case 3:
                self.image3squareForSend.contentImage.image = uploadedImageBox.image
                self.image3squareForSend.backgroundImage.image = uploadedImageBox.image
                self.image3squareForSend.waveformImage.isHidden = true
            case 4:
                self.image4squareForSend.contentImage.image = uploadedImageBox.image
                self.image4squareForSend.backgroundImage.image = uploadedImageBox.image
                self.image4squareForSend.contentText.text = titleText
                self.image4squareForSend.waveformImage.isHidden = true
            case 5:
                self.image5squareForSend.backgroundImage.image = uploadedImageBox.image
                self.image5squareForSend.backgroundImage.image = uploadedImageBox.image
                self.image5squareForSend.contentText.text = titleText
                self.image5squareForSend.waveformImage.isHidden = true
            case 6:
                self.image6squareForSend.backgroundImage.image = uploadedImageBox.image
                self.image6squareForSend.backgroundImage.image = uploadedImageBox.image
                self.image6squareForSend.contentText.text = titleText
                self.image6squareForSend.waveformImage.isHidden = true
            case 7:
                self.image7squareForSend.contentImage.image = uploadedImageBox.image
                self.image7squareForSend.backgroundImage.image = uploadedImageBox.image
                self.image7squareForSend.contentText.text = titleText
                self.image7squareForSend.waveformImage.isHidden = true
                
            default:
                self.image1squareForSend.contentImage.image = uploadedImageBox.image
                self.image1squareForSend.backgroundImage.image = uploadedImageBox.image
                self.image1squareForSend.waveformImage.isHidden = true
            }
        }
    }
    
    func generateTemplateEdited() {
        if isPotrait == true {
            switch templatePicked {
            case 1:
                self.image1potrait.contentImage.image = uploadedImageBox.image
                self.image1potrait.waveformImage.setImageColor(color: colorPicked)
                self.image1potrait.titleText.text = titleText
            case 2:
                self.image2potrait.contentImage.image = uploadedImageBox.image
                self.image2potrait.waveformImage.setImageColor(color: colorPicked)
            case 3:
                self.image3potrait.contentImage.image = uploadedImageBox.image
                self.image3potrait.waveformImage.setImageColor(color: colorPicked)
                self.image3potrait.contentText.text = titleText
            case 4:
                self.image4potrait.backgroundImage.image = uploadedImageBox.image
                self.image4potrait.waveformImage.setImageColor(color: colorPicked)
                self.image4potrait.contentText.text = titleText
            case 5:
                self.image5potrait.backgroundImage.image = uploadedImageBox.image
                self.image5potrait.waveformImage.setImageColor(color: colorPicked)
                self.image5potrait.contentText.text = titleText
            case 6:
                self.image6potrait.contentImage.image = uploadedImageBox.image
                self.image6potrait.waveformImage.setImageColor(color: colorPicked)
                self.image6potrait.contentText.text = titleText
            default:
                self.image1potrait.contentImage.image = uploadedImageBox.image
                self.image1potrait.waveformImage.setImageColor(color: colorPicked)
                self.image1potrait.titleText.text = titleText
            }
        } else {
            switch templatePicked {
            case 1:
                self.image1square.contentImage.image = uploadedImageBox.image
                self.image1square.backgroundImage.image = uploadedImageBox.image
                self.image1square.waveformImage.setImageColor(color: colorPicked)
                
                self.image1squareForSend.contentImage.image = uploadedImageBox.image
                self.image1squareForSend.backgroundImage.image = uploadedImageBox.image
                self.image1squareForSend.waveformImage.isHidden = true
            case 2:
                self.image2square.contentImage.image = uploadedImageBox.image
                self.image2square.backgroundImage.image = uploadedImageBox.image
                self.image2square.titleText.text = titleText
                self.image2square.waveformImage.setImageColor(color: colorPicked)
                
                self.image2squareForSend.contentImage.image = uploadedImageBox.image
                self.image2squareForSend.backgroundImage.image = uploadedImageBox.image
                self.image2squareForSend.titleText.text = titleText
                self.image2squareForSend.waveformImage.isHidden = true
            case 3:
                self.image3square.contentImage.image = uploadedImageBox.image
                self.image3square.backgroundImage.image = uploadedImageBox.image
                self.image3square.waveformImage.setImageColor(color: colorPicked)
            case 4:
                self.image4square.contentImage.image = uploadedImageBox.image
                self.image4square.backgroundImage.image = uploadedImageBox.image
                self.image4square.contentText.text = titleText
                self.image4square.waveformImage.setImageColor(color: colorPicked)
            case 5:
                self.image5square.backgroundImage.image = uploadedImageBox.image
                self.image5square.backgroundImage.image = uploadedImageBox.image
                self.image5square.contentText.text = titleText
                self.image5square.waveformImage.setImageColor(color: colorPicked)
            case 6:
                self.image6square.backgroundImage.image = uploadedImageBox.image
                self.image6square.backgroundImage.image = uploadedImageBox.image
                self.image6square.contentText.text = titleText
                self.image6square.waveformImage.setImageColor(color: colorPicked)
            case 7:
                self.image7square.contentImage.image = uploadedImageBox.image
                self.image7square.backgroundImage.image = uploadedImageBox.image
                self.image7square.contentText.text = titleText
                self.image7square.waveformImage.setImageColor(color: colorPicked)
                
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
        
        scrollView.addSubview(contentView)
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
        if isPotrait == true {
            contentView.heightAnchor.constraint(equalToConstant: 1300).isActive = true
        } else {
            contentView.heightAnchor.constraint(equalToConstant: 1300).isActive = false
            contentView.heightAnchor.constraint(equalToConstant: 1000).isActive = true
        }
    }
    

    
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

        if isPotrait == true {
            heightConstraintPotrait?.isActive = true
        } else {
            heightConstraintSquare?.isActive = true
        }

        
        canvasView.addSubview(templatePickedView)
        templatePickedView.anchor(top: canvasView.topAnchor, bottom: canvasView.bottomAnchor, leading: canvasView.leadingAnchor, trailing: canvasView.trailingAnchor, marginTop: 0, marginBottom: 0, marginLeading: 0, marginTrailing: 0, width: 0, height: 0, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        
        canvasView.addSubview(templatePickedViewForSend)
        templatePickedViewForSend.anchor(top: canvasView.topAnchor, bottom: canvasView.bottomAnchor, leading: canvasView.leadingAnchor, trailing: canvasView.trailingAnchor, marginTop: 0, marginBottom: 0, marginLeading: 0, marginTrailing: 0, width: 0, height: 0, centerX: nil, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
        
        
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
        if isPotrait == false {
            imagePicker.allowsEditing = true
        } else {
            imagePicker.allowsEditing = false
        }
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

