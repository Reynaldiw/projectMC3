//
//  Extensions.swift
//  ProjectPodcastMC3
//
//  Created by Reynaldi Wijaya on 04/08/20.
//  Copyright © 2020 Reynaldi Wijaya. All rights reserved.
//

import UIKit

extension UIView {
    
    
    func isPasswordValid(_ password : String) -> Bool {
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    
    func anchor (
        top : NSLayoutYAxisAnchor?,
        bottom : NSLayoutYAxisAnchor?,
        leading : NSLayoutXAxisAnchor?,
        trailing : NSLayoutXAxisAnchor?,
        marginTop : CGFloat,
        marginBottom : CGFloat,
        marginLeading : CGFloat,
        marginTrailing : CGFloat,
        width : CGFloat,
        height : CGFloat,
        centerX : NSLayoutXAxisAnchor?,
        centerY : NSLayoutYAxisAnchor?,
        marginFromCenterX : CGFloat,
        marginFromCenterY : CGFloat
    ) {
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top { self.topAnchor.constraint(equalTo: top, constant: marginTop).isActive = true }
        if let bottom = bottom { self.bottomAnchor.constraint(equalTo: bottom, constant: marginBottom).isActive = true }
        if let leading = leading { self.leadingAnchor.constraint(equalTo: leading, constant: marginLeading).isActive = true }
        if let trailing = trailing { self.trailingAnchor.constraint(equalTo: trailing, constant: marginTrailing).isActive = true }

        if width != 0 { widthAnchor.constraint(equalToConstant: width).isActive = true}
        if height != 0 { heightAnchor.constraint(equalToConstant: height).isActive = true}

        if let centerX = centerX { self.centerXAnchor.constraint(equalTo: centerX, constant: marginFromCenterX).isActive = true }
        if let centerY = centerY { self.centerYAnchor.constraint(equalTo: centerY, constant: marginFromCenterY).isActive = true }


    }
    
    func setCellShadow() {
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 2
        self.layer.masksToBounds = false
        self.clipsToBounds = false
        //self.layer.cornerRadius = 15
    }
    
}

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
         return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
}

extension CGColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> CGColor {
         return CGColor(srgbRed: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}

extension UIStackView {
    func changeBackgroundColor(color: UIColor) {
        let backgroundLayer = CAShapeLayer()
        layer.insertSublayer(backgroundLayer, at: 0)
        backgroundLayer.path = UIBezierPath(rect: self.bounds).cgPath
        backgroundLayer.fillColor = color.cgColor
    }
}
