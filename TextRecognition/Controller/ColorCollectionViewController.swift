//
//  ColorCollectionViewController.swift
//  TextRecognition
//
//  Created by Темирлан Алпысбаев on 4/18/18.
//  Copyright © 2018 Alpysbayev. All rights reserved.
//

import UIKit


private let reuseIdentifier = "Cell"

class ColorCollectionViewController: UICollectionViewController {

    let colors = [Constants.Palette.c1, Constants.Palette.c2, Constants.Palette.c3, Constants.Palette.c4, Constants.Palette.c5, Constants.Palette.c6, Constants.Palette.c7, Constants.Palette.c8, Constants.Palette.c9]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        cell.contentView.backgroundColor = colors[indexPath.row]
    
        return cell
    }

}
