//
//  Page3ViewController.swift
//  TextRecognition
//
//  Created by Темирлан Алпысбаев on 4/12/18.
//  Copyright © 2018 Alpysbayev. All rights reserved.
//

import UIKit

class Page3ViewController: UIViewController, TutorialPageProtocol {

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var content: UIView!
    
    @IBOutlet weak var centerY: NSLayoutConstraint!
    @IBOutlet weak var centerX: NSLayoutConstraint!
    
    var pageIndex: Int = 2
    var delegate: ViewControllerAppearance?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        delegate?.viewControllerAppeared(with: 2)
        setAnimation()
    }
    
    func setAnimation() {
        move(toRight: true) {
            self.move(toRight: false, completion: {
                self.centerX.constant = 0
                self.centerY.constant = 0
                UIView.animate(withDuration: 1.0, animations: {
                    self.view.layoutIfNeeded()
                })
            })
        }
    }
    
    func move(toRight: Bool, completion: @escaping() -> Void) {
        let xDistance = (container.frame.size.width - content.frame.size.width) / 2.0 - 4.0
        let yDistance = (container.frame.size.height - content.frame.size.height) / 2.0 - 4.0
        centerX.constant = toRight ? xDistance : -xDistance
        centerY.constant = toRight ? -yDistance : yDistance
        
        UIView.animate(withDuration: toRight ? 1.0 : 2.0, animations: {
            self.view.layoutIfNeeded()
        }) { (completed) in
            if completed {
                completion()
            }
        }
    }
    
}
