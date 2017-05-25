//
//  UITextFieldExtension.swift
//  APPYSTORE
//
//  Created by ios_dev on 13/04/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit

extension UITextField {
    
    var defaultFontStyle : String {
        get {
            return self.font!.fontName
        }
        
        set {
            self.font = UIFont(name: newValue, size: (self.font?.pointSize)!)
        }
    }
}
