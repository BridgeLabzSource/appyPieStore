//
//  StringUtil.swift
//  APPYSTORE
//
//  Created by gaurav on 13/03/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import Foundation

class StringUtil{
    
    static func isEmptyOrNullString(stringToCheck: String?) -> Bool {
        if let value = stringToCheck{
            if !value.isEmpty && !( compareIgnoreCase(firstString: value, secondString: "null")){
                return false
            }
        }
        
        return true
    }
    
    
    static func compareIgnoreCase(firstString : String?, secondString: String?) -> Bool{
        
        if firstString != nil && secondString != nil {
            
            if firstString?.caseInsensitiveCompare(secondString!) == ComparisonResult.orderedSame{
                return true
            }
        }
        
        
        return false
    }
    
    static func compareWithCase(firstString: String, secondString: String) -> Bool{
        
        if firstString.compare(secondString) == ComparisonResult.orderedSame {
            return true
        }
        
        return false
    }
}
