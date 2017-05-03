//
//  childCard.swift
//  APPYSTORE
//
//  Created by ios_dev on 21/04/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit

class ChildCard: BaseCard {
    
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    
    override func awakeFromNib() {
        DimensionManager.setTextSize1280x720(label: lblName, size: DimensionManager.H3)
    }
    
    override func fillCard(model: BaseModel) {
        let childModel = model as! AvatarModel
        let imagePath = childModel.imagePath
        let imgurl = URL(string: imagePath)
        imgAvatar.sd_setImage(with:imgurl, placeholderImage:#imageLiteral(resourceName: "profile") )
        lblName.text = childModel.name
        setCardSelection(childModel: childModel)
    }

    func setCardSelection(childModel: AvatarModel) {
        if(childModel.isSelected) {
            imgAvatar.layer.borderColor = UIColor.red.cgColor
        } else {
            imgAvatar.layer.borderColor = UIColor.white.cgColor
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let radius = imgAvatar.bounds.size.height / 2.0
        imgAvatar.layer.cornerRadius = radius
        imgAvatar.clipsToBounds = true
        
        imgAvatar.layer.borderWidth = 2
        imgAvatar.layer.borderColor = UIColor.white.cgColor
    }

}
