//
//  TitleTextField.swift
//  GeoJotsProject
//
//  Created by Joseph Ditton on 4/4/16.
//  Copyright © 2016 Joseph Ditton. All rights reserved.
//

import Foundation
import Material
import Font_Awesome_Swift

class TitleTextField {
    private var textField = TextField()
    func initialize(parentView: UIView, startX: CGFloat, startY: CGFloat){
        textField.frame = CGRectMake(startX, startY, UIScreen.mainScreen().bounds.width - (2*startX), 50)
        textField.placeholder = "Room Name"
        textField.placeholderTextColor = MaterialColor.grey.base
        textField.font = RobotoFont.regularWithSize(20)
        textField.textColor = MaterialColor.black
        textField.bottomBorderColor = MaterialColor.grey.darken1
        textField.titleLabel = UILabel()
        textField.titleLabel!.font = RobotoFont.mediumWithSize(12)
        textField.titleLabelColor = MaterialColor.grey.base
        textField.titleLabelActiveColor = MaterialColor.blue.accent3
        parentView.addSubview(textField)
    }
    
    func getValue() -> String {
        return textField.text!
    }
}
