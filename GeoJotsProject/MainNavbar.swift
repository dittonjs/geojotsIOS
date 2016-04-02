//
//  MainNavbar.swift
//  GeoJotsProject
//
//  Created by Joseph Ditton on 4/2/16.
//  Copyright © 2016 Joseph Ditton. All rights reserved.
//
import UIKit
import Material
import Font_Awesome_Swift

class MainNavbar{
    private var toolbar: Toolbar = Toolbar()
    private var backgroundColor = MaterialColor.teal.base
    func initialize(parentView: UIView) {
        // Title label.
        let titleLabel: UILabel = UILabel()
        titleLabel.text = "GeoJots"
        titleLabel.textAlignment = .Left
        titleLabel.textColor = MaterialColor.white
        titleLabel.font = RobotoFont.regular
        
        // image size
        var imageSize = CGSize()
        imageSize.width = 50
        imageSize.height = 50
        let image: UIImage? = UIImage(icon: FAType.FABars, size: imageSize, textColor: MaterialColor.white, backgroundColor: backgroundColor)
        // Menu button.
        
        let menuButton: FlatButton = FlatButton()
        menuButton.pulseScale = false
        menuButton.pulseColor = MaterialColor.white
        menuButton.tintColor = MaterialColor.white
        menuButton.setImage(image, forState: .Normal)
        menuButton.setImage(image, forState: .Highlighted)
        
        toolbar.statusBarStyle = .LightContent
        toolbar.backgroundColor = backgroundColor
        toolbar.titleLabel = titleLabel
        toolbar.leftControls = [menuButton]
        
        parentView.addSubview(toolbar)
    }
}