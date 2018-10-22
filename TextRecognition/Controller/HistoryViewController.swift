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
        
        if Profile.current.filter == 1 {
            navigationItem.leftBarButtonItem = nil
        } else {
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(showDatepicker))
        }
        
        if specialDate == nil {
            getRecords()
        }
    }
    
    func getRecords() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        RealmController.shared.getRecords { (records) in
            self.records = records
            self.createSections(from: records)
            self.tableView.reloadData()
            
            self.showEmptyRecords(show: self.sections.keys.count == 0)
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }
    
    func showEmptyRecords(show: Bool) {
        if show {
            let label = UILabel(frame: CGRect(x: 16.0, y: 184.0, width: view.frame.size.width - 32.0, height: 84.0))
            label.text = "Записи не найдены"
            label.textAlignment = .center
            label.tag = 23
            label.font = UIFont(name: "AvenirNext-Regular", size: 20.0)
            view.addSubview(label)
        } else {
            for v in view.subviews {
                if v.tag == 23 {
                    v.removeFromSuperview()
                }
            }
        }
    }
    
    func createSections(from records: Results<Record>?, at date: Date? = nil) {
        sections = [Int : [Record]]()
        
        guard let records = records else {
            return
        }
        
        var keys = Set(records.map {
            Profile.current.filter == 0 ? $0.date.toString() : $0.location
        }).sorted {
            return $0.compare($1) == ComparisonResult.orderedDescending
        }
        
        if let date = date, Profile.current.filter == 0 {
            if keys.contains(date.toString()) {
                keys = [date.toString()]
            } else {
                keys = [String]()
            }
        }
        
        guard keys.count > 0 else {
            return
        }
        
        for i in 0...keys.count - 1 {
            var section = [Record]()
            let key = keys[keys.index(keys.index(of: keys.first!)!, offsetBy: i)]
            
            for record in records {
                if Profile.current.filter == 0, record.date.toString() == key {
                    section.append(record)
                } else if Profile.current.filter == 1, record.location == key {
                    section.append(record)
                }
            }
            
            sections.updateValue(section, forKey: i)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == DatePickerViewController.segueID {
            let vc = segue.destination as! DatePickerViewController
            vc.delegate = self
        }
    }
    
    func dateChoosed(date: Date) {
        cancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelSearch))
        navigationItem.rightBarButtonItem = cancel
        specialDate = date
        sections = [Int : [Record]]()
        createSections(from: records, at: date)
        tableView.reloadData()
        showEmptyRecords(show: sections.count == 0)
    }
    
    @objc func cancelSearch() {
        specialDate = nil
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "filter"), style: .done, target: self, action: #selector(showFilter))
        createSections(from: records)
        tableView.reloadData()
        showEmptyRecords(show: sections.count == 0)
    }
    
    @objc func showDatepicker() {
        performSegue(withIdentifier: DatePickerViewController.segueID, sender: nil)
    }
    
    @objc func showFilter() {
        performSegue(withIdentifier: FiltrTableViewController.segueID, sender: nil)
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
        
        if Profile.current.filter == 0 {
            return "\(records[0].date.toString()) (\(sum.formattedNumber()))"
        } else {
            return "\(records[0].location) (\(sum.formattedNumber()))"
        }
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
