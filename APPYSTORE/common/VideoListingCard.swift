//
//  VideoListingCard.swift
//  APPYSTORE
//
//  Created by ios_dev on 23/03/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit

@IBDesignable class VideoListingCard: UICollectionViewCell {
    
    @IBOutlet weak var imgThumbnail: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        let radius = DimensionManager.convertPixelToPoint(pixel: DimensionManager.getGeneralizedHeight1280x720(height: 64))
        
        imgThumbnail.layer.cornerRadius = radius
        imgThumbnail.clipsToBounds = true
        
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
        
        DimensionManager.setTextSize1280x720(label: lblTitle, size: DimensionManager.H3)
    }
}
