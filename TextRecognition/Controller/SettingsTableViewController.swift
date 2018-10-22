//
//  SettingsTableViewController.swift
//  TextRecognition
//
//  Created by Темирлан Алпысбаев on 4/16/18.
//  Copyright © 2018 Alpysbayev. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    @IBOutlet weak var accountLabel: UILabel!
    
    let sectionTitles = ["Для сохранения истории Войдите в свой аккаунт", "История", ""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setEmptyBackButton()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
        accountLabel.text = Profile.current.name ?? "Аккаунт"
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return Profile.current.isLoggedIn ? "Вы вошли как" : sectionTitles[section]
        case 3:
            return nil
        default:
            return sectionTitles[section]
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0, indexPath.section == 0 {
            if Profile.current.isLoggedIn {
                askToLogout()
            } else {
                performSegue(withIdentifier: LoginViewController.segueID, sender: nil)
            }
        }
    }
    
    func askToLogout() {
        Alert.showAlert(vc: self, title: "Выйти из аккаунта?", message: "Новые записи будут сохранены только локально.", actions: [
            UIAlertAction(title: "Да", style: .destructive, handler: { (action) in
                Profile.current.logout()
                self.tableView.reloadData()
                self.accountLabel.text = Profile.current.name ?? "Аккаунт"
            }),
            
            UIAlertAction(title: "Нет", style: .cancel, handler: nil)
        ])
    }
    
}
