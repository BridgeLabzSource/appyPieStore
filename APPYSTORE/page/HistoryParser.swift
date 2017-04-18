//Purpose: parse the history data

import Foundation
import SwiftyJSON

class HistoryParser: BaseParser {
    
    private let TOTAL_COUNT = "total_count";
    private let DATA_ARRAY = "data_array";
    private let CONTENT_ID = "content_id";
    private let IMAGE_PATH = "image_path";
    private let TITLE = "title";
    private let CONTENT_DURATION = "content_duration";
    private let SUB_CATEGORY_ID = "sub_category_id";
    private let SUB_CATEGORY_TITLE = "sub_category_title";
    private let DOWNLOAD_URL = "dnld_url";
    private let PARENT_CATEGORY_ID = "parent_category_id";
    private let PAY_TYPE = "pay_type";
    private let VERSION_ID = "version_id";
    private let SEQUENCE_TYPE = "sequence_type";
    private let SEQUENCE_NUMBER = "sequence_number";
    private let CDN_URL = "cdn_url";
    private let GROUP_ID = "group_id";
    private let CANONICAL_NAME = "canonical_name"
    private let IS_VIDEO_DOWNLOADABLE = "video_streaming"
    
    override func parseJSONData(responseData:JSON) -> AnyObject? {
        //print("HistoryParser parseJSONData : \(responseData)")
        let apiResponseModel = ContentListingApiResponseModel()
        
        let videoContent = responseData[DATA_ARRAY].array
        
        var historyModelArray = [VideoListingModel]()
        for item in videoContent! {
            let videoListingModel = VideoListingModel()
            videoListingModel.canonicalName = item[CANONICAL_NAME].string!
            videoListingModel.sequenceNumber = String(item[SEQUENCE_NUMBER].int!)
            videoListingModel.downloadUrl = item[DOWNLOAD_URL].string!
            videoListingModel.subCategoryId = item[SUB_CATEGORY_ID].string!
            videoListingModel.contentId = String(item[CONTENT_ID].int!)
            videoListingModel.sequenceType = item[SEQUENCE_TYPE].string!
            videoListingModel.title = item[TITLE].string!
            videoListingModel.versionId = String(describing: item[VERSION_ID])
            videoListingModel.payType = item[PAY_TYPE].string!
            videoListingModel.imagePath = item[IMAGE_PATH].string!
            videoListingModel.subCategoryTitle = item[SUB_CATEGORY_TITLE].string!
            videoListingModel.parentCategoryId = String(item[PARENT_CATEGORY_ID].int!)
            
            videoListingModel.isVideoDownloadable = self.isDownloadable(value:  item[IS_VIDEO_DOWNLOADABLE].string!)
            
            historyModelArray.append(videoListingModel)
            
        }
        
        apiResponseModel.contentList = historyModelArray
        apiResponseModel.totalCount = responseData[TOTAL_COUNT].string!
        
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
