//
//  LoginViewController.swift
//  TextRecognition
//
//  Created by Темирлан Алпысбаев on 4/16/18.
//  Copyright © 2018 Alpysbayev. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import GoogleSignIn

class LoginViewController: UIViewController, GIDSignInDelegate, GIDSignInUIDelegate {
    
    @IBAction func close(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func facebookLogin(_ sender: UIButton) {
        let fbManager = FBSDKLoginManager()
        
        fbManager.logIn(withReadPermissions: ["public_profile", "email"], from: self) { (result, error) in
            if let _ = result?.token {
                self.loadFBProfile()
            }
        }
    }
    
    func loadFBProfile() {
        FBSDKGraphRequest.init(graphPath: "me", parameters: ["fields" : "id, name, email"]).start { (connection, result, error) in
            if let map = result as? [String : Any] {
                Profile.current.isLoggedIn = true
                Profile.current.name = (map["name"] as! String)
                Profile.current.email = (map["email"] as! String)
            }
        }
    }
    
    @IBAction func googleLogin(_ sender: UIButton) {
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signIn()
    }
    
    //MARK:- Google Delegate
    
    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {  }
    
    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        present(viewController, animated: true, completion: nil)
    }
    
    public func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if (error == nil) {
            Profile.current.isLoggedIn = true
            Profile.current.name = user.profile.name
            Profile.current.email = user.profile.email
        }
    }
    
}
