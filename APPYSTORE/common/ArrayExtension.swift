//
//  ArrayExtension.swift
//  APPYSTORE
//
//  Created by gaurav on 15/03/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import Foundation

extension Array where Element: NSCopying{
    func clone() -> Array{
        var copiedArray = Array<Element>()
        
        for element in self{
            copiedArray.append(element.copy(with: nil) as! Element)
        }
        
        return copiedArray
    }
}
