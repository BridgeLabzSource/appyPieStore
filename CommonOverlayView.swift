//
//  CommonOverlayView.swift
//  APPYSTORE
//
//  Created by BridgeLabz Solution LLP on 25/02/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit

class CommonOverlayView: UIView {

    
    @IBOutlet var fabButton: UIButton!
    
    @IBOutlet var commonOverlayView: UIView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        Bundle.main.loadNibNamed("CommonOverlayView", owner: self, options: nil)
        self.addSubview(commonOverlayView)
        
    }
   

}
