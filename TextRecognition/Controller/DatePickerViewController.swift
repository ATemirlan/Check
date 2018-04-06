//
//  DatePickerViewController.swift
//  TextRecognition
//
//  Created by Темирлан Алпысбаев on 4/6/18.
//  Copyright © 2018 Alpysbayev. All rights reserved.
//

import UIKit

protocol DatePickerDelegate {
    func dateChoosed(date: Date)
}
class DatePickerViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    var delegate: DatePickerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.maximumDate = Date()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.0)
    }

    @IBAction func done(_ sender: UIBarButtonItem) {
        delegate?.dateChoosed(date: datePicker.date)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tap(_ sender: UITapGestureRecognizer) {
        if let v = sender.view, v.isDescendant(of: self.view) {
            dismiss(animated: true, completion: nil)
        }
    }
}
