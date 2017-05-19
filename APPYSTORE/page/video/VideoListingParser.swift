//
//  VideoListingParser.swift
//  APPYSTORE
//
//  Created by ios_dev on 04/04/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//


import Foundation
import SwiftyJSON

class VideoListingParser: BaseParser {
    
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
    private let IS_VIDEO_DOWNLOADABLE = "video_streaming"
    
    override func parseJSONData(responseData:JSON) -> AnyObject? {
        
        let apiResponseModel = ContentListingApiResponseModel()
        
        let videoContent = responseData["data_array"].array
        
        var listingModelArray = [VideoListingModel]()
        for item in videoContent! {
            let videoListingModel = VideoListingModel()
            videoListingModel.groupId = item[GROUP_ID].string!
            videoListingModel.contentId = String(item[CONTENT_ID].int!)
            videoListingModel.imagePath = item[IMAGE_PATH].string!
            //videoListingModel.minAge = item[MIN_AGE].string!
            //videoListingModel.maxAge = item[MAX_AGE].string!
            videoListingModel.title = item[TITLE].string!
            videoListingModel.contentDuration = item[CONTENT_DURATION].string!
            videoListingModel.subCategoryId = item[SUB_CATEGORY_ID].string!
            videoListingModel.subCategoryTitle = item[SUB_CATEGORY_TITLE].string!
            videoListingModel.downloadUrl = item[DOWNLOAD_URL].string!
            //videoListingModel.cdnUrl = item[CDN_URL].string!
            videoListingModel.parentCategoryId = String(item[PARENT_CATEGORY_ID].int!)
            videoListingModel.payType = item[PAY_TYPE].string!
            videoListingModel.versionId = String(describing: item[VERSION_ID])
            videoListingModel.sequenceType = item[SEQUENCE_TYPE].string!
            videoListingModel.sequenceNumber = String(item[SEQUENCE_NUMBER].int!)
            videoListingModel.isVideoDownloadable = self.isDownloadable(value:  item[IS_VIDEO_DOWNLOADABLE].string!)
            
            listingModelArray.append(videoListingModel)
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

