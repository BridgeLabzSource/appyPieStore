//
//  ChildRegistrationParser.swift
//  APPYSTORE
//
//  Created by ios_dev on 24/04/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit
import SwiftyJSON

class ChildRegistrationParser: BaseParser {
    static let METHOD_NAME = "register"
    
    private let USER_ID = "UserId"
    
    private let CHILD_LIST = "childlist"
    private let CHILD_ID = "childId"
    private let DOB = "dob"
    private let AGE = "age"
    private let MONTH = "ageMonth"
    private let CHILD_TYPE = "childType"
    private let CHILD_NAME = "childName"
    private let AVATAR_ID = "avatarId"
    private let AVATAR_IMG = "avatarIMG"
    
    //this api response is not well formed. The required data is not present in "Responsedetails" key, hence overriding
    override func getResponseData(wholeData: JSON, responseDetail: JSON) -> AnyObject? {
        return parseJSONData(responseData: wholeData)
    }
    
    override func parseJSONData(responseData: JSON) -> AnyObject? {
        let registerApiResponseModel = RegisterApiResponseModel()
        
        var childList = [ChildInfo]()
        for item in responseData[CHILD_LIST].arrayValue {
            let child = ChildInfo()
            
            child.id = item[CHILD_ID].string!
            child.type = item[CHILD_TYPE].string!
            child.name = item[CHILD_NAME].string!
            child.dob = item[DOB].string!
            child.avatarId = item[AVATAR_ID].string!
            child.avatarImage = item[AVATAR_IMG].string!
            child.age = item[AGE].string!
            child.month = item[MONTH].string!
            
            childList.append(child)
        }
        
        registerApiResponseModel.childInfoList = childList
        registerApiResponseModel.userId = responseData[USER_ID].string!
        return registerApiResponseModel as AnyObject
    }
}
