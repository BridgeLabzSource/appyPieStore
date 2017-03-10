//Purpose: parse the history data

import Foundation
import SwiftyJSON
class HistoryParser:BaseParser
{
    private static let TOTAL_COUNT = "total_count";
    private static let DATA_ARRAY = "data_array";
    private static let CONTENT_ID = "content_id";
    private static let IMAGE_PATH = "image_path";
    private static let TITLE = "title";
    private static let CONTENT_DURATION = "content_duration";
    private static let SUB_CATEGORY_ID = "sub_category_id";
    private static let SUB_CATEGORY_TITLE = "sub_category_title";
    private static let DNLD_URL = "dnld_url";
    private static let PARENT_CATEGORY_ID = "parent_category_id";
    private static let PAY_TYPE = "pay_type";
    private static let VERSION_ID = "version_id";
    private static let SEQUENCE_TYPE = "sequence_type";
    private static let SEQUENCE_NUMBER = "sequence_number";
    private static let CDN_URL = "cdn_url";
    private static let GROUP_ID = "group_id";
    
    override func parseJSONData(responseData:JSON) -> [BaseModel]?{
        let videoContent = responseData["data_array"].array
       
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
        return historyModelArray
        
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
