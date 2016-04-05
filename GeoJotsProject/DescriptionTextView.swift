//
//  DescriptionTextView.swift
//  GeoJotsProject
//
//  Created by Joseph Ditton on 4/4/16.
//  Copyright © 2016 Joseph Ditton. All rights reserved.
//

import Foundation
import Material
import Font_Awesome_Swift

class DescriptionTextView :TextDelegate {
    /// A Text storage object that monitors the changes within the textView.
    lazy var text: Text = Text()
    
    /// A TextView UI Component.
    var textView: TextView!
    func initialize(parentView: UIView, top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat){
        let layoutManager: NSLayoutManager = NSLayoutManager()
        let textContainer: NSTextContainer = NSTextContainer(size: parentView.bounds.size)
        layoutManager.addTextContainer(textContainer)
    
        text.delegate = self
        text.textStorage.addLayoutManager(layoutManager)
    
        textView = TextView(textContainer: textContainer)
        textView.font = RobotoFont.regular
        
        textView.
    
        textView.placeholderLabel = UILabel()
        textView.placeholderLabel!.textColor = MaterialColor.grey.base
        textView.placeholderLabel!.text = "Description"
    
        textView.titleLabel = UILabel()
        textView.titleLabel!.font = RobotoFont.mediumWithSize(12)
        textView.titleLabelColor = MaterialColor.grey.base
        textView.titleLabelActiveColor = MaterialColor.blue.accent3
    
        parentView.addSubview(textView)
        textView!.translatesAutoresizingMaskIntoConstraints = false
        MaterialLayout.alignToParent(parentView, child: textView!, top: top, left: left, bottom: bottom, right: right)
    }
    
    @objc func textWillProcessEdit(text: Text, textStorage: TextStorage, string: String, range: NSRange) {
        print("did i get called?")
        textStorage.removeAttribute(NSFontAttributeName, range: range)
        textStorage.addAttribute(NSFontAttributeName, value: RobotoFont.regular, range: range)
    }
    
    @objc func textDidProcessEdit(text: Text, textStorage: TextStorage, string: String, result: NSTextCheckingResult?, flags: NSMatchingFlags, stop: UnsafeMutablePointer<ObjCBool>) {
        print("did i get called?")
        textStorage.addAttribute(NSFontAttributeName, value: UIFont.boldSystemFontOfSize(16), range: result!.range)
    }
}
