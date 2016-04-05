//
//  CreateController.swift
//  GeoJotsProject
//
//  Created by Joseph Ditton on 4/4/16.
//  Copyright © 2016 Joseph Ditton. All rights reserved.
//

import Foundation
import UIKit
import Material
import Font_Awesome_Swift

class CreateController :UIViewController {
    
    private var mainNav = MainNavbar()
    private var leaveRoomButton = FabButton(frame: CGRectMake(350, 300, 75, 75))
    override func viewDidLoad() {
        super.viewDidLoad()
        mainNav.initialize(view)
        leaveRoomButton.layer.zPosition = 20
        view.addSubview(leaveRoomButton)
    }
    
}