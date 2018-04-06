//
//  HistoryViewController.swift
//  TextRecognition
//
//  Created by Темирлан Алпысбаев on 3/12/18.
//  Copyright © 2018 Alpysbayev. All rights reserved.
//

import UIKit
import RealmSwift

class HistoryViewController: UIViewController, DatePickerDelegate {

    @IBOutlet weak var tableView: UITableView!
    var cancel = UIBarButtonItem()
    
    var records: Results<Record>?
    var sections = [Int : [Record]]()
    
    var specialDate: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setEmptyBackButton()
        tableView.register(UINib(nibName: HistoryTableViewCell.className, bundle: nil), forCellReuseIdentifier: HistoryTableViewCell.cellID)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if specialDate == nil {
            getRecords()
        }
    }
    
    func getRecords() {
        RealmController.shared.getRecords { (records) in
            self.records = records
            
            if let records = records {
                self.createSections(from: records, at: self.specialDate)
                self.tableView.reloadData()
            }
        }
    }
    
    func createSections(from records: Results<Record>, at date: Date? = nil) {
        var keys = Set(records.map {
            $0.date.toString()
        }).sorted {
            return $0.compare($1) == ComparisonResult.orderedDescending
        }
        
        if let date = date, keys.contains(date.toString()) {
            keys = [date.toString()]
        }
        
        guard keys.count > 0 else {
            return
        }
        
        for i in 0...keys.count - 1 {
            var section = [Record]()
            let key = keys[keys.index(keys.index(of: keys.first!)!, offsetBy: i)]
            
            for record in records {
                if record.date.toString() == key {
                    section.append(record)
                }
            }
            
            sections.updateValue(section, forKey: i)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == FiltrTableViewController.segueID {
            
        } else if segue.identifier == DatePickerViewController.segueID {
            let vc = segue.destination as! DatePickerViewController
            vc.delegate = self
        }
    }
    
    func dateChoosed(date: Date) {
        cancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelSearch))
        navigationItem.rightBarButtonItem = cancel
        self.specialDate = date
        
        if let records = records {
            sections = [Int : [Record]]()
            createSections(from: records, at: date)
            tableView.reloadData()
        }
    }
    
    @objc func cancelSearch() {
        navigationItem.rightBarButtonItem = nil
    }
    
}

extension HistoryViewController: UITableViewDataSource, UITableViewDelegate, UIPopoverPresentationControllerDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.keys.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let record = sections[indexPath.section]?[indexPath.row] else {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: HistoryTableViewCell.cellID) as! HistoryTableViewCell
        cell.setup(with: record)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? HistoryTableViewCell else {
            return
        }
        
        DispatchQueue.main.async {
            Router.showPopover(above: self, cell)
        }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let records = sections[section] else {
            return nil
        }
        
        var sum: Float = 0.0
        let _ = records.map { sum += $0.value }
        
        return "\(records[0].date.toString()) (\(sum.formattedNumber()))"
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 32.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64.0
    }
    
}
