//
//  AudioCategoryCard.swift
//  APPYSTORE
//
//  Created by BridgeLabz Solutions LLP  on 5/4/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit

class AudioCategoryCard: BaseCard {

    @IBOutlet weak var rootView: UIView!
    
    @IBOutlet weak var imgLogo: UIImageView!
    
    @IBOutlet weak var viewInfoContainer: UIView!
    
    @IBOutlet weak var lblCount: UILabel!
    
    @IBOutlet weak var imgAudio: UIImageView!

    var radius: CGFloat!
    
    override func awakeFromNib() {
        radius = DimensionManager.convertPixelToPoint(pixel: DimensionManager.getGeneralizedHeight1280x720(height: 64))
      
        rootView.layer.cornerRadius = radius
        rootView.clipsToBounds = true
        
        imgLogo.layer.cornerRadius = radius
        imgLogo.clipsToBounds = true
        
        viewInfoContainer.layer.cornerRadius = radius
        viewInfoContainer.clipsToBounds = true

        DimensionManager.setTextSize1280x720(label: lblCount, size: DimensionManager.H3)
        
        showShadowRightBottom()
    }
    
    override func fillCard(model: BaseModel) {
        let audioCategoryModel = model as! AudioCategoryModel
        let imageUrl = URL(string: audioCategoryModel.imagePath)
        imgLogo.sd_setImage(with: imageUrl, placeholderImage:#imageLiteral(resourceName: "profile") )
        lblCount.text = audioCategoryModel.contentCount
    }

}
