//
//  RegisterApiResponseModel.swift
//  APPYSTORE
//
//  Created by ios_dev on 24/04/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import Foundation

class RegisterApiResponseModel: BaseModel {
    var userId = ""
    var childInfoList: [ChildInfo]? = []
}
