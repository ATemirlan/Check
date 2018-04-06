//
//  PageViewController.swift
//  TextRecognition
//
//  Created by Темирлан Алпысбаев on 3/12/18.
//  Copyright © 2018 Alpysbayev. All rights reserved.
//

import UIKit
import CoreLocation

class PageViewController: UIPageViewController, UIScrollViewDelegate {

    private var controllers: [UIViewController]!
    var currentIndex = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        disableBounces()
        view.isMultipleTouchEnabled = false
    }
    
    func setup() {
        delegate = self
        dataSource = self
        
        let cameraVC = Router.cameraVC()
        cameraVC.delegate = self
        let mainVC = Router.mainVC()
        mainVC.tabDelegate = self
        controllers = [cameraVC, mainVC]
        
        setViewControllers([controllers[1]], direction: .forward, animated: false, completion: nil)
    }
    
    func disableBounces() {
        for view in self.view.subviews {
            if let scrollView = view as? UIScrollView {
                scrollView.delegate = self
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if currentIndex == 0 && scrollView.contentOffset.x < scrollView.bounds.size.width {
            scrollView.contentOffset = CGPoint(x: scrollView.bounds.size.width, y: 0)
        } else if currentIndex == 1 && scrollView.contentOffset.x > scrollView.bounds.size.width {
            scrollView.contentOffset = CGPoint(x: scrollView.bounds.size.width, y: 0)
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if currentIndex == 0 && scrollView.contentOffset.x < scrollView.bounds.size.width {
            scrollView.contentOffset = CGPoint(x: scrollView.bounds.size.width, y: 0)
        } else if currentIndex == 1 && scrollView.contentOffset.x > scrollView.bounds.size.width {
            scrollView.contentOffset = CGPoint(x: scrollView.bounds.size.width, y: 0)
        }
    }
    
}

extension PageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate, ViewControllerAppearance {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if viewController is TabBarViewController {
            return controllers[0]
        }
        
        return nil
    }
     
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if viewController is CameraViewController {
            return controllers[1]
        }
        
        return nil
    }
    
    func viewControllerAppeared(with index: Int) {
        currentIndex = index
    }
    
    func changePage(to index: Int) {
        setViewControllers([controllers[index]], direction: currentIndex < index ? .forward : .reverse, animated: true) { (completed) in
            if completed {
                self.currentIndex = index
            }
        }
    }

}
