//
//  RecommendedAudioParser.swift
//  APPYSTORE
//
//  Created by BridgeLabz on 10/05/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import Foundation
import SwiftyJSON

class RecommendedAudioParser: BaseParser {
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
        let audioContent = responseData[0]["data_array"].array
        print("Response RecommendedAudioParser : \(responseData[0])")
        var listingModelArray = [AudioListingModel]()
        for item in audioContent! {
            
            let audioListingModel = AudioListingModel()
            audioListingModel.contentTypeLable = item[CONTENT_TYPE_LABLE].string!
            audioListingModel.contentId = String(item[CONTENT_ID].int!)
            audioListingModel.title = item[TITLE].string!
            audioListingModel.subCategoryTitle = item[SUB_CATEGORY_TITLE].string!
            audioListingModel.subCategoryId = item[SUB_CATEGORY_ID].string!
            audioListingModel.parentCategoryId = item[PARENT_CATEGORY_ID].string!
            audioListingModel.payType = item[PAY_TYPE].string!
            audioListingModel.imagePath = item[IMAGE_PATH].string!
            audioListingModel.downloadUrl = item[DNLD_URL].string!
            audioListingModel.contentDuration = item[CONTENT_DURATION].string!
            audioListingModel.buildId = item[BUILD_ID].string!
            audioListingModel.sequenceType = item[SEQUENCE_TYPE].string!
            audioListingModel.sequenceNumber = String(item[SEQUENCE_NUMBER].int!)
            audioListingModel.groupId = item[GROUP_ID].string!
            
            listingModelArray.append(audioListingModel)
        }
        
        apiResponseModel.contentList = listingModelArray
        apiResponseModel.totalCount = String(responseData[0]["total_count"].int!)
        
        return apiResponseModel as AnyObject
    }
}
