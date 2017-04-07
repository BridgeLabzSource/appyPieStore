
import Foundation
import CoreData
import UIKit

var data = [NSManagedObject]()

class HistoryDBManager: BaseDBManager{
    let TABLE_NAME = "HistoryTable";
    
    let USER_ID = "user_id";
    let CHILD_ID = "child_id";
    let CONTENT_ID = "content_id";
    let P_CAT_ID = "p_cat_id";
    let SUB_CAT_ID = "sub_cat_id";
    let SUB_CAT_TITLE = "sub_cat_title";
    let SEQ_TYPE = "seq_type";
    let SEQ_NUMBER = "seq_number";
    let TITLE = "title";
    let CONTENT_DURATION = "content_duration";
    let IMAGE_PATH = "image_path";
    let VERSION_ID = "version_id";
    let DOWNLOAD_URL = "dnld_url";
    let DOWNLOAD_STATUS = "download_status";
    let DOWNLOADED_FILE_PATH = "downloaded_file_path";
    let PAY_TYPE = "pay_type";
    let IS_VIDEO_DOWNLOADABLE = "video_streaming";
    
    
    func insertBulkRecords(userId: String?, childId: String?, modelList: [BaseModel]?) -> Int?
    {
        var result:[VideoListingModel]? = (modelList as? [VideoListingModel])!
        var recordsInserted: Int = 0
        
        if (userId != nil && childId != nil)
        {
            if (result != nil && (result?.count)! > 0)
            {
                for i in stride(from: 0, to: (result?.count)!, by: 1)
                {
                    let delegate = (UIApplication.shared.delegate as? AppDelegate)
                    let Context = delegate?.persistentContainer.viewContext
                    
                    let entity =  NSEntityDescription.entity(forEntityName: self.getTableName(), in:Context!)
                    
                    let object = NSManagedObject(entity: entity!,insertInto: Context)
                    
                    object.setValue(childId, forKey: CHILD_ID)
                    object.setValue(result?[i].contentDuration, forKey: CONTENT_DURATION)
                    object.setValue(result?[i].contentId, forKey: CONTENT_ID)
                    object.setValue(result?[i].downloadUrl, forKey: DOWNLOAD_URL)
                    object.setValue(result?[i].downloadStatus, forKey: DOWNLOAD_STATUS)
                    object.setValue(result?[i].downloadedFilePath, forKey: DOWNLOADED_FILE_PATH)
                    object.setValue(result?[i].imagePath, forKey: IMAGE_PATH)
                    object.setValue(result?[i].parentCategoryId, forKey: P_CAT_ID)
                    object.setValue(result?[i].payType, forKey: PAY_TYPE)
                    object.setValue(result?[i].sequenceNumber, forKey: SEQ_NUMBER)
                    object.setValue(result?[i].sequenceType, forKey: SEQ_TYPE)
                    object.setValue(result?[i].subCategoryId, forKey: SUB_CAT_ID)
                    object.setValue(result?[i].subCategoryTitle, forKey: SUB_CAT_TITLE)
                    object.setValue(result?[i].title, forKey: TITLE)
                    object.setValue(result?[i].versionId, forKey: VERSION_ID)
                    object.setValue(result?[i].isVideoDownloadable, forKey: IS_VIDEO_DOWNLOADABLE)
                    object.setValue(userId, forKey: USER_ID)
                  
                    do {
                        try Context?.save()
                        data.append(object)
                    }
                    catch let error as NSError {
                        print("Could not save \(error), \(error.userInfo)")
                    }
                    recordsInserted += 1
                }
            }
        }
        
        return recordsInserted
    }
    
    func fetchDataWithLimit(childId: String, offset: Int, limit: Int, bundle: AndroidBundle) -> [BaseModel]?
    {
        var historylist = [BaseModel]()
        let delegate = (UIApplication.shared.delegate as? AppDelegate)
        let Context = delegate?.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: TABLE_NAME)
        fetchRequest.fetchLimit = limit
        fetchRequest.fetchOffset = offset
        
        fetchRequest.predicate = NSPredicate(format: "%K = %@", CHILD_ID, childId)
        do {
            let result = try Context?.fetch(fetchRequest) as! [NSManagedObject]
            historylist = getModelArrayFromFetchedResult(result: result)
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        return historylist
    }
    
    func fetchAll() -> [BaseModel]? {
        var historylist = [BaseModel]()
        let delegate = (UIApplication.shared.delegate as? AppDelegate)
        let Context = delegate?.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: TABLE_NAME)
        do {
            let result = try Context?.fetch(fetchRequest)
            historylist = getModelArrayFromFetchedResult(result: result as! [NSManagedObject])
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        return historylist
    }
    
    func getRowCount() -> Int {
        var count = 0
        
        let delegate = (UIApplication.shared.delegate as? AppDelegate)
        let context = delegate?.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: TABLE_NAME)
        do {
            count = try (context?.count(for: fetchRequest)) ?? 0
        } catch let error as NSError {
            print("Error : \(error)")
        }
        return count
    }
    
    private func getModelArrayFromFetchedResult(result: [NSManagedObject]) -> [BaseModel]
    {
        var historylist = [VideoListingModel]()
        for i in stride(from: 0, to: result.count, by: 1)
        {
            let row = result[i]
            //print(row)
            let historyModel:VideoListingModel = getVideoListingModel(row: row)
            historylist.append(historyModel)
        }
        return historylist
    }
    
    private func getVideoListingModel(row: NSManagedObject) -> VideoListingModel
    {
        let historyModel = VideoListingModel()
        
        historyModel.childId = row.value(forKey: CHILD_ID) as! String
        historyModel.contentDuration = row.value(forKey: CONTENT_DURATION) as! String
        historyModel.contentId = row.value(forKey: CONTENT_ID) as! String
        historyModel.downloadUrl = row.value(forKey: DOWNLOAD_URL) as! String
        historyModel.downloadStatus = row.value(forKey: DOWNLOAD_STATUS) as! String
        historyModel.downloadedFilePath = row.value(forKey: DOWNLOADED_FILE_PATH) as! String
        historyModel.imagePath = row.value(forKey: IMAGE_PATH) as! String
        historyModel.parentCategoryId = row.value(forKey: P_CAT_ID) as! String
        historyModel.payType = row.value(forKey: PAY_TYPE) as! String
        historyModel.sequenceNumber = row.value(forKey: SEQ_NUMBER) as! String
        historyModel.sequenceType = row.value(forKey: SEQ_TYPE) as! String
        historyModel.subCategoryId = row.value(forKey: SUB_CAT_ID) as! String
        historyModel.subCategoryTitle = row.value(forKey: SUB_CAT_TITLE) as! String
        historyModel.title = row.value(forKey: TITLE) as! String
        historyModel.versionId = row.value(forKey: VERSION_ID) as! String
        historyModel.isVideoDownloadable = row.value(forKey: IS_VIDEO_DOWNLOADABLE) as! Bool
        return historyModel
    }
    
    private func getTableName() -> String
    {
        return TABLE_NAME
    }
    
    func removeAll(bundle: AndroidBundle)
    {
        let delegate = (UIApplication.shared.delegate as? AppDelegate)
        let Context = delegate?.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: self.getTableName())
        do {
            let records = try Context?.fetch(fetchRequest) as! [NSManagedObject]
            for record in records {
                Context?.delete(record)
            }
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
}






