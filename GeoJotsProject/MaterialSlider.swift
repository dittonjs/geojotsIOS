//
//  MaterialSlider.swift
//  GeoJotsProject
//
//  Created by Joseph Ditton on 4/7/16.
//  Copyright © 2016 Joseph Ditton. All rights reserved.
//

import Foundation
import UIKit

class MaterialSlider {
    var slider = UISlider()
    func initialize(parentView: UIView, startX: CGFloat, startY: CGFloat, width: CGFloat, height: CGFloat, parent: UIViewController, action: Selector){
        slider.frame = CGRectMake(startX, startY, width, height)
        slider.tintColor = GeoJotsTheme.darkTeal
        slider.addTarget(parent, action: action, forControlEvents: .ValueChanged)
        parentView.addSubview(slider)
    }
}