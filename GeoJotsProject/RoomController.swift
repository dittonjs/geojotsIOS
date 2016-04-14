//
//  RoomController.swift
//  GeoJotsProject
//
//  Created by Joseph Ditton on 4/3/16.
//  Copyright © 2016 Joseph Ditton. All rights reserved.
//

import Foundation
import UIKit
import Material
class RoomController :UIViewController {
    var userId = ""
    var roomId = ""
    override func viewDidLoad() {
        let myButton = UIButton()
        view.backgroundColor = MaterialColor.white
        myButton.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, 140)
        myButton.titleLabel!.text = "GO BACK"
        myButton.addTarget(self, action: #selector(self.goBack), forControlEvents: .TouchUpInside)
        myButton.backgroundColor = GeoJotsTheme.teal
        view.addSubview(myButton)
    }
    func goBack(){
        navigationController?.popViewControllerAnimated(true);
    }
}