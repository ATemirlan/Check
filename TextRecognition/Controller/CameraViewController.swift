//
//  CameraViewController.swift
//  TextRecognition
//
//  Created by Темирлан Алпысбаев on 3/12/18.
//  Copyright © 2018 Alpysbayev. All rights reserved.
//

import UIKit
import SwiftyCam
import Alamofire
import SwiftyJSON
import CoreLocation
import GooglePlaces
import GoogleMaps

protocol ViewControllerAppearance {
    func viewControllerAppeared(with index: Int)
    func changePage(to index: Int)
}

enum CameraType {
    case text, product
}

class CameraViewController: SwiftyCamViewController, ListTableViewProtocol, CLLocationManagerDelegate {
    
    @IBOutlet weak var captureButton: UIButton!
    @IBOutlet var switchButtons: [CameraSwitch]!
    
    var opaqTitle: OpaqTitleView!
    var opaqValue: OpaqValueView!
    
    var delegate: ViewControllerAppearance?
    var currentCameraType: CameraType = .text
    
    lazy var blurView: UIView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.extraLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return blurEffectView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCamera()
        setupOpaqValueView()
        setupOpaqTitleView()
        
        view.addSubview(blurView)
        blurView.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.async {
            UIApplication.shared.keyWindow?.windowLevel = UIWindowLevelStatusBar + 1
        }
        
        delegate?.viewControllerAppeared(with: 0)
        perform(#selector (cameraAppeared), with: nil, afterDelay: 0.4)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        blurView.isHidden = false
        captureButton.isEnabled = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        DispatchQueue.main.async {
            UIApplication.shared.keyWindow?.windowLevel = UIWindowLevelNormal
        }
    }
    
    @objc func cameraAppeared() {
        blurView.isHidden = true
        captureButton.isEnabled = true
    }
    
    func setupOpaqTitleView() {
        let longPan = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(_:)))
        opaqTitle = OpaqTitleView.instanceFromNib()
        opaqTitle.tag = 101
        opaqTitle.addGestureRecognizer(longPan)
        opaqTitle.addGestureRecognizer(pinch)
        view.addSubview(opaqTitle)
    }
    
    func setupOpaqValueView() {
        let longPan = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(_:)))
        opaqValue = OpaqValueView.instanceFromNib()
        opaqValue.tag = 102
        opaqValue.addGestureRecognizer(longPan)
        opaqValue.addGestureRecognizer(pinch)
        view.addSubview(opaqValue)
    }
    
    // MARK: - Actions
    
    @IBAction func goToMain(_ sender: Any) {
        delegate?.changePage(to: 1)
    }
    
    @IBAction func takePhoto(_ sender: UIButton) {
        takePhoto()
    }
    
    @IBAction func cameraTypeChanged(_ sender: CameraSwitch) {
        unselectAll()
        sender.set(selected: true)
        
        changeCameraSubviews(tag: sender.tag)
        currentCameraType = sender.tag == 0 ? .text : .product
    }
    
    func changeCameraSubviews(tag: Int) {
        opaqValue.isHidden = tag != 0
        opaqTitle.isHidden = tag != 0
    }
    
    func unselectAll() {
        let _ = switchButtons.map { $0.set(selected: false) }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ViewController
        vc.img = sender as! UIImage
    }
    
    func recognizeText(photo: UIImage) {
        let photo1 = photo.correctlyOrientedImage().cropp(title: true)
        let photo2 = photo.correctlyOrientedImage().cropp(title: false)
        let mergedPhoto = Utils.mergedPhoto(from: photo1, photo2: photo2)
        let photoToSave = photo.cropped()
        
        RequestEngine.shared.recognizeText(image: mergedPhoto) { (text, error) in
            self.blurView.isHidden = true

            guard let text = text, error == nil else {
                Alert.showError(textError: error!, above: self)
                return
            }
            
            let record = RealmController.shared.create(from: text, location: Profile.current.location ?? "", photo: photoToSave)
            self.goToMain(self.captureButton)
            self.perform(#selector(self.sendNotification(record:)), with: record, afterDelay: 1.0)
        }
    }
    
    @objc func sendNotification(record: Record) {
        NotificationCenter.default.post(name: .checkVC, object: nil, userInfo: ["record" : record])
    }
    
    func recognizeLabel(photo: UIImage) {
        let cropped = photo.cropped()
        RequestEngine.shared.recognizeLabel(image: cropped) { (labels, error) in
            guard let labels = labels, error == nil else {
                self.blurView.isHidden = true
                Alert.showError(textError: error!, above: self)
                return
            }
            
            let listVC = Router.listVC(above: self)
            listVC.labels = labels
            listVC.photo = cropped
            self.present(listVC, animated: true, completion: nil)
        }
    }
    
    func choosed(label: Label, photo: UIImage) {
        self.blurView.isHidden = true
        let record = RealmController.shared.create(from: label.description, location: Profile.current.location ?? "", photo: photo)
        NotificationCenter.default.post(name: .checkVC, object: nil, userInfo: ["record" : record])
        self.goToMain(self.captureButton)
    }
    
}

extension CameraViewController: SwiftyCamViewControllerDelegate {
    
    func setupCamera() {
        cameraDelegate = self
        audioEnabled = false
        swipeToZoom = false
        pinchToZoom = true
        panGesture.isEnabled = false
        doubleTapCameraSwitch = false
        shouldUseDeviceOrientation = true
    }
    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didTake photo: UIImage) {
        blurView.isHidden = false

        switch self.currentCameraType {
        case .product:
            self.recognizeLabel(photo: photo)
            break
        case .text:
            self.recognizeText(photo: photo)
            break
        }
    }
    
}

// MARK: - Gestures

extension CameraViewController {
    
    @objc func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        guard let view = gesture.view else {
            return
        }
        
        switch gesture.state {
        case .began:
            UISelectionFeedbackGenerator().selectionChanged()
        case .changed:
            let location = gesture.location(in: self.view)
            view.center = CGPoint(x:view.center.x + (location.x - view.center.x),
                                  y:view.center.y + (location.y - view.center.y))
        case .ended:
            checkBoundaries(of: view)
            (view as! OpaqView).update(origin: view.frame.origin)
        default:
            return
        }
    }
    
    @objc func handlePinch(_ gesture: UIPinchGestureRecognizer) {
        guard let view = gesture.view else {
            return
        }
        
        view.transform = view.transform.scaledBy(x: gesture.scale, y: gesture.scale)
        gesture.scale = 1
        
        if gesture.state == .ended {
            checkSize(of: view)
            checkBoundaries(of: view)
            
            (view as! OpaqView).update(origin: view.frame.origin)
            (view as! OpaqView).update(size: view.frame.size)
            
            view.removeFromSuperview()
            view.tag == 101 ? setupOpaqTitleView() : setupOpaqValueView()
        }
    }
    
    func checkSize(of view: UIView) {
        if view.tag == 101, view.frame.width > Constants.CameraFrame.width {
            view.frame.size = CGSize(width: Constants.CameraFrame.width, height: 110.0)
        } else if view.tag == 102, view.frame.width > Constants.CameraFrame.width / 2.0 {
            view.frame.size = CGSize(width: Constants.CameraFrame.width / 2.0, height: 110.0)
        }
            
    }
    
    func checkBoundaries(of view: UIView) {
        if view.center.x + view.frame.size.width / 2.0 > Constants.CameraFrame.right {
            view.frame.origin.x = Constants.CameraFrame.right - view.frame.size.width
        }
        if view.frame.origin.x < Constants.CameraFrame.left {
            view.frame.origin.x = Constants.CameraFrame.left
        }
        if view.frame.origin.y < Constants.CameraFrame.top {
            view.frame.origin.y = Constants.CameraFrame.top
        }
        if view.center.y + view.frame.size.height / 2.0 > Constants.CameraFrame.bottom {
            view.frame.origin.y = Constants.CameraFrame.bottom - view.frame.size.height
        }
        self.view.layoutIfNeeded()
    }
    
}
