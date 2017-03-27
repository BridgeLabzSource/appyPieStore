// get and store data

import Foundation

class DataManager: NSObject {
    
    static let sharedInstance = DataManager()
    
    private override init() {
        
    }
    
    func getData(pageName: String, offset: Int, limit: Int,
                 returndata: @escaping (_ statusType: String, _ result:AnyObject)->Void) {
        
        switch pageName {
        case PageConstants.HISTORY_PAGE:
            
            let parser = HistoryParser()
            parser.parse(params: HttpRequestBuilder.getHistoryParameters(method: "getAllHistory", childId: "29518", pageId: "History", offset: String(offset), limit: String(limit)), completion:{
                statusType, result in
                
                returndata(statusType, result!)
                
            })
            
        case PageConstants.VIDEO_PAGE:
            let parser = VideoCategoryParser()
            parser.parse(params: HttpRequestBuilder.getVideoCategoryParameters(), completion:{
                statusType, result in
                
                returndata(statusType, result!)
                
            })
            
        default:
            break
            
        }
    }
    
    func getLocalData(pageName: String, offset: Int, limit: Int,
                      completion: @escaping ([BaseModel]?) -> Void ) {
        var dataList: [BaseModel]?
        
        switch pageName {
        case PageConstants.HISTORY_PAGE:
            let historyDBManager = HistoryDBManager()
            dataList = historyDBManager.fetchDataWithLimit(childId: "29518", offset: offset, limit: limit, bundle: nil)
            
        case PageConstants.VIDEO_PAGE:
            let videoDBManager = VideoDBManager()
            dataList = videoDBManager.fetchAll()
            
        default:
            break
        }
        
        completion(dataList)
    }
    
    func getRowCountForPage(pageName: String) -> Int {
        var count: Int = -1
        switch pageName {
        case PageConstants.HISTORY_PAGE:
            let historyDBManager = HistoryDBManager()
            count = historyDBManager.getRowCount()
        case PageConstants.VIDEO_PAGE:
            let videoDBManager = VideoDBManager()
            count = videoDBManager.getRowCount()
        default:
            break
        }
        
        return count
    }
    
    func deleteDataForPage(pageName: String) {
        switch pageName {
        case PageConstants.HISTORY_PAGE:
            let historyDBManager = HistoryDBManager()
            historyDBManager.removeAll()
        case PageConstants.VIDEO_PAGE:
            let videoDBManager = VideoDBManager()
            videoDBManager.removeAll()
        default:
            break
        }
    }
    
    func saveDataForPage(pageName: String, dataList: [BaseModel]) ->Int {
        var count = -1
        switch pageName {
        case PageConstants.HISTORY_PAGE:
            let historyDBManager = HistoryDBManager()
            count = historyDBManager.insertBulkRecords(userId: "107105246", childId: "29518", modelList: dataList)!
            
            print("%d Records are inserted succefully..",count)
        case PageConstants.VIDEO_PAGE:
            let videoDBManager = VideoDBManager()
            count = videoDBManager.insertBulkRecords(userId: "107105246", childId: "29518", modelList: dataList)!
        default:
            break
        }
        
        return count
    }
    
    static func getDataFetchTimePrefKey(pageName: String) -> String {
        var dataFetchTimePrefKey = ""
        switch pageName {
        case PageConstants.HISTORY_PAGE:
            dataFetchTimePrefKey = PageConstants.KEY_HISTORY_DATA_FETCH_TIME
            break
        case PageConstants.VIDEO_PAGE:
            dataFetchTimePrefKey = PageConstants.KEY_VIDEO_CATEGORY_DATA_FETCH_TIME
            break
        default:
            break
        }
        
        return dataFetchTimePrefKey
    }
    
    static func getOffsetServerPrefKey(pageName: String) -> String {
        var offsetServerPrefKey = ""
        switch pageName {
        case PageConstants.HISTORY_PAGE:
            offsetServerPrefKey = PageConstants.KEY_HISTORY_SERVER_OFFSET
            break
        case PageConstants.VIDEO_PAGE:
            offsetServerPrefKey = PageConstants.KEY_VIDEO_CATEGORY_SERVER_OFFSET
            break
        default:
            break
        }
        
        return offsetServerPrefKey
    }
    
    static func getTotalCountPrefKey(pageName: String) -> String {
        var totalCountPrefKey = ""
        switch pageName {
        case PageConstants.HISTORY_PAGE:
            totalCountPrefKey = PageConstants.KEY_HISTORY_TOTAL_CONTENT_COUNT
            break
        case PageConstants.VIDEO_PAGE:
            totalCountPrefKey = PageConstants.KEY_VIDEO_CATEGORY_TOTAL_CONTENT_COUNT
            break
        default:
            break
        }
        
        return totalCountPrefKey
    }
}
