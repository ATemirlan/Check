//
//  DetailViewController.swift
//  TextRecognition
//
//  Created by Темирлан Алпысбаев on 3/20/18.
//  Copyright © 2018 Alpysbayev. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    
    var record: Record?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let record = record {
            imgView.image = UIImage(data: record.imgData)
        }
    }
    
}
