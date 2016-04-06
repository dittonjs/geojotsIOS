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
    private var cancelButton = CancelButton()
    private var titleTextField = TitleTextField()
    private var descriptionTextView = DescriptionTextView()
    private var createMessageBoardButton = CreateMessageBoardButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        mainNav.initialize(view)
        
        let startX: CGFloat = UIScreen.mainScreen().bounds.size.width - 15
        let startY: CGFloat = 107
        cancelButton.initialize(view, action: #selector(self.cancelCreation), startX: startX, startY: startY, parentRef: self)
        let top: CGFloat = 217
        let left: CGFloat = 30
        let bottom: CGFloat = UIScreen.mainScreen().bounds.size.height / 2
        let right: CGFloat = 30
        descriptionTextView.initialize(view, top: top, left: left, bottom: bottom, right: right)
        titleTextField.initialize(view, startX: 30, startY: 120)
        createMessageBoardButton.initialize(view, startX: 0, startY: UIScreen.mainScreen().bounds.size.height - 80)
    }
    
    func cancelCreation(){
        print("return to root")
        navigationController?.popToRootViewControllerAnimated(true)
    }
    
}