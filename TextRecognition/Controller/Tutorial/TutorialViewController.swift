//
//  TutorialViewController.swift
//  TextRecognition
//
//  Created by Темирлан Алпысбаев on 4/11/18.
//  Copyright © 2018 Alpysbayev. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController, PageChangedProtocol {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var currentIndex = 0
    
    let descriptions = [
        "Для сканирования ценника разместите оранжевую область над названием, зеленую над суммой. Сфотаграфируйте",
        "Для изменения размера области растените ее двумя пальцами.",
        "Для перемещения области коснитесь центра, задержите на долю секунды, переместите в нужное место."
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionLabel.text = descriptions[0]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? TutorialPageViewController else {
            return
        }
        
        vc.pageDelegate = self
    }
    
    @IBAction func next(_ sender: SaveButton) {
        guard let vc = childViewControllers[0] as? TutorialPageViewController else {
            return
        }
        
        if currentIndex + 1 < 3 {
            vc.changePage(to: currentIndex + 1)
        } else {
            dismiss(animated: true, completion: {
                
            })
        }
    }
    
    func pageChanged(to index: Int) {
        currentIndex = index
        pageControl.currentPage = index
        descriptionLabel.text = descriptions[index]
    }

}
