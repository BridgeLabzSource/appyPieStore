//
//  RecommendedAudioCell.swift
//  APPYSTORE
//
//  Created by BridgeLabz on 10/05/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import Foundation


class RecommendedAudioCard: BaseCard {

override func awakeFromNib() {
    let radius = DimensionManager.convertPixelToPoint(pixel: DimensionManager.getGeneralizedHeight1280x720(height: 64))
    
    }

override func fillCard(model: BaseModel) {
    let audioListingModel = model as! AudioListingModel
    
    
    if audioListingModel.isSelected {
        //self.backgroundColor = UIColor.green
    } else {
       // self.backgroundColor = UIColor.white
    }
    
    if audioListingModel.payType == "paid" {
       // Utils.addFilterToView(imgThumbnail)
    } else {
       // Utils.removeFilterFromView(imgThumbnail)
    }
    
}

}
    
