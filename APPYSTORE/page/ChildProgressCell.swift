//
//  ChildProgressCell.swift
//  
//
//  Created by BridgeLabz on 04/05/17.
//
//

import UIKit

class ChildProgressCell: BaseCard{
    

    @IBOutlet weak var ChildProgressWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var topPB: UIView!
    @IBOutlet weak var buttomPB: UIView!
    
    @IBOutlet var categoryNameLabel: UILabel!
    
    @IBOutlet var transCountLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func fillCard(model: BaseModel) {
        let childProgressModel = model as! ChildProgressModel
            categoryNameLabel.text  = childProgressModel.content_type_label
            transCountLabel.text = childProgressModel.trans_count
            let progressValue = CGFloat(Int(childProgressModel.trans_count)!)
            let value = buttomPB.frame.size.width/100
            ChildProgressWidthConstraint.constant = progressValue * value
    }
    
}
