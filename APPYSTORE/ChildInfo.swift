//
//  ChildInfo.swift
//  APPYSTORE
//
//  Created by gaurav on 13/03/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import Foundation

class ChildInfo: BaseModel{
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
    
}
