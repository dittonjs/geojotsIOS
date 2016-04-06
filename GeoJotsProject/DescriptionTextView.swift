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
import UIKit

class DescriptionTextView: NSObject, TextDelegate, TextViewDelegate {
    /// A Text storage object that monitors the changes within the textView.
    
    lazy var text: Text = Text()
    
    /// A TextView UI Component.
    var textView: TextView!
    var progressBar = UIProgressView()
    var progressLabel = UILabel()
    func initialize(parentView: UIView, top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat){
        let layoutManager: NSLayoutManager = NSLayoutManager()
        let textContainer: NSTextContainer = NSTextContainer(size: parentView.bounds.size)
        layoutManager.addTextContainer(textContainer)
    
        text.delegate = self
        text.textStorage.addLayoutManager(layoutManager)
    
        textView = TextView(textContainer: textContainer)
        textView.font = RobotoFont.regular
        textView.delegate = self
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
        
        progressBar.frame = CGRectMake(30, UIScreen.mainScreen().bounds.size.height - bottom + 10, UIScreen.mainScreen().bounds.size.width - 60, 10)
        progressBar.progressTintColor = GeoJotsTheme.darkTeal
        progressBar.progress = 0
        progressBar.trackTintColor = GeoJotsTheme.teal
        progressBar.transform  = CGAffineTransformMakeScale(1, 2)
        parentView.addSubview(progressBar)
        
        progressLabel.frame = CGRectMake(UIScreen.mainScreen().bounds.size.width - right - 60, UIScreen.mainScreen().bounds.size.height - bottom + 20, 60, 20)
        progressLabel.text = "0 / 120"
        progressLabel.font = RobotoFont.regularWithSize(12)
        progressLabel.textColor = MaterialColor.grey.base
        progressLabel.textAlignment = .Right
        parentView.addSubview(progressLabel)
    }
    
    @objc func textWillProcessEdit(text: Text, textStorage: TextStorage, string: String, range: NSRange) {
        print("did i get called?")
        progressBar.progress = Float(text.string.characters.count) / 120
        progressLabel.text = "\(text.string.characters.count) / 120"
        textStorage.removeAttribute(NSFontAttributeName, range: range)
        textStorage.addAttribute(NSFontAttributeName, value: RobotoFont.regular, range: range)
    }
    
    @objc func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).stringByReplacingCharactersInRange(range, withString: text)
        let numberOfChars = newText.characters.count
        return numberOfChars < 121;
    }
    
    @objc func textDidProcessEdit(text: Text, textStorage: TextStorage, string: String, result: NSTextCheckingResult?, flags: NSMatchingFlags, stop: UnsafeMutablePointer<ObjCBool>) {
        textStorage.addAttribute(NSFontAttributeName, value: UIFont.boldSystemFontOfSize(16), range: result!.range)
    }
}
