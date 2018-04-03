//
//  Extensions.swift
//  Kundelik
//
//  Created by Темирлан Алпысбаев on 1/23/18.
//  Copyright © 2018 Alpysbayev. All rights reserved.
//

import UIKit

extension UIViewController {
    
    static var segueID:String {
        return className
    }
    
    func setEmptyBackButton(){
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        tabBarController?.navigationItem.backBarButtonItem = backItem
        navigationController?.navigationBar.tintColor = .red
        navigationController?.navigationBar.isTranslucent = true
    }
    
    func showSpinner(deadline: Double, completion: @escaping () -> Void) {
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        
        let dimView = UIView(frame: window.frame)
        dimView.backgroundColor = UIColor.black.withAlphaComponent(0.25)
        
        let spinnerView = UIView(frame: CGRect(x: dimView.center.x - 16.0, y: dimView.center.y - 16.0, width: 64.0, height: 64.0))
        spinnerView.layer.cornerRadius = 8.0
        spinnerView.backgroundColor = .white
        
        let spinner = UIActivityIndicatorView(frame: CGRect(x: 0.0, y: 0.0, width: 64.0, height: 64.0))
        spinner.activityIndicatorViewStyle = .gray
        
        spinnerView.addSubview(spinner)
        dimView.addSubview(spinnerView)
        window.addSubview(dimView)
        spinner.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + deadline) {
            dimView.removeFromSuperview()
            completion()
        }
    }
    
    @objc func hideKeyBoard(){
        view.endEditing(true)
    }
    
    func backViewController() -> UIViewController? {
        if let stack = self.navigationController?.viewControllers {
            for i in (1..<stack.count).reversed() {
                if stack[i] == self {
                    return stack[i-1]
                }
            }
        }
        
        return nil
    }

}

extension UITableViewCell {
    
    static var cellID: String {
        return className
    }
    
    static var nibName: String {
        return className
    }
    
}

extension UICollectionViewCell {
    
    static var cellID: String {
        return className
    }
    
    static var nibName: String {
        return className
    }
    
}

extension NSObject {
    
    var className: String {
        return type(of: self).className
    }
    
    static var className: String {
        return String(describing: self)
    }
}

extension Notification.Name {
    
    static let checkVC = Notification.Name(rawValue: "checkvc")
    
}

extension UIPinchGestureRecognizer {
    
    func scale(view: UIView) -> (x: CGFloat, y: CGFloat)? {
        if numberOfTouches > 1 {
            let touch1 = self.location(ofTouch: 0, in: view)
            let touch2 = self.location(ofTouch: 1, in: view)
            let deltaX = abs(touch1.x - touch2.x)
            let deltaY = abs(touch1.y - touch2.y)
            let sum = deltaX + deltaY
            if sum > 0 {
                let scale = self.scale
                return (1.0 + (scale - 1.0) * (deltaX / sum), 1.0 + (scale - 1.0) * (deltaY / sum))
            }
        }
        return nil
    }
    
}

extension String {

    func condensingWhitespace() -> String {
        return self.components(separatedBy: .whitespacesAndNewlines)
            .filter { !$0.isEmpty }
            .joined(separator: " ")
    }

}
