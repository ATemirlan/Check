//
//  HistoryTableViewCell.swift
//  TextRecognition
//
//  Created by Темирлан Алпысбаев on 3/13/18.
//  Copyright © 2018 Alpysbayev. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    var record: Record?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(with record: Record) {
        self.record = record
        titleLabel.text = record.title
        locationLabel.text = record.location
        valueLabel.text = record.value.formattedNumber()
    }
    
}
