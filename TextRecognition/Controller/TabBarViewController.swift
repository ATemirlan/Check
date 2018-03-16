//
//  TabBarViewController.swift
//  TextRecognition
//
//  Created by Темирлан Алпысбаев on 3/12/18.
//  Copyright © 2018 Alpysbayev. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController, CheckDelegate {

    var tabDelegate: ViewControllerAppearance?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tabDelegate?.viewControllerAppeared(with: 1)
    }
    
    func setupTabBar() {
        guard let items = tabBar.items else {
            return
        }
        
        for i in 0..<items.count {
            tabBar.items![i].title = "";
            tabBar.items![i].imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
        }
        
        let navvc = childViewControllers[0] as! UINavigationController
        let vc = navvc.viewControllers[0] as! CheckViewController
        vc.delegate = self
    }
    
    func changePage(to index: Int) {
        tabDelegate?.changePage(to: index)
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        Router.setPaging(enabled: item.tag == 0)
    }

}
