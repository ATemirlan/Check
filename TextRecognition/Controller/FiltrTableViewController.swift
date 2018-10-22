//
//  FiltrTableViewController.swift
//  TextRecognition
//
//  Created by Темирлан Алпысбаев on 4/6/18.
//  Copyright © 2018 Alpysbayev. All rights reserved.
//

import UIKit

class FiltrTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Profile.current.filter = indexPath.row
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.accessoryType = indexPath.row == Profile.current.filter ? .checkmark : .none
    }

}
