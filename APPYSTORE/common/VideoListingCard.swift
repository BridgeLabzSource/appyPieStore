//
//  VideoListingCard.swift
//  APPYSTORE
//
//  Created by ios_dev on 23/03/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit
import SDWebImage

@IBDesignable class VideoListingCard: BaseCard {
    
    @IBOutlet weak var imgThumbnail: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var playIcon: UIImageView!
    @IBOutlet weak var downloadButton: UIButton!
    
    @IBOutlet weak var titleAndDownloadBtnConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        
        //made hidden in first release
        downloadButton.isHidden = true
        titleAndDownloadBtnConstraint.isActive = false
        layoutIfNeeded()
        
        
        let radius = DimensionManager.convertPixelToPoint(pixel: DimensionManager.getGeneralizedHeight1280x720(height: 64))
        
        imgThumbnail.layer.cornerRadius = radius
        imgThumbnail.clipsToBounds = true
        
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
        
        DimensionManager.setTextSize1280x720(label: lblTitle, size: DimensionManager.H3)
        
        showShadowRightBottom()
    }
    
    override func fillCard(model: BaseModel) {
        let videoListingModel = model as! VideoListingModel
        let image_path = videoListingModel.imagePath
        let imgurl = URL(string: image_path)
        imgThumbnail.sd_setImage(with:imgurl, placeholderImage:#imageLiteral(resourceName: "profile") )
        lblTitle.text = videoListingModel.title
    }
}
