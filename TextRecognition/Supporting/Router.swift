//
//  Router.swift
//  Kundelik
//
//  Created by Темирлан Алпысбаев on 1/23/18.
//  Copyright © 2018 Alpysbayev. All rights reserved.
//

import UIKit
//import RealmSwift

class Router {

    static func listVC(above vc: UIViewController) -> ListViewController {
        let listVC = ListViewController(nibName: ListViewController.className, bundle: nil)
        listVC.modalPresentationStyle = .overFullScreen
        listVC.modalTransitionStyle = .crossDissolve
        listVC.delegate = vc as? ListTableViewProtocol
        return listVC
    }
    
    static func cameraVC() -> CameraViewController {
        return getViewController(with: CameraViewController.className) as! CameraViewController
    }
    
    static func mainVC() -> TabBarViewController {
        return getViewController(with: TabBarViewController.className) as! TabBarViewController
    }
    
    static func showPopover(above vc: UIViewController, _ cell: HistoryTableViewCell) {
        let popController = getViewController(with: DetailViewController.className) as! DetailViewController
        popController.modalPresentationStyle = UIModalPresentationStyle.popover
        popController.popoverPresentationController?.permittedArrowDirections = .any
        popController.popoverPresentationController?.delegate = vc as? UIPopoverPresentationControllerDelegate
        popController.popoverPresentationController?.sourceView = cell.contentView
        popController.popoverPresentationController?.sourceRect = cell.bounds
        popController.record = cell.record
        
        if let record = cell.record, let img = UIImage(data: record.imgData) {
            popController.preferredContentSize = CGSize(width: img.size.width * 0.41, height: img.size.height * 0.41)
        }
        
        vc.present(popController, animated: true, completion: nil)
    }
    
    static func setPaging(enabled: Bool) {
        guard let pageVC = UIApplication.shared.keyWindow?.rootViewController else {
            return
        }
        
        for scroll in pageVC.view.subviews {
            if scroll is UIScrollView {
                (scroll as! UIScrollView).isScrollEnabled = enabled
            }
        }
    }
    
    private static func getViewController(with id: String) -> UIViewController {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: id)
    }
    
}
