//
//  CheckViewController.swift
//  TextRecognition
//
//  Created by Темирлан Алпысбаев on 3/12/18.
//  Copyright © 2018 Alpysbayev. All rights reserved.
//

import UIKit

protocol CheckDelegate {
    func changePage(to index: Int)
}

class CheckViewController: UIViewController {

    var delegate: CheckDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func goToCamera(_ sender: Any) {
        delegate?.changePage(to: 0)
    }
}
