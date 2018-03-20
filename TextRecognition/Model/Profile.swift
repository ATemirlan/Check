//
//  Profile.swift
//  TextRecognition
//
//  Created by Темирлан Алпысбаев on 3/20/18.
//  Copyright © 2018 Alpysbayev. All rights reserved.
//

import Foundation

class Profile {
    
    static let current = Profile()
    private init() {}
    private let standard = UserDefaults.standard
    
    func deleteUser() {
        location = nil
    }
    
    var location: String? {
        set(newLocation) {
            setStandard(string: newLocation, at: "location")
        }
        get {
            return getStandardString(from: "location")
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
