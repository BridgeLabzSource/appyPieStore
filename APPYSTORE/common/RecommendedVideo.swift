//
//  RecommendedVideo.swift
//  APPYSTORE
//
//  Created by ios_dev on 12/04/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import Foundation
import UIKit

class RecommendedVideo: UICollectionViewCell {

    @IBOutlet weak var imgThumbnail: UIImageView!
    @IBOutlet var rootView: UIView!
    
    override func awakeFromNib() {
        let radius = DimensionManager.convertPixelToPoint(pixel: DimensionManager.getGeneralizedHeight1280x720(height: 64))
        
        imgThumbnail.layer.cornerRadius = radius
        imgThumbnail.clipsToBounds = true
        
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
        
        showShadowRightBottom()
    }
    
    func fillCard(videoListingModel: VideoListingModel) {
        let image_path = videoListingModel.imagePath
        let imgurl = URL(string: image_path)
        imgThumbnail.sd_setImage(with:imgurl, placeholderImage:#imageLiteral(resourceName: "profile") )
    }
    
}
