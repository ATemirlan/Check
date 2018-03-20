//
//  CheckViewController.swift
//  TextRecognition
//
//  Created by Темирлан Алпысбаев on 3/12/18.
//  Copyright © 2018 Alpysbayev. All rights reserved.
//

import UIKit

protocol CheckDelegate {
    func changePage(to index: Int)
}

class CheckViewController: UIViewController {

    @IBOutlet weak var valueField: UITextField!
    @IBOutlet weak var locationField: UITextField!
    @IBOutlet weak var descriptionView: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    
    var record: Record?
    var delegate: CheckDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(recordRecieved(_:)), name: .checkVC, object: nil)
    }
    
    @objc func recordRecieved(_ notification: NSNotification) {
        if let r = notification.userInfo?["record"] as? Record {
            record = r
            valueField.text = record?.value ?? ""
            locationField.text = record?.location ?? ""
            descriptionView.text = record?.title ?? ""
            
            if record?.title == "" { descriptionView.becomeFirstResponder() }
            if record?.location == "" { locationField.becomeFirstResponder() }
            if record?.value == "" { valueField.becomeFirstResponder() }
        }
        
        checkIfRecordCanBeSaved()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    @IBAction func goToCamera(_ sender: Any) {
        delegate?.changePage(to: 0)
    }
    
    @IBAction func saveRecord(_ sender: UIButton) {
        if let record = record {
            RealmController.shared.add(record: record)
        }
    }
}

extension CheckViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if record == nil {
            record = Record()
        }
        
        switch textField.tag {
        case 0:
            record?.value = textField.text!
            break
        case 1:
            record?.location = textField.text!
            break
        case 2:
            record?.title = textField.text!
            break
        default:
            return
        }
        
        checkIfRecordCanBeSaved()
    }
    
    func checkIfRecordCanBeSaved() {
        guard let record = record else {
            saveButton.isEnabled = false
            return
        }
        
        saveButton.isEnabled = record.canbeSaved()
    }
    
}
