
import Foundation
import CoreData
import UIKit
var data = [NSManagedObject]()
class HistoryDBManager:BaseDBManager{
     //MARK: variable declaration
    let TABLE_NAME = "HistoryTable";

    /*TABLE_HISTORY Column Names*/
    let HISTORY_USER_ID = "user_id";
    let HISTORY_CHILD_ID = "child_id";
    let HISTORY_CONTENT_ID = "content_id";
    let HISTORY_P_CAT_ID = "p_cat_id";
    let HISTORY_SUB_CAT_ID = "sub_cat_id";
    let HISTORY_SUB_CAT_TITLE = "sub_cat_title";
    let HISTORY_SEQ_TYPE = "seq_type";
    let HISTORY_SEQ_NUMBER = "seq_number";
    let HISTORY_TITLE = "title";
    let HISTORY_CONTENT_DURATION = "content_duration";
    let HISTORY_IMAGE_PATH = "image_path";
    let HISTORY_VERSION_ID = "version_id";
    let HISTORY_DNLD_URL = "dnld_url";
    let HISTORY_DOWNLOAD_STATUS = "download_status";
    let HISTORY_DOWNLOADED_FILE_PATH = "downloaded_file_path";
    let HISTORY_PAY_TYPE = "pay_type";
    let HISTORY_IS_VIDEO_DOWNLOADABLE = "video_streaming";
    
    
     //MARK: methods
    func insertBulkRecords(userId: String?, childId: String?, modelList: [BaseModel]?) -> Int?
    {
        var result:[VideoListingModel]? = (modelList as? [VideoListingModel])!
        var recordsInserted:Int = 0
    
        if (userId != nil && childId != nil)
        {
            if (result != nil && (result?.count)!>0)
            {
                
                for i in stride(from: 0, to: (result?.count)!, by: 1)
                {
                    let delegate = (UIApplication.shared.delegate as? AppDelegate)
                    let Context = delegate?.persistentContainer.viewContext
                    
                    let entity =  NSEntityDescription.entity(forEntityName: self.getTableName(),
                                                             in:Context!)
                    
                    let object = NSManagedObject(entity: entity!,insertInto:Context)
                   
                    
                    object.setValue(childId, forKey: "child_id")
                    object.setValue(result?[i].contentDuration, forKey: "content_duration")
                    object.setValue(result?[i].contentId, forKey: "content_id")
                    object.setValue(result?[i].downloadUrl, forKey: "dnld_url")
                    object.setValue(result?[i].downloadStatus, forKey: "download_status")
                    object.setValue(result?[i].downloadedFilePath, forKey: "downloaded_file_path")
                    object.setValue(result?[i].imagePath, forKey: "image_path")
                    object.setValue(result?[i].parentCategoryId, forKey: "p_cat_id")
                    object.setValue(result?[i].payType, forKey: "pay_type")
                    object.setValue(result?[i].sequenceNumber, forKey: "seq_number")
                    object.setValue(result?[i].sequenceType, forKey: "seq_type")
                    object.setValue(result?[i].subCategoryId, forKey: "sub_cat_id")
                    object.setValue(result?[i].subCategoryTitle, forKey: "sub_cat_title")
                    object.setValue(result?[i].title, forKey: "title")
                    object.setValue(result?[i].versionId, forKey: "version_id")
                    object.setValue(result?[i].isVideoDownloadable, forKey: "video_streaming")
                    object.setValue(userId, forKey: "user_id")
                    //end
                    do
                    {
                        try Context?.save()
                        data.append(object)
                    }
                    catch let error as NSError
                    {
                        print("Could not save \(error), \(error.userInfo)")
                    }
                    recordsInserted += 1
                }
            }
        }
        
        return recordsInserted
    }
    //MARK:fetch data with limit
    func fetchDataWithLimit(childId:String,offset:Int,limit:Int,bundle:Bundle?) -> [BaseModel]?
    {
        var historylist = [BaseModel]()
        let delegate = (UIApplication.shared.delegate as? AppDelegate)
        let Context = delegate?.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "HistoryTable")
      fetchRequest.fetchLimit = limit
      fetchRequest.fetchOffset = offset
    
      fetchRequest.predicate = NSPredicate(format: "%K = %@","child_id",childId)
            do
            {
              // let result = try Context.e
               let result = try Context?.fetch(fetchRequest) as! [NSManagedObject]
                historylist = getModelArrayFromFetchedResult(result: result)
            } catch let error as NSError
            {
                print("Could not fetch \(error), \(error.userInfo)")
            }

     return historylist
    }
    
    //MARK:fetch all data
    func fetchAll() -> [BaseModel]? {
        var historylist = [BaseModel]()
        let delegate = (UIApplication.shared.delegate as? AppDelegate)
        let Context = delegate?.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "HistoryTable")
        do
        {
            let result = try Context?.fetch(fetchRequest)
            historylist = getModelArrayFromFetchedResult(result: result as! [NSManagedObject])
        } catch let error as NSError
        {
            print("Could not fetch \(error), \(error.userInfo)")
        }
     return historylist
    }
    
    func getRowCount() -> Int {
        var count = 0
        
        let delegate = (UIApplication.shared.delegate as? AppDelegate)
        let context = delegate?.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "HistoryTable")
        do {
            count = try (context?.count(for: fetchRequest)) ?? 0
        } catch let error as NSError {
            print("Error : \(error)")
        }
        return count
    }
    
    //MARK: get array from database fetched result
   private func getModelArrayFromFetchedResult(result:[NSManagedObject]) -> [BaseModel]
    {
      // print("\(result.count)")
        //print("\(result)")
        var historylist = [VideoListingModel]()
        for i in stride(from: 0, to: result.count, by: 1)
        {
            let row = result[i]
          //  print(row)
            let historyModel:VideoListingModel = getVideoListingModel(row: row)
            historylist.append(historyModel)
        }
       return historylist
    }
    //MARK: getVideoListingModel
   private func getVideoListingModel(row:NSManagedObject) -> VideoListingModel
    {
      let historyModel = VideoListingModel()
        
        historyModel.childId = row.value(forKey: HISTORY_CHILD_ID) as! String
        historyModel.contentDuration = row.value(forKey: HISTORY_CONTENT_DURATION) as! String
        historyModel.contentId = row.value(forKey: HISTORY_CONTENT_ID) as! String
        historyModel.downloadUrl = row.value(forKey: HISTORY_DNLD_URL) as! String
         historyModel.downloadStatus = row.value(forKey: HISTORY_DOWNLOAD_STATUS) as! String
        historyModel.downloadedFilePath = row.value(forKey: HISTORY_DOWNLOADED_FILE_PATH) as! String
         historyModel.imagePath = row.value(forKey: HISTORY_IMAGE_PATH) as! String
         historyModel.parentCategoryId = row.value(forKey: HISTORY_P_CAT_ID) as! String
         historyModel.payType = row.value(forKey: HISTORY_PAY_TYPE) as! String
         historyModel.sequenceNumber = row.value(forKey: HISTORY_SEQ_NUMBER) as! String
         historyModel.sequenceType = row.value(forKey: HISTORY_SEQ_TYPE) as! String
         historyModel.subCategoryId = row.value(forKey: HISTORY_SUB_CAT_ID) as! String
        historyModel.subCategoryTitle = row.value(forKey: HISTORY_SUB_CAT_TITLE) as! String
         historyModel.title = row.value(forKey: HISTORY_TITLE) as! String
         historyModel.versionId = row.value(forKey: HISTORY_VERSION_ID) as! String
         historyModel.isVideoDownloadable = row.value(forKey: HISTORY_IS_VIDEO_DOWNLOADABLE) as! Bool
      return historyModel
    }
    
    private func getTableName() -> String
    {
        return TABLE_NAME
    }
    func removeAll()
    {
        let delegate = (UIApplication.shared.delegate as? AppDelegate)
        let Context = delegate?.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: self.getTableName())
        do
        {
            let records = try Context?.fetch(fetchRequest) as! [NSManagedObject]
            for record in records
            {
                Context?.delete(record)
            }
           
        } catch let error as NSError
        {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
}






