//
//  CustomFontStyle.swift
//  APPYSTORE
//
//  Created by BridgeLabz on 08/03/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit

extension UILabel {
        
    var defaultFontStyle : String {
        get {
            return self.font.fontName
        }
            
        set {
            self.font = UIFont(name: newValue, size: self.font.pointSize)
        }
    }
}
