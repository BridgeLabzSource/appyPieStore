//
//  AudioListingParser.swift
//  APPYSTORE
//
//  Created by BridgeLabz Solutions LLP  on 5/8/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import Foundation
import SwiftyJSON

class AudioListingParser: BaseParser {
    
    private let TOTAL_COUNT = "total_count"
    private let DATA_ARRAY = "data_array"
    private let CONTENT_ID = "content_id"
    private let IMAGE_PATH = "image_path"
    private let MIN_AGE = "min_age"
    private let MAX_AGE = "max_age"
    private let TITLE = "title"
    private let CONTENT_DURATION = "content_duration"
    private let SUB_CATEGORY_ID = "sub_category_id"
    private let SUB_CATEGORY_TITLE = "sub_category_title"
    private let DOWNLOAD_URL = "dnld_url"
    private let CDN_URL = "cdn_url"
    private let PARENT_CATEGORY_ID = "parent_category_id"
    private let PAY_TYPE = "pay_type"
    private let VERSION_ID = "version_id"
    private let SEQUENCE_TYPE = "sequence_type"
    private let SEQUENCE_NUMBER = "sequence_number"
    private let GROUP_ID = "group_id"
    private let IS_AUDIO_DOWNLOADABLE = "audio_streaming"
    
    override func parseJSONData(responseData:JSON) -> AnyObject? {
        
        let apiResponseModel = ContentListingApiResponseModel()
        
        let audioContent = responseData["data_array"].array
        
        var listingModelArray = [AudioListingModel]()
        
        for item in audioContent! {
            let audioListingModel = AudioListingModel()
            audioListingModel.groupId = item[GROUP_ID].string!
            audioListingModel.contentId = String(item[CONTENT_ID].int!)
            audioListingModel.imagePath = item[IMAGE_PATH].string!
            //audioListingModel.minAge = item[MIN_AGE].string!
            //audioListingModel.maxAge = item[MAX_AGE].string!
            audioListingModel.title = item[TITLE].string!
            audioListingModel.contentDuration = item[CONTENT_DURATION].string!
            audioListingModel.subCategoryId = item[SUB_CATEGORY_ID].string!
            audioListingModel.subCategoryTitle = item[SUB_CATEGORY_TITLE].string!
            audioListingModel.downloadUrl = item[DOWNLOAD_URL].string!
            //audioListingModel.cdnUrl = item[CDN_URL].string!
            audioListingModel.parentCategoryId = String(item[PARENT_CATEGORY_ID].int!)
            audioListingModel.payType = item[PAY_TYPE].string!
            audioListingModel.versionId = String(describing: item[VERSION_ID])
            audioListingModel.sequenceType = item[SEQUENCE_TYPE].string!
            audioListingModel.sequenceNumber = String(item[SEQUENCE_NUMBER].int!)
          //  audioListingModel.isAudioDownloadable = self.isDownloadable(value:  item[IS_AUDIO_DOWNLOADABLE].string!)
            
            listingModelArray.append(audioListingModel)
        }
        
        apiResponseModel.contentList = listingModelArray
        apiResponseModel.totalCount = String(responseData[TOTAL_COUNT].int!)
        
        return apiResponseModel as AnyObject
        
    }
    
    func isDownloadable(value:String) -> Bool
    {
        let result:ComparisonResult = value.caseInsensitiveCompare("Yes")
        if result == .orderedSame
        {
            return false
        }
        return true
    }
    
}
