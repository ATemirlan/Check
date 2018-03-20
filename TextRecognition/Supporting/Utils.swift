//
//  Utils.swift
//  TextRecognition
//
//  Created by Темирлан Алпысбаев on 3/19/18.
//  Copyright © 2018 Alpysbayev. All rights reserved.
//

import Foundation
import GooglePlaces

class Utils {
    
    class func componented(string: String) -> (description: String, value: Double?) {
        var str = string.filter { $0 != "\n" || $0 != "\t" }
        let strArr = str.split(separator: " ")
        
        var value: Double?
        
        for item in strArr {
            let components = item.components(separatedBy: CharacterSet.decimalDigits.inverted)
            let part = components.joined()
            
            if let val = Double(part) {
                value = val
                str = str.replacingOccurrences(of: part, with: "")
            }
        }

        return (str, value)
    }
    
    class func getCurrentPlace(completion: @escaping(_ placeName: String?) -> Void) {
        GMSPlacesClient.shared().currentPlace(callback: { (placeLikelihoodList, error) -> Void in
            if let _ = error {
                completion(nil)
                return
            }
            
            if let placeLikelihoodList = placeLikelihoodList {
                let place = placeLikelihoodList.likelihoods.first?.place
                if let place = place {
                    completion(place.name)
                }
            }
        })
    }
    
}
