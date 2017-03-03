//
//  ViewController.swift
//  APPYSTORE
//
//  Created by BridgeLabz on 21/02/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit

class VideoCategoryController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    //MARK: IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    //MARK: Declarations
    let image = ["ic_launcher", "ic_launcher", "ic_launcher", "ic_launcher", "ic_launcher", "ic_launcher"]
    
    var pointOfPixels: CGFloat!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        // getting value in point from pixels
        pointOfPixels = DimentionManager.convertPixelToPoint(pixel: 64.0)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return image.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as!  CustomImageCell
        
        //call to round method of UIView class
        // let view = UIView().round(corners: .topLeft, radius: self.pointOfPixels)
        
        // setting cornerRadius of backgroundImage
        cell.mBgImage.layer.cornerRadius = self.pointOfPixels
        cell.mBgImage.clipsToBounds = true
        
        // setting cornerRadius of logoButton
        cell.mLogoBtn.layer.cornerRadius = self.pointOfPixels
        cell.mLogoBtn.clipsToBounds = true
        
        // setting cornerRadius of view
        cell.mMainView.layer.cornerRadius = self.pointOfPixels
        cell.mMainView.clipsToBounds = true
        
        // setting shadow of view
        let plain = cell
        applyPlainShadow(view: plain)
        
        return cell
    }
    
    
    // function for Plain Shadow
    func applyPlainShadow(view: UIView) {
        let layer = view.layer
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 8, height: 8)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 1.0
        layer.masksToBounds = false
    }
}
