//
//  ViewController.swift
//  TextRecognition
//
//  Created by Темирлан Алпысбаев on 3/15/18.
//  Copyright © 2018 Alpysbayev. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var imgView: UIImageView!
    var img: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgView.image = img
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        imgView.image = UIImage(named: "img")!.titleCropped()
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
