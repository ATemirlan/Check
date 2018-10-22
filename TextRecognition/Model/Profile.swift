//
//  Profile.swift
//  TextRecognition
//
//  Created by Темирлан Алпысбаев on 3/20/18.
//  Copyright © 2018 Alpysbayev. All rights reserved.
//

import UIKit
import GoogleSignIn

class Profile {
    
    static let current = Profile()
    private init() {}
    private let standard = UserDefaults.standard
    
    func deleteUser() {
        location = nil
        name = nil
        isLoggedIn = false
    }
    
    func logout() {
        GIDSignIn.sharedInstance().signOut()
        name = nil
        email = nil
        isLoggedIn = false
    }
    
    var location: String? {
        set(newLocation) {
            setStandard(string: newLocation, at: Constants.StandardDefaults.location)
        }
        get {
            return getStandardString(from: Constants.StandardDefaults.location)
        }
    }
    
    var name: String? {
        set(newName) {
            setStandard(string: newName, at: Constants.StandardDefaults.name)
        }
        get {
            return getStandardString(from: Constants.StandardDefaults.name)
        }
    }
    
    var email: String? {
        set(newEmail) {
            setStandard(string: newEmail, at: Constants.StandardDefaults.email)
        }
        get {
            return getStandardString(from: Constants.StandardDefaults.email)
        }
    }
    
    var filter: Int {
        set(newFilter) {
            UserDefaults.standard.set(newFilter, forKey: Constants.StandardDefaults.filter)
        }
        get {
            guard let filter = UserDefaults.standard.object(forKey: Constants.StandardDefaults.filter) as? Int else {
                return 0
            }
            
            return filter
        }
    }
    
    var isLoggedIn: Bool {
        set(isLogged) {
            UserDefaults.standard.set(isLogged, forKey: Constants.StandardDefaults.isLoggedIn)
        }
        get {
            guard let isLogged = UserDefaults.standard.object(forKey: Constants.StandardDefaults.isLoggedIn) as? Bool else {
                return false
            }
            
            return isLogged
        }
    }
    
    private func setStandard(string: String?, at key: String) {
        if let _ = string {
            UserDefaults.standard.set(string, forKey: key)
        } else {
            UserDefaults.standard.removeObject(forKey: key)
        }
    }
    
    private func getStandardString(from key: String) -> String? {
        if let string = UserDefaults.standard.object(forKey: key) as? String {
            return string
        }
        
        return nil
    }
    
}
