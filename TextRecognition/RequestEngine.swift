//
//  RequestEngine.swift
//  TextRecognition
//
//  Created by Темирлан Алпысбаев on 3/14/18.
//  Copyright © 2018 Alpysbayev. All rights reserved.
//

import Alamofire
import SwiftyJSON

enum TypeDetection: String {
    case text = "TEXT_DETECTION"
    case label = "LABEL_DETECTION"
    case logo = "LOGO_DETECTION"
}

class RequestEngine {
    
    static let shared = RequestEngine()
    
    private init() {}
    
    private let url = "https://vision.googleapis.com/v1/images:annotate?key=\((UIApplication.shared.delegate as! AppDelegate).key)"
    
    // MARK: - Supporting function
    
    func getContent(from image: UIImage) -> String? {
        let imageData = UIImageJPEGRepresentation(image, 1)
        let base64 = imageData?.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
        return base64
    }
    
    func params(content: String, type: TypeDetection) -> Parameters {
        return [
            "requests" : [
                "image" : [
                    "content" : content
                ],
                "features": [
                    "type": type.rawValue
                ]
            ]
        ]
    }
    
    // MARK: - Methods
    
    func annotate(image: UIImage, type: TypeDetection, completion: @escaping (_ json: JSON?, _ error: String?) -> Void) {
        guard let content = getContent(from: image) else {
            completion(nil, "Не удалось извлечь фотографию")
            return
        }
        
        Alert.spinner(show: true)
        
        request(url, method: .post, parameters: params(content: content, type: type), encoding: JSONEncoding(options: .prettyPrinted)).response { (response) in
            Alert.spinner(show: false)
            
            do {
                let json = try JSON(data: response.data!)
                completion(json, nil)
            } catch {
                completion(nil, "Не удалось получить JSON")
            }
        }
    }
    
    func recognizeText(image: UIImage, completion: @escaping (_ text: String?, _ error: String?) -> Void) {
        annotate(image: image, type: .text) { (json, error) in
            if let json = json {
                let text = json["responses"][0]["fullTextAnnotation"]["text"].string
                print(text)
                completion(text, text == nil ? "Текст не найден" : nil)
            } else {
                completion(nil, error)
            }
        }
    }
    
    func recognizeLabel(image: UIImage, completion: @escaping (_ labels: [Label]?, _ error: String?) -> Void) {
        annotate(image: image, type: .label) { (json, error) in
            var result = [Label]()
            
            if let labels = json?["responses"][0]["labelAnnotations"].array {
                let _ = labels.map { result.append(Label(json: $0)) }
                completion(result, result.count == 0 ? "Не удалось распознать предмет" : nil)
            } else {
                completion(nil, error)
            }
        }
    }
    
    func recognizeLogo(image: UIImage, completion: @escaping (_ text: String?, _ error: String?) -> Void) {
        annotate(image: image, type: .logo) { (json, error) in
            if let json = json {
                print(json)
                let text = json["responses"][0]["logoAnnotations"][0]["description"].string
                completion(text, text == nil ? "Не удалось распознать предмет" : nil)
            } else {
                completion(nil, error)
            }
        }
    }
    
}
