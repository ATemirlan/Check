//
//  cameraSwitch.swift
//  TextRecognition
//
//  Created by Темирлан Алпысбаев on 3/15/18.
//  Copyright © 2018 Alpysbayev. All rights reserved.
//

import UIKit

class CameraSwitch: UIButton {

    override func draw(_ rect: CGRect) {
        layer.cornerRadius = 22.0
        layer.masksToBounds = true
    }
 
    func set(selected: Bool) {
        backgroundColor = selected ? .white : .black
        setTitleColor(selected ? .black : .white, for: .normal)
        tintColor = selected ? .black : .white
        
        if tag == 0 {
            setImage(!selected ? UIImage(named: "text")! : UIImage(named: "text_selected")!, for: .normal)
        } else {
            setImage(!selected ? UIImage(named: "product")! : UIImage(named: "product_selected")!, for: .normal)
        }
    }

}
