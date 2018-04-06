//
//  Record.swift
//  TextRecognition
//
//  Created by Темирлан Алпысбаев on 3/20/18.
//  Copyright © 2018 Alpysbayev. All rights reserved.
//

import RealmSwift

class Record: Object {
    
    @objc dynamic var value: Float = 0.0
    @objc dynamic var title = ""
    @objc dynamic var location = ""
    @objc dynamic var date = Date()
    @objc dynamic var imgData = Data()
    
    func canbeSaved() -> Bool {
        return value > 0.0 && title.count > 0 && title != "Название продукта"
    }
    
}
