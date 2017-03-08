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
    private static let CATEGORY_COUNT = "category_count";
    private static let CATEGORY_ID_ARRAY = "category_id_array";
    private static let CATEGORY_ID = "category_id";
    private static let CATEGORY_NAME = "category_name";
    private static let PARENT_CATEGORY_ID = "parent_category_id";
    private static let CONTENT_COUNT = "content_count";
    private static let IMAGE_PATH = "image_path";
    private static let IS_CATEGORY_BLOCKED = "is_category_blocked";
    private static let PARENT_CATEGORY_NAME = "parent_category_name";
    private static let CANONICAL_NAME = "canonical_name";
    private static let IS_VISIBLE = "is_visible";
    
    
    override func parseJSONData(responseData:JSON) -> [BaseModel]?{
        let videoCategoryContent = responseData["data_array"].array
        
        var videoCategoryModelArray = [VideoCategoryModel]()
        for item in videoCategoryContent!
        {
            let vc = VideoCategoryModel()
            vc.categoryId = String(item["category_id"].int!)
            vc.categoryName = item["category_name"].string!
            vc.contentCount = String(item["content_count"].int!)
            vc.imagePath = item["image_path"].string!
           
            videoCategoryModelArray.append(vc)
            
        }
        return videoCategoryModelArray
        
    }
}
