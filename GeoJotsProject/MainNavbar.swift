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
    private var toolbar: MaterialView = MaterialView()
    private var backgroundColor = GeoJotsTheme.teal
    func initialize(parentView: UIView) {
    
        
        // Image size.
        var imageSize = CGSize()
        imageSize.width = 30
        imageSize.height = 30
        let image: UIImage? = UIImage(icon: FAType.FABars, size: imageSize, textColor: MaterialColor.white, backgroundColor: GeoJotsTheme.transparent)
        // Menu button.
        let menuButton: FabButton = FabButton()
        menuButton.pulseScale = false
        menuButton.pulseColor = MaterialColor.white
        menuButton.tintColor = MaterialColor.white
        menuButton.setImage(image, forState: .Normal)
        menuButton.setImage(image, forState: .Highlighted)
        menuButton.layer.zPosition = 11
        menuButton.backgroundColor = GeoJotsTheme.transparent
        menuButton.depth = .None
        menuButton.frame = CGRectMake(15, 20, 30, 30)
        
        let titleLabel = UILabel();
        titleLabel.text = "GeoJots"
        titleLabel.font = RobotoFont.boldWithSize(25)
        titleLabel.frame = CGRectMake(75, 20, 100, 30)
        titleLabel.textColor = MaterialColor.white
        // Finish Setup.

        toolbar.backgroundColor = GeoJotsTheme.transparentGrey
//        toolbar.depth = .Depth2
        toolbar.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, 70)
        toolbar.layer.zPosition = 10
        toolbar.addSubview(menuButton)
        toolbar.addSubview(titleLabel)
        parentView.addSubview(toolbar)
    }
}