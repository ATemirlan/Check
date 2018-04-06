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
    
    class func mergedPhoto(from photo1: UIImage, photo2: UIImage) -> UIImage {
        let size = CGSize(width: photo1.size.width > photo2.size.width ? photo1.size.width : photo2.size.width,
                          height: photo1.size.height + photo2.size.height)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        
        photo1.draw(in: CGRect(x: 0, y: 0, width: photo1.size.width, height: photo1.size.height))
        photo2.draw(in: CGRect(x: 0, y: photo1.size.height, width:photo2.size.width, height: photo2.size.height))
        
        let mergedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return mergedImage
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
