//
//  ChromaColor.swift
//  ProjectPodcastMC3
//
//  Created by Mohamad Naufal Nafian on 12/08/20.
//  Copyright © 2020 Reynaldi Wijaya. All rights reserved.
//



import UIKit
import ChromaColorPicker

protocol colorPickedChromaDelegate {
    func didColorChoices(color: UIColor)
}

class ChromaColor: UIViewController {
//    @IBOutlet weak var colorDisplayView: UIView!
    
    let colorDisplayView = UIView()
    let colorPicker = ChromaColorPicker()
    let brightnessSlider = ChromaBrightnessSlider()
    var red : CGFloat? = 0
    var green : CGFloat? = 0
    var blue : CGFloat? = 0
    var alpha : CGFloat? = 0
    var colorChoice = UIColor(displayP3Red: 0, green: 0, blue: 1, alpha: 1)
    private let defaultColorPickerSize = CGSize(width: 320, height: 320)
    private let brightnessSliderWidthHeightRatio: CGFloat = 0.1
    
    
    var selectedColorDelegate: colorPickedChromaDelegate!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Theme.current.backgroundColor
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Pick", style: .plain, target: self, action: #selector(pickColor))
        setupColorPicker()
        setupBrightnessSlider()
        setupColorPickerHandles()
        setupColorDisplay()
        
    }
    
    @objc func pickColor() {
        navigationController?.popViewController(animated: true)
        selectedColorDelegate.didColorChoices(color: colorChoice)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Private
    private var homeHandle: ChromaColorHandle! // reference to home handle
    
    private func setupColorPicker() {
        
        colorPicker.delegate = self
        colorPicker.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(colorPicker)
        
        let verticalOffset = -defaultColorPickerSize.height / 6
        
        NSLayoutConstraint.activate([
            colorPicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            colorPicker.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: verticalOffset),
            colorPicker.widthAnchor.constraint(equalToConstant: defaultColorPickerSize.width),
            colorPicker.heightAnchor.constraint(equalToConstant: defaultColorPickerSize.height)
        ])
    }
    
    private func setupBrightnessSlider() {
        brightnessSlider.connect(to: colorPicker)
        
        // Style
        brightnessSlider.trackColor = UIColor.blue
        brightnessSlider.handle.borderWidth = 3.0 // Example of customizing the handle's properties.
        
        // Layout
        brightnessSlider.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(brightnessSlider)
        
        NSLayoutConstraint.activate([
            brightnessSlider.centerXAnchor.constraint(equalTo: colorPicker.centerXAnchor),
            brightnessSlider.topAnchor.constraint(equalTo: colorPicker.bottomAnchor, constant: 28),
            brightnessSlider.widthAnchor.constraint(equalTo: colorPicker.widthAnchor, multiplier: 0.9),
            brightnessSlider.heightAnchor.constraint(equalTo: brightnessSlider.widthAnchor, multiplier: brightnessSliderWidthHeightRatio)
        ])
    }
    
    private func setupColorPickerHandles() {
        // (Optional) Assign a custom handle size - all handles appear as the same size
        // colorPicker.handleSize = CGSize(width: 48, height: 60)
        
        // 1. Add handle and then customize
        addHomeHandle()
        
        // 2. Add a handle via a color
        let peachColor = UIColor(red: 1, green: 203 / 255, blue: 164 / 255, alpha: 1)
        //colorPicker.addHandle(at: peachColor)
        
        // 3. Create a custom handle and add to picker
        let customHandle = ChromaColorHandle()
        customHandle.color = UIColor.purple
        //colorPicker.addHandle(customHandle)
    }
    
    private func addHomeHandle() {
        homeHandle = colorPicker.addHandle(at: .blue)
        
        // Setup custom handle view with insets
        let customImageView = UIImageView(image: UIImage(systemName: "house.fill")!.withRenderingMode(.alwaysTemplate))
        customImageView.contentMode = .scaleAspectFit
        customImageView.tintColor = .white
        homeHandle.accessoryView = customImageView
        homeHandle.accessoryViewEdgeInsets = UIEdgeInsets(top: 2, left: 4, bottom: 4, right: 4)
    }
    
    
    func setupColorDisplay() {
        view.addSubview(colorDisplayView)
        colorDisplayView.anchor(top: nil, bottom: view.bottomAnchor, leading: nil, trailing: nil, marginTop: 0, marginBottom: -60, marginLeading: 0, marginTrailing: 0, width: 40, height: 40, centerX: view.centerXAnchor, centerY: nil, marginFromCenterX: 0, marginFromCenterY: 0)
    }
    
    
}

extension ChromaColor: ChromaColorPickerDelegate {
    func colorPickerHandleDidChange(_ colorPicker: ChromaColorPicker, handle: ChromaColorHandle, to color: UIColor) {
        //print("color",color.cgColor.components)
        red = color.cgColor.components![0]
        green = color.cgColor.components![1]
        blue = color.cgColor.components![2]
        alpha = color.cgColor.components![3]
        
        self.colorChoice = UIColor.rgb(red: red!*255, green: green!*255, blue: blue!*255, alpha: alpha!*255)
        //print(colorChoice)
        
        //colorChoice = UIColor(displayP3Red: red ?? 1, green: green ?? 1, blue: blue ?? 1, alpha: alpha ?? 1)
        //print("red \(red!), green \(green!), blue \(blue!), alpha \(alpha!)")
        colorDisplayView.backgroundColor = color
        

        //print("background", vc.colorBox.backgroundColor?.cgColor)
        
        // Here I can detect when the color is too bright to show a white icon
        // on the handle and change its tintColor.
        if handle === homeHandle, let imageView = homeHandle.accessoryView as? UIImageView {
            let colorIsBright = color.isLight
            
            UIView.animate(withDuration: 0.2, animations: {
                imageView.tintColor = colorIsBright ? .black : .white
            }, completion: nil)
        }
    }
}


extension CALayer {

    func colorOfPoint(point:CGPoint)->CGColor
    {
        var pixel:[CUnsignedChar] = [0,0,0,0]

        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)

        let context = CGContext(data: &pixel, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)

        (context ?? "" as! CGContext).translateBy(x: -point.x, y: -point.y)

        self.render(in: context!)

        let red:CGFloat = CGFloat(pixel[0])/255.0
        let green:CGFloat = CGFloat(pixel[1])/255.0
        let blue:CGFloat = CGFloat(pixel[2])/255.0
        let alpha:CGFloat = CGFloat(pixel[3])/255.0

        let color = UIColor(red:red, green: green, blue:blue, alpha:alpha)

        return color.cgColor
    }

}


