//
//  CustomUiSlider.swift
//  APPYSTORE
//
//  Created by ios_dev on 24/04/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import Foundation
import UIKit

class CustomUiSlider: UISlider {
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        let b1 = CGRect(origin: bounds.origin, size: CGSize(width: bounds.width, height: bounds.height/2))
        return b1
    }
}
