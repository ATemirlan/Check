//
//  RealmController.swift
//  TextRecognition
//
//  Created by Темирлан Алпысбаев on 3/20/18.
//  Copyright © 2018 Alpysbayev. All rights reserved.
//

import RealmSwift

class RealmController {
    
    static let shared = RealmController()
    private var realm: Realm?
    
    private init() {
        do {
            self.realm = try Realm()
        } catch {
            guard let vc = UIApplication.shared.keyWindow?.viewController() else {
                return
            }
            
            Alert.showError(textError: "Ошибка базы данных", above: vc)
        }
    }
    
    func add(record: Record) {
        do {
            try realm?.write {
                realm?.add(record)
            }
        } catch (let error) {
            print(error)
        }
    }
    
    func create(from text: String, location: String, photo: UIImage) -> Record {
        let record = Record()
        record.title = extractInfo(from: text).title ?? ""
        record.value = extractInfo(from: text).value ?? 0.0
        record.location = location
        record.date = Date()
        record.imgData = UIImageJPEGRepresentation(photo, 1.0)!
        return record
    }
    
    func getRecords(completion: @escaping (_ records: Results<Record>?) -> Void) {
        guard let records = realm?.objects(Record.self) else {
            completion(nil)
            return
        }
        
        completion(records.sorted(byKeyPath: "date", ascending: false))
    }
    
    func remove(record: Record) {
        do {
            try realm?.write {
                realm?.delete(record)
            }
        } catch (let error) {
            print(error)
        }
    }
    
}

fileprivate extension RealmController {
    
    func extractInfo(from text: String) -> (value: Float?, title: String?) {
        var value: Float? = nil
        var components = text.components(separatedBy: "\n")
        
        guard components.count >= 0 else {
            return (nil, nil)
        }
        
        components = components.filter { $0 != "" }
        
        for component in components.reversed() {
            if let val = extractValue(from: component) {
                value = val
                components.remove(at: components.index(of: component)!)
                break
            }
        }
        
        var title = ""
        let _ = components.map { title += ($0 + " ") }

        return (value, title == "" ? nil : title)
    }
    
    func extractValue(from string: String) -> Float? {
        guard let str = matches(for: "[0-9,.]", in: string), str != "" else {
            return nil
        }
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        var number = numberFormatter.number(from: condenseSigns(from: str))
        
        if let float = number?.floatValue {
            return float
        }
        
        numberFormatter.decimalSeparator = ","
        number = numberFormatter.number(from: condenseSigns(from: str))
        
        if let float = number?.floatValue {
            return float
        }
        
        return nil
    }
    
    func matches(for regex: String, in text: String) -> String? {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: text,
                                        range: NSRange(text.startIndex..., in: text))
            
            let arr = results.map {
                String(text[Range($0.range, in: text)!])
            }
            
            var result = ""
            let _ = arr.map { result += $0 }
            
            return result
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return ""
        }
    }
    
    func condenseSigns(from string: String) -> String {
        var str = String(string.reversed())
        
        for char in str {
            if char == "." || char == "," {
                str.remove(at: str.index(of: char)!)
            } else {
                break
            }
        }
        
        return String(str.reversed())
    }
    
}

