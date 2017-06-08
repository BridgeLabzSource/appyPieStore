//
//  File.swift
//  APPYSTORE
//
//  Created by BridgeLabz on 01/03/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    convenience init(hex: String) {
        var hexString = hex
        var alpha: UInt8 = 255
        let hexLength = hexString.characters.count
        if !(hexLength == 7 || hexLength == 9) {
            print("improper call to 'init', hex length must be 7 or 9 chars (#AARRGGBB)")
            self.init(white: 0, alpha: 1)
            return
        }
        
        if hexLength == 9 {
            alpha = UInt8(hexString.substring(from: 1, to: 2), radix: 16)!
            hexString = hexString.substring(from: 3)
        }else{
            hexString = hexString.substring(from: 1)
        }
        
        // Establishing the rgb color
        var rgb: UInt32 = 0
        let s: Scanner = Scanner(string: hexString)
        // Setting the scan location to ignore the leading `#`
        s.scanLocation = 0
        // Scanning the int into the rgb colors
        s.scanHexInt32(&rgb)
        
        // Creating the UIColor from hex int
        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF >> 0) / 255.0,
            alpha: CGFloat(alpha) / 255.0
        )
    }
}
