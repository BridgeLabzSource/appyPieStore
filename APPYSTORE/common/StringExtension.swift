//
//  StringExtension.swift
//  APPYSTORE
//
//  Created by BridgeLabz on 02/03/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func substring(from: Int?, to: Int?) -> String {
        if let start = from {
            guard start < self.characters.count else {
                return ""
            }
        }
        
        if let end = to {
            guard end >= 0 else {
                return ""
            }
        }
        
        if let start = from, let end = to {
            guard end - start >= 0 else {
                return ""
            }
        }
        
        let startIndex: String.Index
        if let start = from, start >= 0 {
            startIndex = self.index(self.startIndex, offsetBy: start)
        } else {
            startIndex = self.startIndex
        }
        
        let endIndex: String.Index
        if let end = to, end >= 0, end < self.characters.count {
            endIndex = self.index(self.startIndex, offsetBy: end + 1)
        } else {
            endIndex = self.endIndex
        }
        
        return self[startIndex ..< endIndex]
    }
    
    func substring(from: Int) -> String {
        return self.substring(from: from, to: nil)
    }
    
    func substring(to: Int) -> String {
        return self.substring(from: nil, to: to)
    }
    
    func substring(from: Int?, length: Int) -> String {
        guard length > 0 else {
            return ""
        }
        
        let end: Int
        if let start = from, start > 0 {
            end = start + length - 1
        } else {
            end = length - 1
        }
        
        return self.substring(from: from, to: end)
    }
    
    func substring(length: Int, to: Int?) -> String {
        guard let end = to, end > 0, length > 0 else {
            return ""
        }
        
        let start: Int
        if let end = to, end - length > 0 {
            start = end - length + 1
        } else {
            start = 0
        }
        
        return self.substring(from: start, to: to)
    }
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSFontAttributeName: font]
        let size = self.size(attributes: fontAttributes)
        return size.width
    }
    
    func heightOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSFontAttributeName: font]
        let size = self.size(attributes: fontAttributes)
        return size.height
    }
    
    func getApproxWidth(size: CGFloat) -> CGFloat {
        
        var width: CGFloat = 0
        for char in self.characters {
            switch char {
            case "f", "i", "I", "j", "J", "l", "r", "t":
                width += size / 2
            case "m", "w",
                "A", "B", "C", "D", "E", "F", "G", "H", "K", "L",
                "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z":
                width += size
            default:
                width += (size * 0.8)
            }
        }
        
        return width
    }
    
    func formatDate(originalFormat: String, destinationFormat: String) -> String! {
        
        // Orginal format :
        let dateOriginalFormat = DateFormatter()
        dateOriginalFormat.dateFormat = originalFormat
        
        // Destination format :
        let dateDestinationFormat = DateFormatter()
        dateDestinationFormat.dateFormat = destinationFormat
        
        // Convert current String Date to NSDate
        let dateFromString = dateOriginalFormat.date(from: self)
        
        // Convert new NSDate created above to String with the good format
        let dateFormated = dateDestinationFormat.string(from: dateFromString!)
        
        return dateFormated
        
    }

}
