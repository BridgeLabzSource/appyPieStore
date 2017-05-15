//
//  RecommendedAudioCell.swift
//  APPYSTORE
//
//  Created by BridgeLabz on 10/05/17.
//  Copyright 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import Foundation
import UIKit

class RecommendedAudioCard: BaseCard {
    
    
    
    @IBOutlet weak var rootView: UIView!
    
    @IBOutlet weak var playImg: UIImageView!
    
    @IBOutlet weak var audioTitle: UILabel!
    
    
    
    
    override func awakeFromNib() {
        
        
        
    }
    
    override func fillCard(model: BaseModel) {
        let audioListingModel = model as! AudioListingModel
        playImg.image = #imageLiteral(resourceName: "song_icon_white")
        audioTitle.text = audioListingModel.title
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
    
    
    override func draw(_ rect: CGRect) {
        
        
        
        ////////
        rootView.layer.cornerRadius = 2.0
        rootView.layer.borderWidth = 1.0
        rootView.layer.borderColor = UIColor.clear.cgColor
        rootView.layer.masksToBounds = true
        
        rootView.layer.shadowColor = UIColor.lightGray.cgColor
        rootView.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        rootView.layer.shadowRadius = 0
        // rootView.layer.shadowOpacity = 1.0
        rootView.layer.masksToBounds = false
        rootView.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
        //////
        let radius = DimensionManager.convertPixelToPoint(pixel: DimensionManager.getGeneralizedHeight1280x720(height: 164))
        DimensionManager.setTextSize1280x720(label: audioTitle, size: DimensionManager.H4)
        rootView.layer.cornerRadius = radius
        showShadowRightBottom()
        //////
        //imageView.image = #imageLiteral(resourceName: "slashScreenpic")
        //        playImg.layer.cornerRadius = playImg.frame.width/2
        //        playImg.layer.borderWidth = 2
        //        playImg.layer.borderColor =  UIColor.orange.cgColor
        //        
    }
    
}

