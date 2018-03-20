//
//  ListViewController.swift
//  Tengri template
//
//  Created by Темирлан Алпысбаев on 9/18/17.
//  Copyright © 2017 TemirlanAlpysbayev. All rights reserved.
//

import UIKit

protocol ListTableViewProtocol {
    func choosed(label: Label, photo: UIImage)
}

class ListViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var listView: UITableView!

    @IBOutlet weak var listViewHeight: NSLayoutConstraint!
    
    var delegate: ListTableViewProtocol?
    
    var labels: [Label]!
    var photo: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.0)
        listView.register(UINib(nibName: ListTableViewCell.className, bundle: nil), forCellReuseIdentifier: ListTableViewCell.cellID)
        labels = labels.sorted { return $0.score < $1.score }
        determineTableViewHeight()
    }

    @IBAction func close(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func determineTableViewHeight() {
        let numberOfRows: CGFloat = CGFloat(listView.numberOfRows(inSection: 0))
        let rowHeight: CGFloat = 82.0
        let maxHeight: CGFloat = 5 * rowHeight
        
        let height = numberOfRows * rowHeight <= maxHeight ? numberOfRows * rowHeight : maxHeight
        listViewHeight.constant = CGFloat(height)
        view.layoutIfNeeded()
    }
    
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return labels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.cellID) as! ListTableViewCell
        cell.titleLabel.text = labels[indexPath.row].description
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismiss(animated: true) { 
            self.delegate?.choosed(label: self.labels[indexPath.row], photo: self.photo)
        }
    }
    
}
