//
//  SaveButton.swift
//  TextRecognition
//
//  Created by Темирлан Алпысбаев on 4/6/18.
//  Copyright © 2018 Alpysbayev. All rights reserved.
//

import UIKit

class SaveButton: UIButton {

    override var isEnabled: Bool {
        didSet {
            backgroundColor = !isEnabled ? .gray : .black
        }
    }

}
