//
//  OpaqView.swift
//  TextRecognition
//
//  Created by Темирлан Алпысбаев on 4/2/18.
//  Copyright © 2018 Alpysbayev. All rights reserved.
//

import UIKit

protocol OpaqView {
    func update(origin: CGPoint)
    func update(size: CGSize)
}

class OpaqTitleView: UIView, OpaqView {
    
    private let opaqTitleX = "opaqTitleX"
    private let opaqTitleY = "opaqTitleY"
    private let opaqTitleW = "opaqTitleW"
    private let opaqTitleH = "opaqTitleH"
    
    var origin: CGPoint {
        set(newOrigin) {
            UserDefaults.standard.set(newOrigin.x, forKey: opaqTitleX)
            UserDefaults.standard.set(newOrigin.y, forKey: opaqTitleY)
        }
        get {
            let x = UserDefaults.standard.float(forKey: opaqTitleX)
            let y = UserDefaults.standard.float(forKey: opaqTitleY)
            
            guard x != 0, y != 0 else {
                return CGPoint(x: (Constants.CameraFrame.width - size.width) / 2.0,
                               y: Constants.CameraFrame.y + 8.0)
            }
            
            return CGPoint(x: CGFloat(x), y: CGFloat(y))
        }
    }
    
    var size: CGSize {
        set (newSize) {
            UserDefaults.standard.set(newSize.width, forKey: opaqTitleW)
            UserDefaults.standard.set(newSize.height, forKey: opaqTitleH)
        }
        get {
            let w = UserDefaults.standard.float(forKey: opaqTitleW)
            let h = UserDefaults.standard.float(forKey: opaqTitleH)
            
            guard w != 0, h != 0 else {
                return CGSize(width: Constants.CameraFrame.width * 0.8, height: 80.0)
            }
            
            return CGSize(width: CGFloat(w), height: CGFloat(h))
        }
    }
    
    class func instanceFromNib() -> OpaqTitleView {
        return UINib(nibName: OpaqTitleView.className, bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! OpaqTitleView
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
