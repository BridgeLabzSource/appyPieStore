//
//  UITextViewExtension.swift
//  APPYSTORE
//
//  Created by ios_dev on 04/05/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit

extension UITextView {
    
    var defaultFontStyle : String {
        get {
            return self.font!.fontName
        }
        
        set {
            self.font = UIFont(name: newValue, size: (self.font?.pointSize)!)
        }
    }
}
