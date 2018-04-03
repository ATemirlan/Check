//
//  OpaqValueView.swift
//  TextRecognition
//
//  Created by Темирлан Алпысбаев on 4/2/18.
//  Copyright © 2018 Alpysbayev. All rights reserved.
//

import UIKit

class OpaqValueView: UIView, OpaqView {

    private let opaqValueX = "opaqValueX"
    private let opaqValueY = "opaqValueY"
    private let opaqValueW = "opaqValueW"
    private let opaqValueH = "opaqValueH"
    
    var origin: CGPoint {
        set(newOrigin) {
            UserDefaults.standard.set(newOrigin.x, forKey: opaqValueX)
            UserDefaults.standard.set(newOrigin.y, forKey: opaqValueY)
        }
        get {
            let x = UserDefaults.standard.float(forKey: opaqValueX)
            let y = UserDefaults.standard.float(forKey: opaqValueY)
            
            guard x != 0, y != 0 else {
                return CGPoint(x: Constants.CameraFrame.right - 8.0 - size.width,
                               y: Constants.CameraFrame.bottom - 8.0 - size.height)
            }
            
            return CGPoint(x: CGFloat(x), y: CGFloat(y))
        }
    }
    
    var size: CGSize {
        set (newSize) {
            UserDefaults.standard.set(newSize.width, forKey: opaqValueW)
            UserDefaults.standard.set(newSize.height, forKey: opaqValueH)
        }
        get {
            let w = UserDefaults.standard.float(forKey: opaqValueW)
            let h = UserDefaults.standard.float(forKey: opaqValueH)
            
            guard w != 0, h != 0 else {
                return CGSize(width: 160.0, height: 80.0)
            }
            
            return CGSize(width: CGFloat(w), height: CGFloat(h))
        }
    }
    
    class func instanceFromNib() -> OpaqValueView {
        return UINib(nibName: OpaqValueView.className, bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! OpaqValueView
    }
    
    override func draw(_ rect: CGRect) {
        self.frame = CGRect(origin: origin, size: size)
    }
    
    func update(origin: CGPoint) {
        self.origin = origin
    }
    
    func update(size: CGSize) {
        self.size = size
    }

}
