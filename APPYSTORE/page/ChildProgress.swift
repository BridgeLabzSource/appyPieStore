//
//  ChildProgress.swift
//  APPYSTORE
//
//  Created by BridgeLabz on 05/05/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit

class ChildProgress: BaseCard {
    
    @IBOutlet weak var childimg: UIImageView!
    
    @IBOutlet weak var editImg: UIImageView!
    
    @IBOutlet weak var childName:UILabel!
    
    @IBOutlet weak var childAge:UILabel!
    
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        childimg.layer.borderWidth = 3
     //   childimg.layer.borderColor = UIColor.white.cgColor
        editImg.layer.borderWidth = 3
        editImg.layer.borderColor = UIColor.white.cgColor
        childimg.layer.cornerRadius = childimg.frame.width/2
        //childimg.clipsToBounds = true
        print("height = ",childimg.frame.height,"   width= ",childimg.frame.width)
        editImg.layer.cornerRadius = editImg.frame.height/2
    }
    
    override func awakeFromNib() {
        DimensionManager.setTextSize1280x720(label: childName, size: DimensionManager.H3)
        DimensionManager.setTextSize1280x720(label: childAge, size: DimensionManager.H3)
            }
    
    override func fillCard(model: BaseModel) {
        let childModel = model as! ChildInfo
            childName.text = childModel.name
        if (Int)(childModel.age!)  == 0
        {  var month =  childModel.month!
            month += " month"
            print("month +======= " ,month)
            childAge.text = month
        }else{
            if Int(childModel.age!)! > 1{
                    childAge.text = childModel.age!+" years"
            }else{
                    childAge.text = childModel.age!+" year"
            }
        }
        if let image_url = childModel.avatarImage{
          let  url = URL(string: image_url)
            childimg.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "profile") )
        }else{
            childimg.image = #imageLiteral(resourceName: "avatar_placeholder")
        }
       editImg.image = #imageLiteral(resourceName: "icon_edit")
      //  let avatarModel: AvatarModel = ChildInfoToAvatarModelAdapter(childInfo: childModel)
        setCardSelection(childModel: childModel)
        
    }
    
    func setCardSelection(childModel: ChildInfo) {
        if(childModel.id == UserInfo.getInstance().selectedChild?.id) {
            childimg.layer.borderColor = UIColor.green.cgColor
            editImg.isHidden = false
        } else {
            editImg.isHidden = true
            childimg.layer.borderColor = UIColor.white.cgColor
        }
    }
   
    
    
    

    
}
