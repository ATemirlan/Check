//
//  Alert.swift
//  Kundelik
//
//  Created by Темирлан Алпысбаев on 2/27/18.
//  Copyright © 2018 Alpysbayev. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class Alert {
    
    static func spinner(show: Bool) {
        guard let view = UIApplication.shared.keyWindow else {
            return
        }
        
        guard show else {
            for v in view.subviews {
                if v.tag == 732 {
                    v.removeFromSuperview()
                }
            }
            return
        }
        
        let dim = UIView(frame: view.frame)
        dim.backgroundColor = UIColor.orange.withAlphaComponent(0.0)
        dim.tag = 732
        
        let dimView = UIView(frame: CGRect(origin: CGPoint(x: view.frame.width / 2.0 - 32.0, y: view.frame.height / 2.0 - 32.0), size: CGSize(width: 64.0, height: 64.0)))
        dimView.layer.cornerRadius = 8.0
        dimView.backgroundColor = .black
        
        let indicator = NVActivityIndicatorView(frame: CGRect(origin: CGPoint(x: dimView.frame.width / 2.0 - 22.0, y: dimView.frame.height / 2.0 - 22.0), size: CGSize(width: 44.0, height: 44.0)),
                                                type: .ballScale,
                                                color: .white,
                                                padding: nil)
        dimView.addSubview(indicator)
        indicator.startAnimating()
        
        dim.addSubview(dimView)
        view.addSubview(dim)
    }
    
    static func showError(textError: String, above vc: UIViewController) {
        let alert = UIAlertController(title: "Ошибка", message: textError, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .cancel, handler: { (action) in}))
        vc.present(alert, animated: true, completion: nil)
    }
    
    static func showAlert(vc: UIViewController, title: String, message: String, actions: [UIAlertAction]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        for alertAction in actions {
            alert.addAction(alertAction)
        }
        
        vc.present(alert, animated: true, completion: nil)
    }
    
    static func showActionSheet(vc: UIViewController, title: String?, message: String?, actions: [UIAlertAction]) {
        let actionSheet = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        for action in actions {
            actionSheet.addAction(action)
        }
        
        vc.present(actionSheet, animated: true, completion: nil)
    }
    
}
