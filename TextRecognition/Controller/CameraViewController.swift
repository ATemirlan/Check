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
    
    @IBOutlet var textFocus: [UIView]!
    @IBOutlet var productFocus: [UIView]!
    
    @IBOutlet weak var captureButton: UIButton!
    @IBOutlet var switchButtons: [CameraSwitch]!
    
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
        
        view.addSubview(blurView)
        blurView.isHidden = true
        
        textFocus(hide: false)
        productFocus(hide: true)
        
        setupCamera()
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
        
        textFocus(hide: sender.tag == 1)
        productFocus(hide: sender.tag == 0)
        
        currentCameraType = sender.tag == 0 ? .text : .product
    }
    
    func unselectAll() {
        let _ = switchButtons.map { $0.set(selected: false) }
    }

    func textFocus(hide: Bool) {
        let _ = textFocus.map { $0.isHidden = hide }
    }
    
    func productFocus(hide: Bool) {
        let _ = productFocus.map { $0.isHidden = hide }
    }
    
    func recognizeLabel(photo: UIImage) {
        RequestEngine.shared.recognizeLabel(image: photo.cropped(type: .product)) { (labels, error) in
            guard let labels = labels, error == nil else {
                self.blurView.isHidden = true
                Alert.showError(textError: error ?? "Что-то пошло не так", above: self)
                return
            }
            
            let listVC = Router.listVC(above: self)
            listVC.labels = labels
            self.present(listVC, animated: true, completion: nil)
        }
    }
    
    func recognizeText(photo: UIImage) {
        RequestEngine.shared.recognizeText(image: photo.cropped(type: .text)) { (text, error) in
            self.blurView.isHidden = true
            
            guard let text = text, error == nil else {
                Alert.showError(textError: error ?? "Что-то пошло не так", above: self)
                return
            }
            
            let record = RealmController.shared.create(from: text, location: Profile.current.location ?? "", photo: photo.cropped(type: .text))
            NotificationCenter.default.post(name: .checkVC, object: nil, userInfo: ["record" : record])
            self.goToMain(self.captureButton)
        }
    }
    
    func choosed(label: Label) {
        self.blurView.isHidden = true
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

