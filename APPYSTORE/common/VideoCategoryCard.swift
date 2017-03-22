//
//  MyCustomView.swift
//  APPYSTORE
//
//  Created by BridgeLabz on 03/03/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit

class VideoCategoryCard: UICollectionViewCell {
    
    //MARK: IBOutlets
    @IBOutlet weak var mMainView: UIView!
    @IBOutlet weak var mBgImg: UIImageView!
    @IBOutlet weak var mInfoBtn: UIButton!
    @IBOutlet weak var mLogoImg: UIImageView!
    @IBOutlet weak var mCountLabel: UILabel!
    
    //MARK: Declaration
    var pointOfPixels: CGFloat!
    
    override func awakeFromNib() {
        // getting value in point from pixels
        pointOfPixels = DimensionManager.convertPixelToPoint(pixel: 32.0)
      
        //access your IBOutlets
        mInfoBtn.layer.cornerRadius = self.pointOfPixels
        mInfoBtn.clipsToBounds = true
        
        mBgImg.layer.cornerRadius = self.pointOfPixels
        mBgImg.clipsToBounds = true
        
        mMainView.layer.cornerRadius = self.pointOfPixels
        mMainView.clipsToBounds = true
                
    }
}
