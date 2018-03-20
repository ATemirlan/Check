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

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        setupGooglePlaces()
        setupKeyboard()
        setupCoreLocation()
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        updateLocation()
    }
    
    func setupGooglePlaces() {
        let key = "AIzaSyAGQTbXN3_WtiYu97KFBzPoNgbOiPkp4-k"
        GMSPlacesClient.provideAPIKey(key)
        GMSServices.provideAPIKey(key)
    }
    
    func setupKeyboard() {
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().shouldResignOnTouchOutside = true
        IQKeyboardManager.sharedManager().enableAutoToolbar = false
    }
    
    func updateLocation() {
        Utils.getCurrentPlace { (place) in
            Profile.current.location = place
        }
    }
    
    func setupCoreLocation() {
        if CLLocationManager.locationServicesEnabled() {
            let locationManager = CLLocationManager()
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
}

