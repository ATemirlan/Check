//
//  ViewController.swift
//  TextRecognition
//
//  Created by Темирлан Алпысбаев on 3/15/18.
//  Copyright © 2018 Alpysbayev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    
    var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgView.image = image
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
