//
//  SearchResultParser.swift
//  APPYSTORE
//
//  Created by ios_dev on 11/04/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import Foundation
import SwiftyJSON

class SearchResultParser: BaseParser {
    
    private let  TOTAL_COUNT = "total_count";
    private let  RESPONSEDETAILS_ARRAY = "Responsedetails";
    private let  TITLE = "title";
    
    private let  CONTENT_ID = "content_id";
    private let  IMAGE_PATH = "image_path";
    private let  CONTENT_DURATION = "content_duration";
    private let  SUB_CATEGORY_ID = "sub_category_id";
    private let  SUB_CATEGORY_TITLE = "sub_category_title";
    private let  DOWNLOAD_URL = "dnld_url";
    private let  PARENT_CATEGORY_ID = "parent_category_id";
    private let  PAY_TYPE = "pay_type";
    private let  BUILD_ID = "build_id";
    private let  CONTENT_TYPE_ID = "content_type_id";
    private let  CONTENT_TYPE_LABLE = "content_type_lable";
    private let  SEQUENCE_TYPE = "sequence_type";
    private let  SEQUENCE_NUMBER = "sequence_number";
    private let  DATA_ARRAY = "data_array";
    private let  GROUP_ID = "group_id";
    private let  CDN_URL = "cdn_url";
    private let IS_VIDEO_DOWNLOADABLE = "video_streaming"
    
    private let  WORKSHEET_IDS = "worksheet_ids";
    private let  WORKSHEET_COUNT = "worksheet_count";
    private let  WORKSHEET_PROGRESS = "worksheet_progress";
    private let  WORKBOOK_RATING = "workbook_rating";
    
    private let  CONTENT_TYPE_VIDEO = "Video";
    private let  CONTENT_TYPE_WORKBOOK = "Workbook";
    
    override func parseJSONData(responseData: JSON) -> AnyObject? {
        
        let apiResponseModel = ContentListingApiResponseModel()
        //print("SearchResultParser parseJSONData : \(responseData)")
        
        for item in responseData.arrayValue {
            
            let videoContent = item[DATA_ARRAY].array
            
            var listingModelArray = [VideoListingModel]()
            for item in videoContent! {
                let contentTypeLabel = item[CONTENT_TYPE_LABLE].string!
                if(StringUtil.compareWithCase(firstString: contentTypeLabel, secondString: CONTENT_TYPE_VIDEO)) {
                    listingModelArray.append(fetchVideoList(item: item))
                } else {
                    //parse workbook model here
                }
            }
            
            apiResponseModel.contentList = listingModelArray
            apiResponseModel.totalCount = String(item[TOTAL_COUNT].int!)

        }
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
    
    func fetchVideoList(item: JSON) -> VideoListingModel {
        let videoListingModel = VideoListingModel();
        videoListingModel.contentId = String(item[CONTENT_ID].int!)
        videoListingModel.subCategoryTitle = item[SUB_CATEGORY_TITLE].string!
        videoListingModel.subCategoryId = item[SUB_CATEGORY_ID].string!
        videoListingModel.parentCategoryId = String(item[PARENT_CATEGORY_ID].int!)
        videoListingModel.payType = item[PAY_TYPE].string!
        videoListingModel.imagePath = item[IMAGE_PATH].string!
        videoListingModel.downloadUrl = item[DOWNLOAD_URL].string!
        videoListingModel.title = item[TITLE].string!
        videoListingModel.contentDuration = item[CONTENT_DURATION].string!
        videoListingModel.buildId = item[BUILD_ID].string!
        videoListingModel.sequenceType = item[SEQUENCE_TYPE].string!
        videoListingModel.sequenceNumber = String(item[SEQUENCE_NUMBER].int!)
        videoListingModel.contentTypeId = String(item[CONTENT_TYPE_ID].int!)
        videoListingModel.contentTypeLable = item[CONTENT_TYPE_LABLE].string!
        videoListingModel.groupId = item[GROUP_ID].string!
        videoListingModel.isVideoDownloadable = self.isDownloadable(value:  item[IS_VIDEO_DOWNLOADABLE].string!)
        return videoListingModel;
    }

    
}


