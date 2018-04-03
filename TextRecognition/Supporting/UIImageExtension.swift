//
//  UIImageExtension.swift
//  TextRecognition
//
//  Created by Темирлан Алпысбаев on 4/3/18.
//  Copyright © 2018 Alpysbayev. All rights reserved.
//

import UIKit

extension UIImage {
    
    func cropped() -> UIImage {
        guard let window = UIApplication.shared.keyWindow else {
            return self
        }
        
        let imageW = size.width
        let imageH = size.height
        
        let screenW = window.frame.size.width
        let screenH = window.frame.size.height
        
        let height: CGFloat = 280.0
        
        let rect = CGRect(x: imageH / 2.0 - (imageH * height / screenH) / 2.0,
                          y: imageW * 16.0 / screenW,
                          width: imageH * height / screenH,
                          height: imageW * (screenW - 32.0) / screenW)
        
        let imageRef = self.cgImage!.cropping(to: rect)
        let image = UIImage(cgImage: imageRef!, scale: UIScreen.main.scale, orientation: self.imageOrientation)
        return image
    }
    
    func cropp(title: Bool) -> UIImage {
        guard let window = UIApplication.shared.keyWindow else {
            return self
        }
        
        let imageW = size.width
        let imageH = size.height
        
        let screenW = window.frame.size.width
        let screenH = window.frame.size.height
        
        let height: CGFloat = title ? OpaqTitleView.instanceFromNib().size.height : OpaqValueView.instanceFromNib().size.height
        let width: CGFloat = title ? OpaqTitleView.instanceFromNib().size.width : OpaqValueView.instanceFromNib().size.width
        let opaqX = title ? OpaqTitleView.instanceFromNib().origin.x : OpaqValueView.instanceFromNib().origin.x
        let opaqY = title ? OpaqTitleView.instanceFromNib().origin.y : OpaqValueView.instanceFromNib().origin.y
        
        let rect = CGRect(x: imageW * opaqX / screenW,
                          y: imageH * opaqY / screenH,
                          width: imageW * width / screenW,
                          height: imageH * height / screenH)
        
        
        let imageRef = self.cgImage!.cropping(to: rect)
        let image = UIImage(cgImage: imageRef!, scale: UIScreen.main.scale, orientation: self.imageOrientation)
        return image
    }
    
    func correctlyOrientedImage() -> UIImage {
        if self.imageOrientation == UIImageOrientation.up {
            return self
        }
        
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        self.draw(in: CGRect(origin: .zero, size: CGSize(width: size.width, height: size.height)))
        
        guard let normalizedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext() else {
            return self
        }
        
        UIGraphicsEndImageContext()
        return normalizedImage;
    }
    
}
