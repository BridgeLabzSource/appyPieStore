//
//  VideoCategoryParser.swift
//  APPYSTORE
//
//  Created by BridgeLabz on 07/03/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import Foundation
import SwiftyJSON

class VideoCategoryParser: BaseParser
{
    private let CATEGORY_COUNT = "category_count";
    private let CATEGORY_ID_ARRAY = "category_id_array";
    private let CATEGORY_ID = "category_id";
    private let CATEGORY_NAME = "category_name";
    private let PARENT_CATEGORY_ID = "parent_category_id";
    private let CONTENT_COUNT = "content_count";
    private let IMAGE_PATH = "image_path";
    private let IS_CATEGORY_BLOCKED = "is_category_blocked";
    private let PARENT_CATEGORY_NAME = "parent_category_name";
    private let CANONICAL_NAME = "canonical_name";
    private let IS_VISIBLE = "is_visible";
    
    override func parseJSONData(responseData:JSON) -> AnyObject? {
        
        let apiResponseModel = ContentListingApiResponseModel()
        let videoContent = responseData[CATEGORY_ID_ARRAY].array
        
        var videoCategoryModelArray = [VideoCategoryModel]()
        
        for item in videoContent! {
            let videoCategoryModel = VideoCategoryModel()
            videoCategoryModel.categoryId = item[CATEGORY_ID].string!
            videoCategoryModel.categoryName = item[CATEGORY_NAME].string!
            videoCategoryModel.parentCategoryId = item[PARENT_CATEGORY_ID].string!
            videoCategoryModel.contentCount = String(item[CONTENT_COUNT].int!)
            videoCategoryModel.isCategoryBlocked = String(item[IS_CATEGORY_BLOCKED].int!)
            videoCategoryModel.parentCategoryName = item[PARENT_CATEGORY_NAME].string!
            videoCategoryModel.canonicalName = item[CANONICAL_NAME].string!
            videoCategoryModel.isVisible = String(item[IS_VISIBLE].int!)
            
            let tempImgPath = item[IMAGE_PATH].dictionary!
            videoCategoryModel.imagePath = (tempImgPath["50x50"]?.string!)!
           
            videoCategoryModelArray.append(videoCategoryModel)
        }
        
        apiResponseModel.contentList = videoCategoryModelArray
        apiResponseModel.totalCount = String(describing: responseData[CATEGORY_COUNT])
        return apiResponseModel
        
    }
}
