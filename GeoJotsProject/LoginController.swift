//
//  LoginController.swift
//  GeoJotsProject
//
//  Created by Joseph Ditton on 4/13/16.
//  Copyright © 2016 Joseph Ditton. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit
import RealmSwift
class LoginController: UIViewController {
    override func viewDidLoad() {
//        FBSDKLoginManager().logOut() // dont actually do this for real
        if FBSDKAccessToken.currentAccessToken() != nil{
            // we are logged in
            let authToken = FBSDKAccessToken.currentAccessToken().tokenString
            let ref = Firebase(url: "https://geojots.firebaseio.com")
            ref.authWithOAuthProvider("facebook", token: authToken!, withCompletionBlock: {
                (error: NSError!, faceBookAuthData: FAuthData!) in
                
                if error != nil {
                    print("LOGIN FAILED \(error)")
                } else {
                    let userRef = Firebase(url: "https://geojots.firebaseio.com/users/\(faceBookAuthData.uid)")
                    userRef.observeEventType(.Value, withBlock: {
                        (snapshot: FDataSnapshot!) in
                        print(snapshot.value)
                    })
                    let mainViewController = ViewController()
                    mainViewController.userId = faceBookAuthData.uid
                    self.navigationController?.pushViewController(mainViewController, animated: true)
                }
            })
        } else {
            let loginButton = FBSDKLoginButton()
            loginButton.center = self.view.center
            loginButton.readPermissions = ["email"]
            loginButton.delegate = self
            view.addSubview(loginButton)
        }
    }
}

extension LoginController: FBSDKLoginButtonDelegate {
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        print("User Logged In")
        
        if ((error) != nil) {
            // Process error
            print("ERROR LOGIN IN \(error)")
        } else if result.isCancelled {
            // Handle cancellations
            
        } else {
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            if result.grantedPermissions.contains("email") {
                let authToken = FBSDKAccessToken.currentAccessToken().tokenString
                let ref = Firebase(url: "https://geojots.firebaseio.com")
                ref.authWithOAuthProvider("facebook", token: authToken!, withCompletionBlock: {
                    (error: NSError!, faceBookAuthData: FAuthData!) in
                    
                    if error != nil {
                        print("LOGIN FAILED \(error)")
                    } else {
                        let usersRef = Firebase(url: "https://geojots.firebaseio.com/users")
                        let data: [String:String] = [
                            "full_name":faceBookAuthData.providerData["displayName"] as! String,
                            "facebook_id":faceBookAuthData.providerData["id"] as! String,
                            "email":faceBookAuthData.providerData["email"] as! String,
                            "profile_image_url":faceBookAuthData.providerData["profileImageURL"] as! String,
                            "auth_token":faceBookAuthData.providerData["accessToken"] as! String
                        ]
                        usersRef.childByAppendingPath(faceBookAuthData.uid!).setValue(data)
                        let mainViewController = ViewController()
                        mainViewController.userId = faceBookAuthData.uid
                        self.navigationController?.pushViewController(mainViewController, animated: true)
                    }
                })
            }
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
    }
}