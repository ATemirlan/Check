//
//  Page2ViewController.swift
//  TextRecognition
//
//  Created by Темирлан Алпысбаев on 4/12/18.
//  Copyright © 2018 Alpysbayev. All rights reserved.
//

import UIKit

class Page2ViewController: UIViewController, TutorialPageProtocol {

    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    
    var pageIndex: Int = 1
    var delegate: ViewControllerAppearance?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        delegate?.viewControllerAppeared(with: 1)
        setAnimation()
    }
    
    func setAnimation() {
        widthConstraint.constant = -8.0
        
        UIView.animate(withDuration: 1.0, animations: {
            self.view.layoutIfNeeded()
        }) { (completed) in
            if completed {
                self.widthConstraint.constant = -140.0
                
                UIView.animate(withDuration: 1.8, animations: {
                    self.view.layoutIfNeeded()
                }) { (completed) in
                    if completed {
                        self.widthConstraint.constant = -80.0
                        UIView.animate(withDuration: 0.8, animations: {
                            self.view.layoutIfNeeded()
                        })
                    }
                }
            }
        }
    }
    
}
