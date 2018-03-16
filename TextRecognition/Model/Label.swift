//
//  Label.swift
//  TextRecognition
//
//  Created by Темирлан Алпысбаев on 3/16/18.
//  Copyright © 2018 Alpysbayev. All rights reserved.
//

import SwiftyJSON

struct Label {
    
    var description: String
    var score: Int
    
    init(_ description: String, _ score: Int) {
        self.description = description
        self.score = score
    }
    
    init(json: JSON) {
        self.init(json["description"].stringValue, json["score"].intValue)
    }
    
}
