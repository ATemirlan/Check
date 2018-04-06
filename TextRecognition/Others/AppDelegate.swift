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

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let key = "AIzaSyAGQTbXN3_WtiYu97KFBzPoNgbOiPkp4-k"
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        setupGooglePlaces()
        setupKeyboard()
        
        return true
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }
    
    func setupGooglePlaces() {
        GMSPlacesClient.provideAPIKey(key)
        GMSServices.provideAPIKey(key)
    }
    
    func setupKeyboard() {
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().shouldResignOnTouchOutside = true
//        IQKeyboardManager.sharedManager().enableAutoToolbar = false
        
        IQKeyboardManager.sharedManager().toolbarTintColor = .black
        IQKeyboardManager.sharedManager().toolbarBarTintColor = .white
    }
    
}

