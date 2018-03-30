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
        str = str.condensingWhitespace()
        
        guard let value = extractValue(from: str) else {
            return (str, nil)
        }
        
        return (str.replacingOccurrences(of: "\(value)", with: ""), value)
    }
    
    private class func extractValue(from str: String) -> Double? {
        let matched = matches(for: "((?<=\\s)|^)[-+]?((\\d{1,3}([,\\s.']\\d{3})*)|\\d+)([.,/-]\\d+)?((?=\\s)|$)", in: str)
        var newMatched = matched.filter { $0.count <= 8 && !$0.contains("/") && !$0.contains("-") }
        
        // TODO: Multiple formats
        newMatched = newMatched.map { $0.replacingOccurrences(of: " ", with: "") }
        
        if newMatched.count > 0, let val = Double(newMatched[0]) {
            return val
        }
        
        return nil
    }
    
    private class func matches(for regex: String, in text: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: text,
                                        range: NSRange(text.startIndex..., in: text))
            return results.map {
                String(text[Range($0.range, in: text)!])
            }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
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
