//
//  RecommendedAudioCell.swift
//  APPYSTORE
//
//  Created by BridgeLabz on 10/05/17.
//  Copyright 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView

 class RecommendedAudioCard: BaseCard {
    
    var audioEqualizer : NVActivityIndicatorView?
    
    @IBOutlet weak var rootView: UIView!
    
    @IBOutlet weak var playImg: UIImageView!
    
    @IBOutlet weak var audioTitle: UILabel!
    
    
    
    
    override func awakeFromNib() {
        
         initProgressBar()
        
        
    }
    
    
    override func fillCard(model: BaseModel) {
        let audioListingModel = model as! AudioListingModel
        
        audioTitle.text = audioListingModel.title
        if audioListingModel.isSelected {
            self.audioTitle.textColor = UIColor.green
        } else {
             self.audioTitle.textColor = UIColor.black
        }
        
        if audioListingModel.payType == "paid" {
          
             audioTitle.textColor = UIColor.lightGray
             playImg.image = #imageLiteral(resourceName: "lock_icon")
        } else {playImg.image = nil
            if !audioListingModel.isSelected{
                playImg.image = #imageLiteral(resourceName: "song_icon_white")
            }
            
        }
        if audioListingModel.isSelected && audioListingModel.payType != "paid"{
        showAudioEqualizer()
        }else{
        hideAudioEqualizer()
        }
        
      
    }
    
    func currentAudio(){
    }
    func nextAudio(){
        
    }
    override func draw(_ rect: CGRect) {
        
        rootView.layer.cornerRadius = rootView.frame.height/2
        rootView.layer.borderWidth = 1.0
        rootView.layer.borderColor = UIColor.clear.cgColor
        rootView.layer.masksToBounds = true
        
        rootView.layer.shadowColor = UIColor.lightGray.cgColor
        rootView.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        rootView.layer.shadowRadius = 0
        
        rootView.layer.masksToBounds = false
        rootView.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
       
        DimensionManager.setTextSize1280x720(label: audioTitle, size: DimensionManager.H4)
      
        
        
        
    }
     func initProgressBar() {
     
        let x = DimensionManager.getGeneralizedWidthIn4isto3Ratio(height: 1.4)
        let y = DimensionManager.getGeneralizedHeight1280x720(height: 4)
        let size = DimensionManager.getGeneralizedHeight1280x720(height: 50)
        let frame = CGRect(x: x, y: y, width: size, height: size)
        
        audioEqualizer = NVActivityIndicatorView(frame: frame, type: NVActivityIndicatorType.audioEqualizer, color: UIColor.green, padding: CGFloat(0))
    }
    func showAudioEqualizer(){
        
        self.audioEqualizer?.startAnimating()
        self.playImg?.addSubview(self.audioEqualizer!)
    }
    func hideAudioEqualizer(){
        self.audioEqualizer?.stopAnimating()
        self.audioEqualizer?.removeFromSuperview()
    }
    
}

