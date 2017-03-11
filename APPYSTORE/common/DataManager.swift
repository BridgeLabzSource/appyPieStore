// get and store data

import Foundation

class DataManager:NSObject
{
    
    func getData(pageName:String,offset:Int,limit:Int, returndata:@escaping (_ result:[BaseModel])->Void)
    {
        switch pageName
        {
        case PageConstants.HISTORY_PAGE:
            let historyDBManager = HistoryDBManager()
            
            if Utils.isInternetAvailable()
            {
                let parser = HistoryParser()
                parser.parse(params: HttpRequestBuilder.getHistoryParameters(), completion: { result in
                  //  print(result as! [VideoListingModel])
                     historyDBManager.removeAll()
                     let record = historyDBManager.insertBulkRecords(userId: "107105246", childId: "29518", modelList: result)
                    print("%d Records are inserted succefully..",record!)
                    let localdata = historyDBManager.fetchDataWithLimit(childId: "29518", offset: offset, limit: limit, bundle: nil)
                     returndata(localdata!)
                    
                 })
            }
            else
            {
                let localdata = historyDBManager.fetchDataWithLimit(childId: "29518", offset: offset, limit: limit, bundle: nil)
                returndata(localdata!)
            }
            
        case PageConstants.VIDEO_PAGE:
//            let parser = VideoCategoryParser()
//            
//            parser.parse(params: HttpRequestBuilder.getVideoCategoryParameters(), completion: { result in
//                returndata(result)
//                
//            })
            let videoDBManager = VideoDBManager()
            
            if Utils.isInternetAvailable()
            {
                let parser = VideoCategoryParser()
                parser.parse(params: HttpRequestBuilder.getVideoCategoryParameters(), completion: { result in
                    //  print(result as! [VideoListingModel])
                    videoDBManager.removeAll()
                    let record = videoDBManager.insertBulkRecords(userId: "107105246", childId: "29518", modelList: result)
                    print("%d Records are inserted succefully..",record!)
                    let localdata = videoDBManager.fetchDataWithLimit(childId: "29518", offset: offset, limit: limit, bundle: nil)
                    returndata(localdata!)
                    
                })
            }
            else
            {
                let localdata = videoDBManager.fetchDataWithLimit(childId: "29518", offset: offset, limit: limit, bundle: nil)
                returndata(localdata!)
            }

            
            
        default:
            break
            
        }
    }
    
}
