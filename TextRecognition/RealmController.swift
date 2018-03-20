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
        record.value = "\(Utils.componented(string: text).value ?? 0.0)"
        record.title = Utils.componented(string: text).description
        record.location = location
        record.imgData = UIImageJPEGRepresentation(photo, 0.7)!
        return record
    }
    
    func getRecords(completion: @escaping (_ records: Results<Record>?) -> Void) {
        guard let records = realm?.objects(Record.self) else {
            completion(nil)
            return
        }
        
        completion(records)
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

