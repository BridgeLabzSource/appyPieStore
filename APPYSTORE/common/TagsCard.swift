//
//  TagsCard.swift
//  APPYSTORE
//
//  Created by ios_dev on 13/04/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit

class TagsCard: BaseCard {

    @IBOutlet weak var lblTag: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.clipsToBounds = true
        DimensionManager.setTextSize1280x720(label: lblTag, size: DimensionManager.H3)
    }

    override func fillCard(model: BaseModel) {
        let searchTagsModel = model as! SearchTagsModel
        
        lblTag.text = searchTagsModel.searchName
        
    }
    
    override func draw(_ rect: CGRect) {
        self.layer.cornerRadius = self.bounds.size.height / 2.0
    }
}
