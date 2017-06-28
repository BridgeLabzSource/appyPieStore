//
//  ChildProgressParser.swift
//  APPYSTORE
//
//  Created by BridgeLabz Solution LLP on 09/05/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import Foundation
import SwiftyJSON

class ChildProgressParser: BaseParser
{
    
    private let COUNT = "count";
    private let PARENT_CATEGORY_ID = "parent_category_id";
    private let PARENT_CATEGORY_NAME = "parent_category_name";
    private let CATEGORY_ID = "category_id";
    private let CATEGORY_NAME = "category_name";
    private let CONTENT_TYPE_ID = "content_type_id";
    private let CONTENT_TYPE_LABEL = "content_type_label";
    private let TRANS_COUNT = "trans_count";
    
    var childProgressApiResponseModel = ChildProgressApiResponseModel();
    var responseModelList = [ChildProgressApiResponseModel]()
   ///
    var apiResponseModel = ContentListingApiResponseModel()
    var avatarList = [ContentListingApiResponseModel]()
    ////
   override func parseJSONData(responseData:JSON) -> AnyObject{
    
    do
        {
            let responseDetail = responseData
            //let responseDetail = response?["Responsedetails"]?.dictionary
           // parseJsonAndUpdateResponseModelList(jsonObjectResponseDetails: responseDetail, key: ChildProgressModel.CONTENT_TYPE_AUDIO)
            parseJsonAndUpdateResponseModelList(jsonObjectResponseDetails: responseDetail, key: ChildProgressModel.CONTENT_TYPE_VIDEO)
            responseModelList.append(childProgressApiResponseModel)
          //  apiResponseModel.contentList = [ChildProgressApiResponseModel() as! BaseModel]
            avatarList.append(childProgressApiResponseModel as ContentListingApiResponseModel)
        }
    apiResponseModel.contentList = avatarList
    apiResponseModel.totalCount = String(responseData.arrayValue.count)
    return apiResponseModel as AnyObject
       // return responseModelList as AnyObject
    }
    
    func parseJsonAndUpdateResponseModelList(jsonObjectResponseDetails:JSON,key:String){
        let g = jsonObjectResponseDetails
        let f = g["videos"].array
        let jsonArray = f //jsonObjectResponseDetails[key].array
        if ((jsonArray?.count)! != 0 && (jsonArray?.count)! > 0){
            
            var childProgressModels = [BaseModel]()
            for i in stride(from: 0, to: (jsonArray?.count)! - 1 , by: 1)
            {
                    let performanceJsObj = jsonArray?[i].dictionary
                    let childProgressModel = ChildProgressModel()
                        childProgressModel.parent_category_id = (performanceJsObj?[PARENT_CATEGORY_ID]?.string)!
                        childProgressModel.parent_category_name = (performanceJsObj?[PARENT_CATEGORY_NAME]?.string)!
                        childProgressModel.category_id = (performanceJsObj?[CATEGORY_ID]?.string)!
                        childProgressModel.category_name = (performanceJsObj?[CATEGORY_NAME]?.string)!
                        let performanceCountArray = performanceJsObj?[COUNT]?.array
                    
                    if ((performanceCountArray?.count)! != 0 && (performanceCountArray?.count)! > 0){
                        let jsonObject = performanceCountArray?[0].dictionary
                        childProgressModel.content_type_id = (jsonObject?[CONTENT_TYPE_ID]?.string)!
                        childProgressModel.content_type_label = (jsonObject?[CONTENT_TYPE_LABEL]?.string)!
                        childProgressModel.trans_count = (jsonObject?[TRANS_COUNT]?.string)!
                    }
                    childProgressModels.append(childProgressModel)
            }
            if (ChildProgressModel.CONTENT_TYPE_AUDIO == key){
                childProgressApiResponseModel.audioList = childProgressModels
            }
            else if (ChildProgressModel.CONTENT_TYPE_VIDEO == key){
                childProgressApiResponseModel.videoList = childProgressModels as! [ChildProgressModel]
            }
            
        }
        
    }
    
    func getChildProgressModelList(performanceCountArray:JSON) ->[ChildProgressModel]{
        let countArray = performanceCountArray.array
        var childProgressModelList = [ChildProgressModel]()
        
        for i in stride(from: 0, to: (countArray?.count)!, by: 1){
            
           let performanceCountJsObj = countArray?[i].dictionary
           let childProgressModel = ChildProgressModel()
               childProgressModel.content_type_id = (performanceCountJsObj?[CONTENT_TYPE_ID]?.string)!
               childProgressModel.content_type_label = (performanceCountJsObj?[CONTENT_TYPE_LABEL]?.string)!
               childProgressModel.trans_count = (performanceCountJsObj?[TRANS_COUNT]?.string)!
            
          childProgressModelList.append(childProgressModel)
            
        }
        
        return childProgressModelList
        
    }
    
}
