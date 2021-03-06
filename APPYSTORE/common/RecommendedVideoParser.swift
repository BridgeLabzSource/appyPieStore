//
//  RecommendedVideoParser.swift
//  APPYSTORE
//
//  Created by ios_dev on 12/04/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import Foundation
import SwiftyJSON

class RecommendedVideoParser: BaseParser {
    private let TOTAL_COUNT = "total_count"
    private let TITLE = "title"
    private let CONTENT_ID = "content_id"
    private let IMAGE_PATH = "image_path"
    private let CONTENT_DURATION = "content_duration"
    private let SUB_CATEGORY_ID = "sub_category_id"
    private let SUB_CATEGORY_TITLE = "sub_category_title"
    private let DNLD_URL = "dnld_url"
    private let PARENT_CATEGORY_ID = "title"
    private let PAY_TYPE = "pay_type"
    private let BUILD_ID = "build_id"
    private let CONTENT_TYPE_ID = "content_type_id"
    private let CONTENT_TYPE_LABLE = "content_type_lable"
    private let SEQUENCE_TYPE = "sequence_type"
    private let SEQUENCE_NUMBER = "sequence_number"
    private let DATA_ARRAY = "data_array"
    private let GROUP_ID = "group_id"
    
    override func parseJSONData(responseData: JSON) -> AnyObject? {
        let apiResponseModel = ContentListingApiResponseModel()
        let videoContent = responseData[0]["data_array"].array
        print("Response RecommendedVideoParser : \(responseData[0])")
        var listingModelArray = [VideoListingModel]()
        for item in videoContent! {
            
            let videoListingModel = VideoListingModel()
            videoListingModel.contentTypeLable = item[CONTENT_TYPE_LABLE].string!
            videoListingModel.contentId = String(item[CONTENT_ID].int!)
            videoListingModel.title = item[TITLE].string!
            videoListingModel.subCategoryTitle = item[SUB_CATEGORY_TITLE].string!
            videoListingModel.subCategoryId = item[SUB_CATEGORY_ID].string!
            videoListingModel.parentCategoryId = item[PARENT_CATEGORY_ID].string!
            videoListingModel.payType = item[PAY_TYPE].string!
            videoListingModel.imagePath = item[IMAGE_PATH].string!
            videoListingModel.downloadUrl = item[DNLD_URL].string!
            videoListingModel.contentDuration = item[CONTENT_DURATION].string!
            videoListingModel.buildId = item[BUILD_ID].string!
            videoListingModel.sequenceType = item[SEQUENCE_TYPE].string!
            videoListingModel.sequenceNumber = String(item[SEQUENCE_NUMBER].int!)
            videoListingModel.groupId = item[GROUP_ID].string!

            listingModelArray.append(videoListingModel)
        }
        
        apiResponseModel.contentList = listingModelArray
        apiResponseModel.totalCount = String(responseData[0]["total_count"].int!)
        
        return apiResponseModel as AnyObject
    }
}
