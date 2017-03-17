//
//  VideoCategoryParser.swift
//  APPYSTORE
//
//  Created by BridgeLabz on 07/03/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import Foundation
import SwiftyJSON

class VideoCategoryParser<T: ParserListener>: BaseParser<T>
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
    
    
    override func parseJSONData(responseData:JSON) -> AnyObject?{
        let videoCategoryContent = responseData["category_id_array"].array
        
        var videoCategoryModelArray = [VideoCategoryModel]()
        for item in videoCategoryContent!
        {
            let vc = VideoCategoryModel()
            vc.categoryId = item["category_id"].string!
            vc.categoryName = item["category_name"].string!
            vc.contentCount = String(item["content_count"].int!)
            let tempImgPath = item["image_path"].dictionary!
            vc.imagePath = (tempImgPath["50x50"]?.string!)!
           
            videoCategoryModelArray.append(vc)
            
        }
        return videoCategoryModelArray as AnyObject
        
    }
}
