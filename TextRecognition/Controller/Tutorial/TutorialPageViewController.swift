//
//  TutorialPageViewController.swift
//  TextRecognition
//
//  Created by Темирлан Алпысбаев on 4/12/18.
//  Copyright © 2018 Alpysbayev. All rights reserved.
//

import UIKit

protocol TutorialPageProtocol {
    var pageIndex: Int { get set }
}

protocol PageChangedProtocol {
    func pageChanged(to index: Int)
}

class TutorialPageViewController: UIPageViewController {

    private var controllers: [UIViewController]!
    var currentIndex = 1
    
    var pageDelegate: PageChangedProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        dataSource = self
        
        let vc1 = (Router.getViewController(with: Page1ViewController.className) as! Page1ViewController)
        let vc2 = (Router.getViewController(with: Page2ViewController.className) as! Page2ViewController)
        let vc3 = (Router.getViewController(with: Page3ViewController.className) as! Page3ViewController)
        vc1.delegate = self
        vc2.delegate = self
        vc3.delegate = self
        controllers = [vc1, vc2, vc3]
        
        setViewControllers([controllers[0]], direction: .forward, animated: false, completion: nil)
    }
    
    

}

extension TutorialPageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate, ViewControllerAppearance {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let index = (viewController as? TutorialPageProtocol)?.pageIndex, index - 1 >= 0 {
            return controllers[index - 1]
        }
        
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let index = (viewController as? TutorialPageProtocol)?.pageIndex, index + 1 <= controllers.count - 1 {
            return controllers[index + 1]
        }
        
        return nil
    }
    
    func viewControllerAppeared(with index: Int) {
        pageDelegate?.pageChanged(to: index)
    }
    
    func changePage(to index: Int) {
        setViewControllers([controllers[index]], direction: .forward, animated: true) { (completed) in
            if completed {
                self.currentIndex = index
            }
        }
    }
    
}
