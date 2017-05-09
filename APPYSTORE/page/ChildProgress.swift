//
//  ChildProgress.swift
//  APPYSTORE
//
//  Created by BridgeLabz on 05/05/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit

class ChildProgress: UICollectionViewCell {
    
    @IBOutlet weak var childimg: UIImageView!
    
    @IBOutlet weak var editImg: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //editImg.clipsToBounds = true
        
        childimg.layer.borderWidth = 5
        childimg.layer.borderColor = UIColor.white.cgColor
        editImg.layer.borderWidth = 5
        editImg.layer.borderColor = UIColor.white.cgColor
        
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        childimg.layer.cornerRadius = childimg.frame.width/2
        //childimg.clipsToBounds = true
        print("height = ",childimg.frame.height,"   width= ",childimg.frame.width)
        editImg.layer.cornerRadius = editImg.frame.height/2
    }
    
    
    }
