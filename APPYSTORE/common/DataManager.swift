// get and store data

import Foundation

class DataManager: NSObject {
    
    static let sharedInstance = DataManager()
    
    private override init() {
        
    }
    
    func getData(pageName: String, offset: Int, limit: Int, bundle: AndroidBundle,
                 returndata: @escaping (_ statusType: String, _ result:AnyObject) -> Void ) {
        
        switch pageName {
        case PageConstants.HISTORY_PAGE:
            HistoryParser().parse(params: HttpRequestBuilder.getHistoryParameters(offset: String(offset), limit: String(limit)), completion:{
                statusType, result in
                
                returndata(statusType, result!)
            })
            
        case PageConstants.VIDEO_CATEGORY_PAGE:
            VideoCategoryParser().parse(params: HttpRequestBuilder.getVideoCategoryParameters(), completion:{
                statusType, result in
                
                returndata(statusType, result!)
            })
            
        case PageConstants.VIDEO_LISTING_PAGE:
            VideoListingParser().parse(params: HttpRequestBuilder.getVideoListingParameters(offset: String(offset), limit: String(limit), catId: bundle?[BundleConstants.CATEGORY_ID] as! String, pCatId: bundle?[BundleConstants.PARENT_CATEGORY_ID] as! String), completion:{
                statusType, result in
                
                returndata(statusType, result!)
            })
            
            
        case PageConstants.RECOMMENDED_VIDEO_LISTING_PAGE:
            print("Recommended data \(bundle?.count)")
            print("Recommended data \(bundle?.keys)")
            print("Recommended data \(bundle?.values)")
            RecommendedVideoParser().parse(params: HttpRequestBuilder.getRecommendedVideoListingParameters(offset: String(offset), limit: String(limit), catId: bundle?[BundleConstants.CATEGORY_ID] as! String, pCatId: bundle?[BundleConstants.PARENT_CATEGORY_ID] as! String, contentId: bundle?[BundleConstants.CONTENT_ID] as! String, sequenceType: bundle?[BundleConstants.SEQUENCE_TYPE] as! String, sequenceNumber: bundle?[BundleConstants.SEQUENCE_NUMBER] as! String,lastContentId: bundle?[BundleConstants.LAST_CONTENT_ID] as? String ?? ""), completion: {
                statusType, result in
                
                returndata(statusType, result!)
            })
            
            
        case PageConstants.SEARCH_RESULT_PAGE:
            SearchResultParser().parse(params: HttpRequestBuilder.getSearchResultParameters(keyword: bundle?[BundleConstants.SEARCH_KEYWORD] as! String, offset: String(offset), limit: String(limit), ignoreCatId: "", isPopular: "0"), completion: {
                statusType, result in
                
                returndata(statusType, result!)
            })
        case PageConstants.SEARCH_TAGS_PAGE:
            SearchTagsParser().parse(params: HttpRequestBuilder.getSearchTagsParameters(), completion: {
                statusType, result in
                
                returndata(statusType, result!)
            })
        case PageConstants.SELECT_AVATAR_PAGE_NEW:
            fallthrough
        case PageConstants.SELECT_AVATAR_PAGE_ADD:
            fallthrough
        case PageConstants.SELECT_AVATAR_PAGE_EDIT:
            AvatarParser().parse(params: HttpRequestBuilder.getAvatarParameters(), completion: {
                statusType, result in
                
                returndata(statusType, result!)
            })
            ////added
        case PageConstants.CHILD_SELECTION_PAGE:
            //NA
            break
          /*  ChildProgressParser().parse(params:HttpRequestBuilder.getChildProgressParams(method: "getChildPerformance", childId: "29518", pageId: "ChildPerformance"), completion:{
            statusType, result in
            
            returndata(statusType, result!)
        })
          */////testing..
        case PageConstants.SELECT_CHILD_PROGRESS_PAGE:
           let selectedChild = UserInfo.getInstance().selectedChild
           
            ChildProgressParser().parse(params:HttpRequestBuilder.getChildProgressParams(method: "getChildPerformance", childId: (selectedChild?.id!)!, pageId: "childPerformance"), completion:{
                statusType, result in
                
                returndata(statusType, result!)
            })
            
        /////////
        case PageConstants.SELECT_CHILD_LIST_PAGE:
            
            returndata(BaseParser.REQUEST_SUCCESS, UserInfo.getInstance().childList as AnyObject)
            ///
        default:
            break
        }
    }
    
    func getLocalData(pageName: String, offset: Int, limit: Int, bundle: AndroidBundle, completion: @escaping ([BaseModel]?) -> Void ) {
        var dataList: [BaseModel]?
        
        switch pageName {
        case PageConstants.HISTORY_PAGE:
            dataList = HistoryDBManager.sharedInstance.fetchDataWithLimit(childId: "29518", offset: offset, limit: limit, bundle: nil)
            
        case PageConstants.VIDEO_CATEGORY_PAGE:
            dataList = VideoDBManager.sharedInstance.fetchAll()
            
        case PageConstants.VIDEO_LISTING_PAGE:
            dataList = VideoListingDBManager.sharedInstance.fetchDataWithLimit(childId: "29518", offset: offset, limit: limit, bundle: bundle)
        case PageConstants.SEARCH_TAGS_PAGE:
            dataList = Prefs.getInstance()?.getSearchTags()
        case PageConstants.SELECT_AVATAR_PAGE_NEW:
            fallthrough
        case PageConstants.SELECT_AVATAR_PAGE_ADD:
            fallthrough
        case PageConstants.SELECT_AVATAR_PAGE_EDIT:
            dataList = AvatarDBManager.sharedInstance.fetchAll()
        case PageConstants.CHILD_SELECTION_PAGE:
            dataList = UserInfo.getInstance().childList
        case PageConstants.SELECT_CHILD_LIST_PAGE:
            dataList = UserInfo.getInstance().childList
            break
        default:
            break
        }
        
        completion(dataList)
    }
    
    func getRowCountForPage(pageName: String, bundle: AndroidBundle) -> Int {
        var count: Int = -1
        switch pageName {
        case PageConstants.HISTORY_PAGE:
            count = HistoryDBManager.sharedInstance.getRowCount(bundle: bundle)
        case PageConstants.VIDEO_CATEGORY_PAGE:
            count = VideoDBManager.sharedInstance.getRowCount(bundle: bundle)
        case PageConstants.VIDEO_LISTING_PAGE:
            count = VideoListingDBManager.sharedInstance.getRowCount(bundle: bundle)
        case PageConstants.SEARCH_TAGS_PAGE:
            let tagsList = Prefs.getInstance()?.getSearchTags()
            count = tagsList?.count ?? 0
        case PageConstants.SELECT_AVATAR_PAGE_NEW:
            fallthrough
        case PageConstants.SELECT_AVATAR_PAGE_ADD:
            fallthrough
        case PageConstants.SELECT_AVATAR_PAGE_EDIT:
            count = AvatarDBManager.sharedInstance.getRowCount(bundle: bundle)
        case PageConstants.CHILD_SELECTION_PAGE:
            count = UserInfo.getInstance().childList.count
        case PageConstants.SELECT_CHILD_LIST_PAGE:
            count = UserInfo.getInstance().childList.count
            ///////testing...
        case PageConstants.SELECT_CHILD_PROGRESS_PAGE:
             print("SELECT_CHILD_PROGRESS_PAG")
            break
        default:
            break
        }
        
        return count
    }
    
    func deleteDataForPage(pageName: String, bundle: AndroidBundle) {
        switch pageName {
        case PageConstants.HISTORY_PAGE:
            HistoryDBManager.sharedInstance.clearTable(bundle: bundle)
        case PageConstants.VIDEO_CATEGORY_PAGE:
            VideoDBManager.sharedInstance.clearTable(bundle: bundle)
        case PageConstants.VIDEO_LISTING_PAGE:
            VideoListingDBManager.sharedInstance.clearTable(bundle: bundle)
        case PageConstants.SEARCH_TAGS_PAGE:
            Prefs.getInstance()?.setSearchTags(value: [])
        case PageConstants.SELECT_AVATAR_PAGE_NEW:
            fallthrough
        case PageConstants.SELECT_AVATAR_PAGE_ADD:
            fallthrough
        case PageConstants.SELECT_AVATAR_PAGE_EDIT:
            AvatarDBManager.sharedInstance.clearTable(bundle: bundle)
        case PageConstants.CHILD_SELECTION_PAGE:
            //NA
            break
        default:
            break
        }
    }
    
    func saveDataForPage(pageName: String, dataList: [BaseModel]) ->Int {
        var count = -1
        
        switch pageName {
        case PageConstants.HISTORY_PAGE:
            count = HistoryDBManager.sharedInstance.insertBulkRecords(userId: "107105246", childId: "29518", modelList: dataList)!
        case PageConstants.VIDEO_CATEGORY_PAGE:
            count = VideoDBManager.sharedInstance.insertBulkRecords(userId: "107105246", childId: "29518", modelList: dataList)!
        case PageConstants.VIDEO_LISTING_PAGE:
            count = VideoListingDBManager.sharedInstance.insertBulkRecords(userId: "107105246", childId: "29518", modelList: dataList)!
        case PageConstants.SEARCH_TAGS_PAGE:
            Prefs.getInstance()?.setSearchTags(value: dataList as! [SearchTagsModel])
            count = 1
        case PageConstants.SELECT_AVATAR_PAGE_NEW:
            fallthrough
        case PageConstants.SELECT_AVATAR_PAGE_ADD:
            fallthrough
        case PageConstants.SELECT_AVATAR_PAGE_EDIT:
            count = AvatarDBManager.sharedInstance.insertBulkRecords(userId: UserInfo.getInstance().id, childId: UserInfo.getInstance().selectedChild?.id, modelList: dataList)!
        case PageConstants.CHILD_SELECTION_PAGE:
            //NA
            break
        default:
            break
        }
        
        print(" \(count) records inserted succesfully... \(pageName) ")
        return count
    }
    
    static func getDataFetchTimePrefKey(pageName: String, pageUniqueId: String) -> String? {
        var dataFetchTimePrefKey: String? = nil
        switch pageName {
        case PageConstants.HISTORY_PAGE:
            dataFetchTimePrefKey = PageConstants.KEY_HISTORY_DATA_FETCH_TIME + pageUniqueId
        case PageConstants.VIDEO_CATEGORY_PAGE:
            dataFetchTimePrefKey = PageConstants.KEY_VIDEO_CATEGORY_DATA_FETCH_TIME + pageUniqueId
        case PageConstants.VIDEO_LISTING_PAGE:
            dataFetchTimePrefKey = PageConstants.KEY_VIDEO_LISTING_DATA_FETCH_TIME + pageUniqueId
        case PageConstants.SEARCH_TAGS_PAGE:
            dataFetchTimePrefKey = PageConstants.KEY_SEARCH_TAGS_DATA_FETCH_TIME + pageUniqueId
        case PageConstants.SELECT_AVATAR_PAGE_NEW:
            fallthrough
        case PageConstants.SELECT_AVATAR_PAGE_ADD:
            fallthrough
        case PageConstants.SELECT_AVATAR_PAGE_EDIT:
            dataFetchTimePrefKey = PageConstants.KEY_SELECT_AVATAR_DATA_FETCH_TIME + pageUniqueId
        case PageConstants.CHILD_SELECTION_PAGE:
            //NA
            break
        default:
            break
        }
        
        return dataFetchTimePrefKey
    }
    
    static func getOffsetServerPrefKey(pageName: String, pageUniqueId: String) -> String? {
        var offsetServerPrefKey: String? = nil
        switch pageName {
        case PageConstants.HISTORY_PAGE:
            offsetServerPrefKey = PageConstants.KEY_HISTORY_SERVER_OFFSET + pageUniqueId
        case PageConstants.VIDEO_CATEGORY_PAGE:
            offsetServerPrefKey = PageConstants.KEY_VIDEO_CATEGORY_SERVER_OFFSET + pageUniqueId
        case PageConstants.VIDEO_LISTING_PAGE:
            offsetServerPrefKey = PageConstants.KEY_VIDEO_LISTING_SERVER_OFFSET + pageUniqueId
        case PageConstants.SEARCH_TAGS_PAGE:
            offsetServerPrefKey = PageConstants.KEY_SEARCH_TAGS_SERVER_OFFSET + pageUniqueId
        case PageConstants.SELECT_AVATAR_PAGE_NEW:
            fallthrough
        case PageConstants.SELECT_AVATAR_PAGE_ADD:
            fallthrough
        case PageConstants.SELECT_AVATAR_PAGE_EDIT:
            offsetServerPrefKey = PageConstants.KEY_SELECT_AVATAR_SERVER_OFFSET + pageUniqueId
        case PageConstants.CHILD_SELECTION_PAGE:
            //NA
            break
        default:
            break
        }
        
        return offsetServerPrefKey
    }
    
    static func getTotalCountPrefKey(pageName: String, pageUniqueId: String) -> String? {
        var totalCountPrefKey: String? = nil
        switch pageName {
        case PageConstants.HISTORY_PAGE:
            totalCountPrefKey = PageConstants.KEY_HISTORY_TOTAL_CONTENT_COUNT + pageUniqueId
        case PageConstants.VIDEO_CATEGORY_PAGE:
            totalCountPrefKey = PageConstants.KEY_VIDEO_CATEGORY_TOTAL_CONTENT_COUNT + pageUniqueId
        case PageConstants.VIDEO_LISTING_PAGE:
            totalCountPrefKey = PageConstants.KEY_VIDEO_LISTING_TOTAL_CONTENT_COUNT + pageUniqueId
        case PageConstants.SEARCH_TAGS_PAGE:
            totalCountPrefKey = PageConstants.KEY_SEARCH_TAGS_TOTAL_CONTENT_COUNT + pageUniqueId
        case PageConstants.SELECT_AVATAR_PAGE_NEW:
            fallthrough
        case PageConstants.SELECT_AVATAR_PAGE_ADD:
            fallthrough
        case PageConstants.SELECT_AVATAR_PAGE_EDIT:
            totalCountPrefKey = PageConstants.KEY_SELECT_AVATAR_TOTAL_CONTENT_COUNT + pageUniqueId
        case PageConstants.CHILD_SELECTION_PAGE:
            //NA
            break
        default:
            break
        }
        
        return totalCountPrefKey
    }
}
