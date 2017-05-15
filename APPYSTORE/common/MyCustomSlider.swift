//
//  MyCustomSlider.swift
//  APPYSTORE
//
//  Created by BridgeLabz Solutions LLP  on 5/4/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import Foundation
import UIKit

class MyCustomSlider: CustomUiSlider
{
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        let b1 = CGRect(origin: bounds.origin, size: CGSize(width: bounds.width, height: bounds.height))
        
        return b1
    }
}
