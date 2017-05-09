//
//  AvatarParser.swift
//  APPYSTORE
//
//  Created by ios_dev on 21/04/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//
import SwiftyJSON

class AvatarParser: BaseParser {
    static let METHOD_NAME = "getAvatarList"
    private let AVATAR_ID = "avatarID"
    private let AVATAR_IMAGE = "avatarIMG"
    
    override func parseJSONData(responseData: JSON) -> AnyObject? {
        let apiResponseModel = ContentListingApiResponseModel()
        var avatarList = [AvatarModel]()
        for item in responseData.arrayValue {
            let avatarModel = AvatarModel()
            avatarModel.id = String(item[AVATAR_ID].int!)
            avatarModel.imagePath = item[AVATAR_IMAGE].string!
            avatarList.append(avatarModel)
        }
        apiResponseModel.contentList = avatarList
        apiResponseModel.totalCount = String(responseData.arrayValue.count)
        return apiResponseModel as AnyObject
    }
    
}
