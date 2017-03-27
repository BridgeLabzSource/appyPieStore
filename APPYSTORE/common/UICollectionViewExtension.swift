//
//  UICollectionViewExtention.swift
//  APPYSTORE
//
//  Created by ios_dev on 27/03/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit

extension UICollectionView {
    func addSpacingBetweenCell() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let margin = DimensionManager.getGeneralizedWidth1280x720(width: 32)
        layout.sectionInset = UIEdgeInsets(top: 0, left: margin, bottom: 0, right: margin)
        //layout.minimumInteritemSpacing = margin
        layout.minimumLineSpacing = margin
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        setCollectionViewLayout(layout, animated: false)
    }
}
