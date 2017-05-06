//
//  AudioCategoryParser.swift
//  APPYSTORE
//
//  Created by BridgeLabz Solutions LLP  on 5/5/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import Foundation
import SwiftyJSON

class AudioCategoryParser: BaseParser
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
        let audioContent = responseData[CATEGORY_ID_ARRAY].array
        
        var audioCategoryModelArray = [AudioCategoryModel]()
        
        for item in audioContent! {
            let audioCategoryModel = AudioCategoryModel()
            audioCategoryModel.categoryId = item[CATEGORY_ID].string!
            audioCategoryModel.categoryName = item[CATEGORY_NAME].string!
            audioCategoryModel.parentCategoryId = item[PARENT_CATEGORY_ID].string!
            audioCategoryModel.contentCount = String(item[CONTENT_COUNT].int!)
            audioCategoryModel.isCategoryBlocked = String(item[IS_CATEGORY_BLOCKED].int!)
            audioCategoryModel.parentCategoryName = item[PARENT_CATEGORY_NAME].string!
            audioCategoryModel.canonicalName = item[CANONICAL_NAME].string!
            audioCategoryModel.isVisible = String(item[IS_VISIBLE].int!)
            
            let tempImgPath = item[IMAGE_PATH].dictionary!
            audioCategoryModel.imagePath = (tempImgPath["50x50"]?.string!)!
            
            audioCategoryModelArray.append(audioCategoryModel)
        }
        
        apiResponseModel.contentList = audioCategoryModelArray
        apiResponseModel.totalCount = String(describing: responseData[CATEGORY_COUNT])
        return apiResponseModel
        
    }
}
