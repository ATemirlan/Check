//
//  Page1ViewController.swift
//  TextRecognition
//
//  Created by Темирлан Алпысбаев on 4/12/18.
//  Copyright © 2018 Alpysbayev. All rights reserved.
//

import UIKit

class Page1ViewController: UIViewController, TutorialPageProtocol {

    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var valueView: UIView!
    
    var pageIndex: Int = 0
    
    var delegate: ViewControllerAppearance?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleView.backgroundColor = titleView.backgroundColor?.withAlphaComponent(0.3)
            valueView.backgroundColor = valueView.backgroundColor?.withAlphaComponent(0.3)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        delegate?.viewControllerAppeared(with: 0)
    }

}
