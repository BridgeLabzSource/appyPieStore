//
//  AudioPlayer.swift
//  APPYSTORE
//
//  Created by BridgeLabz Solutions LLP  on 4/26/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit

class AudioListingCard: BaseCard
{
    @IBOutlet weak var imgThumbnail: UIImageView!
    
    @IBOutlet weak var songIcon: UIImageView!
    
    @IBOutlet weak var audioTitle: UILabel!
    
    override func awakeFromNib() {
        let radius = DimensionManager.convertPixelToPoint(pixel: DimensionManager.getGeneralizedHeight1280x720(height: 64))
        
        imgThumbnail.layer.cornerRadius = radius
        imgThumbnail.clipsToBounds = true
        
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
        
        DimensionManager.setTextSize1280x720(label: audioTitle, size: DimensionManager.H3)
        
        showShadowRightBottom()
    }
    
    override func fillCard(model: BaseModel) {
        let audioListingModel = model as! AudioListingModel
        let image_path = audioListingModel.imagePath
        let imgurl = URL(string: image_path)
        imgThumbnail.sd_setImage(with:imgurl, placeholderImage:#imageLiteral(resourceName: "profile") )
        audioTitle.text = audioListingModel.title
    }
}
