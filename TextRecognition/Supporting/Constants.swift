//
//  Constants.swift
//  Kundelik
//
//  Created by Темирлан Алпысбаев on 2/19/18.
//  Copyright © 2018 Alpysbayev. All rights reserved.
//

import UIKit

struct Constants {
    
    struct Errors {
        static let unknownError = "Что-то пошло не так"
    }
    
    struct Color {
        static let redColor = UIColor(red: 1.0, green: 8.0/255.0, blue: 0.0, alpha: 1.0)
    }
    
    struct Palette {
        static let c1 = UIColor(red: 67.0/255.0, green: 196.0/255.0, blue: 184.0/255.0, alpha: 1.0)
        static let c2 = UIColor(red: 119.0/255.0, green: 205.0/255.0, blue: 105.0/255.0, alpha: 1.0)
        static let c3 = UIColor(red: 175.0/255.0, green: 121.0/255.0, blue: 202.0/255.0, alpha: 1.0)
        static let c4 = UIColor(red: 85.0/255.0, green: 107.0/255.0, blue: 141.0/255.0, alpha: 1.0)
        static let c5 = UIColor(red: 236.0/255.0, green: 185.0/255.0, blue: 14.0/255.0, alpha: 1.0)
        static let c6 = UIColor(red: 222.0/255.0, green: 53.0/255.0, blue: 46.0/255.0, alpha: 1.0)
        static let c7 = UIColor(red: 244.0/255.0, green: 82.0/255.0, blue: 15.0/255.0, alpha: 1.0)
        static let c8 = UIColor(red: 194.0/255.0, green: 0.0/255.0, blue: 14.0/255.0, alpha: 1.0)
        static let c9 = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    }
    
    struct CameraFrame {
        static let width: CGFloat = UIScreen.main.bounds.width - 34.0
        static let height: CGFloat = 280.0
        
        static let x: CGFloat = 17.0
        static let y: CGFloat = UIScreen.main.bounds.height / 2.0 - 155.0
        
        static let left = x
        static let top = y
        static let right = width + x
        static let bottom = y + height
    }
    
    struct StandardDefaults {
        static let location = "location"
        
        static let isLoggedIn = "isLoggedIn"
        static let name = "name"
        static let login = "login"
        static let email = "email"
        
        static let filter = "filter"
    }
    
}
