//
//  SearchTagsParser.swift
//  APPYSTORE
//
//  Created by ios_dev on 13/04/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import Foundation
import SwiftyJSON

class SearchTagsParser: BaseParser {
    
    private let SEARCH_NAME = "searchname"
    private let SEARCH_RANK = "searchrank"
    
    override func parseJSONData(responseData: JSON) -> AnyObject? {
        let apiResponseModel = ContentListingApiResponseModel()
        var searchTagsList = [SearchTagsModel]()
        for item in responseData.arrayValue {
            let tagsModel = SearchTagsModel()
            tagsModel.searchName = item[SEARCH_NAME].string!
            tagsModel.searchRank = item[SEARCH_RANK].string!
            searchTagsList.append(tagsModel)
        }
        apiResponseModel.contentList = searchTagsList
        apiResponseModel.totalCount = String(responseData.arrayValue.count)
        return apiResponseModel as AnyObject
    }
}
