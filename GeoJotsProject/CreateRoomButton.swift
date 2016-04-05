//
//  CreateRoomButton.swift
//  GeoJotsProject
//
//  Created by Joseph Ditton on 4/4/16.
//  Copyright © 2016 Joseph Ditton. All rights reserved.
//

import Foundation
import Material
import Font_Awesome_Swift
class CreateRoomButton {
    var button = FabButton()
    
    func initialize(parentView: UIView, action: Selector, startX: CGFloat, startY: CGFloat, parentRef: UIViewController){
        button.frame = CGRectMake(startX - 75, startY - 75, 75, 75)
        var imageSize = CGSize()
        imageSize.width = 30
        imageSize.height = 30
        let image: UIImage? = UIImage(icon: FAType.FAPlus, size: imageSize, textColor: MaterialColor.white, backgroundColor: GeoJotsTheme.salmon)
        button.setImage(image, forState: .Normal)
        button.setImage(image, forState: .Highlighted)
        button.grid.rows = 2
        button.grid.columns = 1
        button.grid.offset.rows = 13
        button.grid.offset.columns = 3
        button.layer.zPosition = 10
        button.backgroundColor = GeoJotsTheme.salmon
        button.addTarget(parentRef, action: action, forControlEvents: .TouchUpInside)
        parentView.addSubview(button)
    }
    
    func updateRect(startX: CGFloat, startY: CGFloat){
        button.frame = CGRectMake(startX - 75, startY - 75, 75, 75)
    }
    
    
}
