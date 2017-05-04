//
//  MyCustomSlider.swift
//  APPYSTORE
//
//  Created by BridgeLabz Solutions LLP  on 5/4/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import Foundation
import UIKit

class MyCustomSlider: UISlider
{
    @IBInspectable var trackHeight: CGFloat = 2
    
     func trackRectForBounds(bounds: CGRect) -> CGRect
     {
        //set your bounds here
        return CGRect(origin: bounds.origin, size: CGSize(width:bounds.width,height: trackHeight))
    }
}
