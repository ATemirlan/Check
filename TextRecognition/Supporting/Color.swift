//
//  Color.swift
//  TextRecognition
//
//  Created by Темирлан Алпысбаев on 4/18/18.
//  Copyright © 2018 Alpysbayev. All rights reserved.
//

import UIKit
import Hue

protocol ColorProtocol {
    static var mainView: UIColor { get set }
    static var navigation: UIColor { get set }
    static var label: UIColor { get set }
    static var separator: UIColor { get set}
}

struct Color {
    
    struct Gryffindor: ColorProtocol {
        static var mainView: UIColor = UIColor(hex: "#e2f4c7")
        static var navigation: UIColor = UIColor(hex: "#ff4e50")
        static var label: UIColor = UIColor(hex: "#ff4e50")
        static var separator: UIColor = UIColor(hex: "#ffbdbd")
    }
    
}
