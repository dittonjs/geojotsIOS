//
//  ViewController.swift
//  GeoJotsProject
//
//  Created by Joseph Ditton on 4/2/16.
//  Copyright © 2016 Joseph Ditton. All rights reserved.
//

import UIKit
import Material
class ViewController: UIViewController {
    private var mainNav: MainNavbar = MainNavbar()
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        mainNav.initialize(view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func prepareView() {
        view.backgroundColor = MaterialColor.white
    }
}

