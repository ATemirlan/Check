//
//  PageViewController.swift
//  TextRecognition
//
//  Created by Темирлан Алпысбаев on 3/12/18.
//  Copyright © 2018 Alpysbayev. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIScrollViewDelegate {

    private var controllers: [UIViewController]!
    var currentIndex = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        disableBounces()
        
        sentenceAnalyze("")
    }
    
    func sentenceAnalyze(_ sentence : String) -> Void {
        let tagger = NSLinguisticTagger(tagSchemes: [.nameType], options: 0)
        let text = "In 1997, Sandy Williamson and Slaughter Fitz-Hugh co-founded CapTech Consulting, Inc. in their hometown of Richmond, VA."
        
        tagger.string = text
        
        let range = NSRange(location: 0, length: text.utf16.count)
        let options: NSLinguisticTagger.Options = [.omitPunctuation, .omitWhitespace, .joinNames]
        
        let tags: [NSLinguisticTag] = [.personalName, .placeName, .organizationName]
        
        tagger.enumerateTags(in: range, unit: .word, scheme: .lexicalClass, options: options) {
            tag, tokenRange, stop in
            if let tag = tag, tags.contains(tag) {
                let token = (text as NSString).substring(with: tokenRange)
                print(token)
            }
        }

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
    
    func detected(text: String) {
        
    }
    
}
