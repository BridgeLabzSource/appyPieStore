//
//  MyCustomView.swift
//  APPYSTORE
//
//  Created by BridgeLabz on 03/03/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit

class VideoCategoryCard: BaseCard {
    
    @IBOutlet weak var rootView: UIView!
    @IBOutlet weak var imgBg: UIImageView!
    @IBOutlet weak var btnInfoContainer: UIButton!
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var lblCount: UILabel!
    
    var radius: CGFloat!
    
    override func awakeFromNib() {
        radius = DimensionManager.convertPixelToPoint(pixel: DimensionManager.getGeneralizedHeight1280x720(height: 64))
        
        btnInfoContainer.layer.cornerRadius = radius
        
        imgBg.layer.cornerRadius = radius
        imgBg.clipsToBounds = true
        
        rootView.layer.cornerRadius = radius
        rootView.clipsToBounds = true
        
        DimensionManager.setTextSize1280x720(label: lblCount, size: DimensionManager.H3)
        
        showShadowRightBottom()
    }
    
    override func fillCard(model: BaseModel) {
        let videoCategoryModel = model as! VideoCategoryModel
        let imageUrl = URL(string: videoCategoryModel.imagePath)
        imgBg.sd_setImage(with: imageUrl, placeholderImage:#imageLiteral(resourceName: "profile") )
        lblCount.text = videoCategoryModel.contentCount
    }
}
