//
//  ChildInfo.swift
//  APPYSTORE
//
//  Created by gaurav on 13/03/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import Foundation

class ChildInfo: BaseModel, NSCopying, NSCoding{
    let CHILD_TYPE_SON = "son"
    let CHILD_TYPE_DAUGHTER = "daughter"
    var id: String?
    var type: String?
    var name: String?
    var dob: String?
    var avatarId: String?
    var age: String?
    var month: String?
    var avatarImage: String?
    var isInValidData = false
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(type, forKey: "type")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(dob, forKey: "dob")
        aCoder.encode(avatarId, forKey: "avatarId")
        aCoder.encode(age, forKey: "age")
        aCoder.encode(month, forKey: "month")
        aCoder.encode(avatarImage, forKey: "avatarImage")
        aCoder.encode(isInValidData, forKey: "isInValidData")
    }
    
    required init?(coder aDecoder: NSCoder) {
        id = aDecoder.decodeObject(forKey: "id") as? String
        type = aDecoder.decodeObject(forKey: "type") as? String
        name = aDecoder.decodeObject(forKey: "name") as? String
        dob = aDecoder.decodeObject(forKey: "dob") as? String
        avatarId = aDecoder.decodeObject(forKey: "avatarId") as? String
        age = aDecoder.decodeObject(forKey: "age") as? String
        month = aDecoder.decodeObject(forKey: "month") as? String
        avatarImage = aDecoder.decodeObject(forKey: "avatarImage") as? String
        isInValidData = aDecoder.decodeBool(forKey: "isInValidData")
        
        super.init()
    }
    
    override init() {
        super.init()
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        let childInfo = ChildInfo()
        childInfo.id = id
        childInfo.type = type
        childInfo.name = name
        childInfo.dob = dob
        childInfo.avatarId = avatarId
        childInfo.age = age
        childInfo.month = month
        childInfo.avatarImage = avatarImage
        childInfo.isInValidData = isInValidData
        
        return childInfo
    }
}
