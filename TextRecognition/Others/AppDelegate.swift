//
//  AppDelegate.swift
//  TextRecognition
//
//  Created by Темирлан Алпысбаев on 3/7/18.
//  Copyright © 2018 Alpysbayev. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import IQKeyboardManagerSwift
import FBSDKCoreKit
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let key = "AIzaSyAGQTbXN3_WtiYu97KFBzPoNgbOiPkp4-k"
    let id = "290576521356-ri164ufk67okb0d2aib7a05a0pkjrecl.apps.googleusercontent.com"
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        setupGoogle()
        setupKeyboard()
        
        return true
    }
    
    func setupGoogle() {
        GMSPlacesClient.provideAPIKey(key)
        GMSServices.provideAPIKey(key)
        GIDSignIn.sharedInstance().clientID = id
    }
    
    func setupKeyboard() {
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().shouldResignOnTouchOutside = true
        IQKeyboardManager.sharedManager().previousNextDisplayMode = .alwaysHide
        
        IQKeyboardManager.sharedManager().toolbarTintColor = .black
        IQKeyboardManager.sharedManager().toolbarBarTintColor = .white
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        tryShowCameraBlur(hide: true)
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        tryShowCameraBlur(hide: false)
    }
    
    @objc func tryShowCameraBlur(hide: Bool) {
        guard let pageVC = window?.rootViewController as? PageViewController else {
            return
        }
        
        guard let cameraVC = pageVC.viewControllers?[0] as? CameraViewController else {
            return
        }
        
        cameraVC.blurView.isHidden = !hide
    }
    
}

