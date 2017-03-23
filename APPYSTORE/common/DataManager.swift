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
            //let historyDBManager = HistoryDBManager()
            
            //if Utils.isInternetAvailable() {
                let parser = HistoryParser()
                parser.parse(params: HttpRequestBuilder.getHistoryParameters(method: "getAllHistory", childId: "29518", pageId: "History", offset: "1", limit: "149"),
                             completion: { statusType, result in
                                //  print(result as! [VideoListingModel])
                                
                                
                                /*if statusType == BaseParser.SERVER_SUCCESS ,let result = result as? [BaseModel] {*/
                                    /*
 historyDBManager.removeAll()
                                    let record = historyDBManager.insertBulkRecords(userId: "107105246", childId: "29518", modelList: result)
                                    print("%d Records are inserted succefully..",record!)
                                    let localdata = historyDBManager.fetchDataWithLimit(childId: "29518", offset: offset, limit: limit, bundle: nil)
 */
                                    returndata(statusType, result!)
                                    //returndata(statusType, localdata!)
                                /*}*/
                                
                })
            /*} else {
                
                let localdata = historyDBManager.fetchDataWithLimit(childId: "29518", offset: offset, limit: limit, bundle: nil)
                returndata("", localdata!)
 
            }*/
            
        case PageConstants.VIDEO_PAGE:
            let videoDBManager = VideoDBManager()
            
            if Utils.isInternetAvailable() {
                let parser = VideoCategoryParser()
                parser.parse(params: HttpRequestBuilder.getVideoCategoryParameters(),
                             completion: { statusType, result in
                                if let result = result as? [BaseModel]{
                                    videoDBManager.removeAll()
                                    let record = videoDBManager.insertBulkRecords(userId: "107105246", childId: "29518", modelList: result)
                                    print("%d Records are inserted succefully..",record!)
                                    let localdata = videoDBManager.fetchDataWithLimit(childId: "29518", offset: offset, limit: limit, bundle: nil)
                                    returndata(statusType, localdata! as AnyObject)
                                }
                                
                })
            } else {
                let localdata = videoDBManager.fetchDataWithLimit(childId: "29518", offset: offset, limit: limit, bundle: nil)
                returndata("", localdata! as AnyObject)
            }
            
            
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
            dataList = videoDBManager.fetchDataWithLimit(childId: "29518", offset: offset, limit: limit, bundle: nil)
            
        default:
            break
        }
        
        completion(dataList)
    }
    
    func clearLocalData() {
    
    }
    
}
