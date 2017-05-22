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
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var playIcon: UIImageView!
    @IBOutlet weak var downloadButton: UIButton!
    
    @IBOutlet weak var titleAndDownloadBtnConstraint: NSLayoutConstraint!
    
    var videoListingModel: VideoListingModel!
    
    override func awakeFromNib() {
        
        //made hidden in first release
        downloadButton.isHidden = true
        titleAndDownloadBtnConstraint.isActive = false
        layoutIfNeeded()
        
        
        let radius = DimensionManager.convertPixelToPoint(pixel: DimensionManager.getGeneralizedHeight1280x720(height: 64))
        
        imgThumbnail.layer.cornerRadius = radius
        imgThumbnail.clipsToBounds = true
        filterView.layer.cornerRadius = radius
        filterView.clipsToBounds = true
        
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
        
        DimensionManager.setTextSize1280x720(label: lblTitle, size: DimensionManager.H3)
        
        showShadowRightBottom()
        
        let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(onCardClick))
        singleTapGesture.numberOfTapsRequired = 1
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(singleTapGesture)
    }
    
    func onCardClick() {
        if !AuthenticationUtil.isSubscribedUser() && videoListingModel.payType == AppConstants.PAID {
            let bundle = [String: Any]()
            if UserInfo.getInstance().isDeviceEligibleForTrialSubscription {
                NavigationManager.openTrialPopUp(mainControllerCommunicator: mainControllerCommunicator, bundle: bundle)
            }
            
        } else {
            NavigationManager.openVideoPlayerPage(mainControllerCommunicator: mainControllerCommunicator, model: videoListingModel)
        }
    }
    
    override func fillCard(model: BaseModel) {
        self.videoListingModel = model as! VideoListingModel
        let image_path = videoListingModel.imagePath
        let imgurl = URL(string: image_path)
        imgThumbnail.sd_setImage(with:imgurl, placeholderImage:#imageLiteral(resourceName: "place_holder_cards"))
        lblTitle.text = videoListingModel.title
        
        if videoListingModel.payType == AppConstants.PAID {
            playIcon.image = UIImage(named: "video_card_lock_icon")
            filterView.isHidden = false
            //Utils.addFilterToView(imgThumbnail)
            //Utils.addFilterToView(playIcon)
        } else {
            playIcon.image = UIImage(named: "video_card_play_icon_unselected")
            filterView.isHidden = true
            //Utils.removeFilterFromView(imgThumbnail)
            //Utils.removeFilterFromView(playIcon)
        }
    }
}
