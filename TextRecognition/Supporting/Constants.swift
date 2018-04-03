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
    
}
