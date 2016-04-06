//
//  CreateMessageBoardButton.swift
//  GeoJotsProject
//
//  Created by Joseph Ditton on 4/5/16.
//  Copyright © 2016 Joseph Ditton. All rights reserved.
//

import Foundation
import Material
import UIKit
import Font_Awesome_Swift
import Firebase

class CreateMessageBoardButton {
    var button = RaisedButton()
    func initialize(parentView: UIView, startX: CGFloat, startY: CGFloat){
        button.frame = CGRectMake(startX, startY, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height - startY) // always at the bottom
        button.setTitle("Create Message Board", forState: .Normal)
        button.layer.cornerRadius = 0
        button.backgroundColor = GeoJotsTheme.salmon
        button.depth = .Depth3
        parentView.addSubview(button)
    }
}