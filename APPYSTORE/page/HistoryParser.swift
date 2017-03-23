//Purpose: parse the history data

import Foundation
import SwiftyJSON
var total_history_count:Int?

class HistoryParser: BaseParser {
    
    private let TOTAL_COUNT = "total_count";
    private let DATA_ARRAY = "data_array";
    private let CONTENT_ID = "content_id";
    private let IMAGE_PATH = "image_path";
    private let TITLE = "title";
    private let CONTENT_DURATION = "content_duration";
    private let SUB_CATEGORY_ID = "sub_category_id";
    private let SUB_CATEGORY_TITLE = "sub_category_title";
    private let DNLD_URL = "dnld_url";
    private let PARENT_CATEGORY_ID = "parent_category_id";
    private let PAY_TYPE = "pay_type";
    private let VERSION_ID = "version_id";
    private let SEQUENCE_TYPE = "sequence_type";
    private let SEQUENCE_NUMBER = "sequence_number";
    private let CDN_URL = "cdn_url";
    private let GROUP_ID = "group_id";
    
    override func parseJSONData(responseData:JSON) -> AnyObject? {
        
        let apiResponseModel = ContentListingApiResponseModel()
        
        let videoContent = responseData["data_array"].array
        total_history_count = Int((videoContent?.count)!)
        
        var historyModelArray = [VideoListingModel]()
        for item in videoContent! {
            let videoListingModel = VideoListingModel()
            videoListingModel.canonicalName = item["canonical_name"].string!
            videoListingModel.sequenceNumber = String(item["sequence_number"].int!)
            videoListingModel.downloadUrl = item["dnld_url"].string!
            videoListingModel.subCategoryId = item["sub_category_id"].string!
            videoListingModel.contentId = String(item["content_id"].int!)
            videoListingModel.sequenceType = item["sequence_type"].string!
            videoListingModel.title = item["title"].string!
            videoListingModel.versionId = String(describing: item["version_id"])
            videoListingModel.canonicalName = item["canonical_name"].string!
            videoListingModel.payType = item["pay_type"].string!
            videoListingModel.imagePath = item["image_path"].string!
            videoListingModel.subCategoryTitle = item["sub_category_title"].string!
            videoListingModel.parentCategoryId = String(item["parent_category_id"].int!)

            videoListingModel.isVideoDownloadable = self.isDownloadable(value:  item["video_streaming"].string!)

            historyModelArray.append(videoListingModel)
            
        }
        
        apiResponseModel.contentList = historyModelArray
        apiResponseModel.totalCount = responseData["total_count"].string!
        
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
