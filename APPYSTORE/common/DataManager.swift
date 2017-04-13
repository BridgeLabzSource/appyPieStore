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
            HistoryParser().parse(params: HttpRequestBuilder.getHistoryParameters(method: "getAllHistory", childId: "29518", pageId: "History", offset: String(offset), limit: String(limit)), completion:{
                statusType, result in
                
                returndata(statusType, result!)
            })
            
        case PageConstants.VIDEO_CATEGORY_PAGE:
            VideoCategoryParser().parse(params: HttpRequestBuilder.getVideoCategoryParameters(), completion:{
                statusType, result in
                
                returndata(statusType, result!)
            })
            
        case PageConstants.VIDEO_LISTING_PAGE:
            VideoListingParser().parse(params: HttpRequestBuilder.getVideoListingParameters(method: "getContentList", contentType: "videos", offset: String(offset), limit: String(limit), catId: bundle?[BundleConstants.CATEGORY_ID] as! String, pCatId: bundle?[BundleConstants.PARENT_CATEGORY_ID] as! String, age: "1", inclAge: "1", pageId: "videos"), completion:{
                statusType, result in
                
                returndata(statusType, result!)
            })
            
            
        case PageConstants.RECOMMENDED_VIDEO_LISTING_PAGE:
            RecommendedVideoParser().parse(params: HttpRequestBuilder.getRecommendedVideoListingParameters(method: "getRecommendation", contentType: "videos", offset: String(offset), limit: String(limit), catId: "193", pCatId: "191", contentId: "20087824", sequenceType: "a", sequenceNumber: "501", age: "8", inclAge: "", returnedContentType: "videos", pageId: "videoRecommendation", flagItemAtFirstPosition: "1"), completion: {
                statusType, result in
                
                returndata(statusType, result!)
            })
            
            
        case PageConstants.SEARCH_RESULT_PAGE:
            SearchResultParser().parse(params: HttpRequestBuilder.getSearchResultParameters(method: "search", keyword: bundle?[BundleConstants.SEARCH_KEYWORD] as! String, contentType: "videos", offset: String(offset), limit: String(limit), age: "1", inclAge: "", ignoreCatId: "", pageId: "SearchFragment", isPopular: "0"), completion: {
                statusType, result in
                
                returndata(statusType, result!)
            })
        default:
            break
        }
    }
    
    func getLocalData(pageName: String, offset: Int, limit: Int, bundle: AndroidBundle, completion: @escaping ([BaseModel]?) -> Void ) {
        var dataList: [BaseModel]?
        
        switch pageName {
        case PageConstants.HISTORY_PAGE:
            dataList = HistoryDBManager().fetchDataWithLimit(childId: "29518", offset: offset, limit: limit, bundle: nil)
            
        case PageConstants.VIDEO_CATEGORY_PAGE:
            dataList = VideoDBManager().fetchAll()
            
        case PageConstants.VIDEO_LISTING_PAGE:
            dataList = VideoListingDBManager().fetchDataWithLimit(childId: "29518", offset: offset, limit: limit, bundle: bundle)
            
        default:
            break
        }
        
        completion(dataList)
    }
    
    func getRowCountForPage(pageName: String, bundle: AndroidBundle) -> Int {
        var count: Int = -1
        switch pageName {
        case PageConstants.HISTORY_PAGE:
            count = HistoryDBManager().getRowCount()
        case PageConstants.VIDEO_CATEGORY_PAGE:
            count = VideoDBManager().getRowCount()
        case PageConstants.VIDEO_LISTING_PAGE:
            count = VideoListingDBManager().getRowCount(bundle: bundle)
        default:
            break
        }
        
        return count
    }
    
    func deleteDataForPage(pageName: String, bundle: AndroidBundle) {
        switch pageName {
        case PageConstants.HISTORY_PAGE:
            HistoryDBManager().removeAll(bundle: bundle)
        case PageConstants.VIDEO_CATEGORY_PAGE:
            VideoDBManager().removeAll(bundle: bundle)
        case PageConstants.VIDEO_LISTING_PAGE:
            VideoListingDBManager().removeAll(bundle: bundle)
        default:
            break
        }
    }
    
    func saveDataForPage(pageName: String, dataList: [BaseModel]) ->Int {
        var count = -1
        
        switch pageName {
        case PageConstants.HISTORY_PAGE:
            count = HistoryDBManager().insertBulkRecords(userId: "107105246", childId: "29518", modelList: dataList)!
        case PageConstants.VIDEO_CATEGORY_PAGE:
            count = VideoDBManager().insertBulkRecords(userId: "107105246", childId: "29518", modelList: dataList)!
        case PageConstants.VIDEO_LISTING_PAGE:
            count = VideoListingDBManager().insertBulkRecords(userId: "107105246", childId: "29518", modelList: dataList)!
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
            break
        case PageConstants.VIDEO_CATEGORY_PAGE:
            totalCountPrefKey = PageConstants.KEY_VIDEO_CATEGORY_TOTAL_CONTENT_COUNT + pageUniqueId
            break
        case PageConstants.VIDEO_LISTING_PAGE:
            totalCountPrefKey = PageConstants.KEY_VIDEO_LISTING_TOTAL_CONTENT_COUNT + pageUniqueId
            break
            
        default:
            break
        }
        
        return totalCountPrefKey
    }
}
