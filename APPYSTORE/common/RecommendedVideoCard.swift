//
//  RecommendedVideo.swift
//  APPYSTORE
//
//  Created by ios_dev on 12/04/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import Foundation
import UIKit

class RecommendedVideoCard: BaseCard {

    @IBOutlet weak var imgThumbnail: UIImageView!
    
    override func awakeFromNib() {
        let radius = DimensionManager.convertPixelToPoint(pixel: DimensionManager.getGeneralizedHeight1280x720(height: 64))
        
        imgThumbnail.layer.cornerRadius = radius
        imgThumbnail.clipsToBounds = true
         
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
        
        showShadowRightBottom()
    }
    
    override func fillCard(model: BaseModel) {
        let videoListingModel = model as! VideoListingModel
        let image_path = videoListingModel.imagePath
        let imgurl = URL(string: image_path)
        imgThumbnail.sd_setImage(with:imgurl, placeholderImage:#imageLiteral(resourceName: "place_holder_cards") )
        
        if videoListingModel.isSelected {
            self.backgroundColor = UIColor.green
        } else {
            self.backgroundColor = UIColor.white
        }
        
        if videoListingModel.payType == "paid" {
            Utils.addFilterToView(imgThumbnail)
        } else {
            Utils.removeFilterFromView(imgThumbnail)
        }
        
    }
    
    
    
}
