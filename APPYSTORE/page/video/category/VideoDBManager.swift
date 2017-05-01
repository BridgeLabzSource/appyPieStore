
import Foundation
import CoreData
import UIKit

class VideoDBManager: BaseDBManager {
    
    static let sharedInstance = VideoDBManager()
    
    private override init() {
        
    }

    override var TABLE_NAME: String {
        get {return "VideoCategoryTable"}
        set{}
    }
    
    let USER_ID = "user_id";
    let CHILD_ID = "child_id";
    let CAT_ID = "category_id";
    let CAT_NAME = "category_name";
    let PCAT_ID = "parent_category_id";
    let PCAT_NAME = "parent_category_name";
    let BLOCKED_STATUS = "blocked_status";
    let CAT_THUMB = "cat_thumb_url";
    let CANONICAL_NAME = "canonical_name";
    let VISIBILITY_STATUS = "visibility_status";
    let CONTENT_COUNT = "content_count";
    
    override func insertBulkRecords(userId: String?, childId: String?, modelList: [BaseModel]?) -> Int? {
        var result:[VideoCategoryModel]? = (modelList as? [VideoCategoryModel])!
        var recordsInserted:Int = 0
        
        if (userId != nil && childId != nil) {
            if (result != nil && (result?.count)!>0) {
                
                for i in stride(from: 0, to: (result?.count)!, by: 1) {
                    let delegate = (UIApplication.shared.delegate as? AppDelegate)
                    let Context = delegate?.persistentContainer.viewContext
                    
                    let entity =  NSEntityDescription.entity(forEntityName: TABLE_NAME, in:Context!)
                    
                    let object = NSManagedObject(entity: entity!,insertInto:Context)
                    
                    object.setValue(userId, forKey: USER_ID)
                    object.setValue(childId, forKey: CHILD_ID )
                    object.setValue(result?[i].categoryId, forKey: CAT_ID)
                    object.setValue(result?[i].categoryName, forKey: CAT_NAME)
                    object.setValue(result?[i].parentCategoryId, forKey: PCAT_ID)
                    object.setValue(result?[i].parentCategoryName, forKey: PCAT_NAME)
                    object.setValue(result?[i].isCategoryBlocked, forKey: BLOCKED_STATUS)
                    object.setValue(result?[i].imagePath, forKey: CAT_THUMB)
                    object.setValue(result?[i].canonicalName, forKey: CANONICAL_NAME)
                    object.setValue(result?[i].isVisible, forKey: VISIBILITY_STATUS)
                    object.setValue(result?[i].contentCount, forKey: CONTENT_COUNT)
                    
                    do {
                        try Context?.save()
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
    
    override func fetchDataWithLimit(childId: String, offset: Int, limit: Int, bundle: AndroidBundle) -> [BaseModel]? {
        var videocategorylist = [BaseModel]()
        let delegate = (UIApplication.shared.delegate as? AppDelegate)
        let Context = delegate?.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: TABLE_NAME)
        fetchRequest.fetchLimit = limit
        fetchRequest.fetchOffset = offset
        
        fetchRequest.predicate = NSPredicate(format: "%K = %@","child_id", childId)
        do {
            let result = try Context?.fetch(fetchRequest) as! [NSManagedObject]
            videocategorylist = getModelArrayFromFetchedResult(result: result)
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        return videocategorylist
        
    }
    
    override func fetchAll() -> [BaseModel]? {
        var videocategorylist = [BaseModel]()
        let delegate = (UIApplication.shared.delegate as? AppDelegate)
        let Context = delegate?.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: TABLE_NAME)
        do {
            let result = try Context?.fetch(fetchRequest)
            videocategorylist = getModelArrayFromFetchedResult(result: result as! [NSManagedObject])
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        return videocategorylist
    }
    
    override func getRowCount(bundle: AndroidBundle) -> Int {
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
    
    private func getModelArrayFromFetchedResult(result:[NSManagedObject]) -> [BaseModel] {
        
        var videocategorylist = [VideoCategoryModel]()
        for i in stride(from: 0, to: result.count, by: 1) {
            let row = result[i]
            //  print(row)
            let videoModel:VideoCategoryModel = getVideoCategoryModel(row: row)
            videocategorylist.append(videoModel)
        }
        return videocategorylist
    }
    
    private func getVideoCategoryModel(row:NSManagedObject) -> VideoCategoryModel {
        let videoCategoryModel = VideoCategoryModel()
        
        videoCategoryModel.categoryId = row.value(forKey: CAT_ID) as! String
        videoCategoryModel.categoryName = row.value(forKey: CAT_NAME) as! String
        videoCategoryModel.parentCategoryId = row.value(forKey: PCAT_ID) as! String
        videoCategoryModel.parentCategoryName = row.value(forKey: PCAT_NAME) as! String
        videoCategoryModel.imagePath = row.value(forKey: CAT_THUMB) as! String
        videoCategoryModel.isCategoryBlocked = row.value(forKey: BLOCKED_STATUS) as! String
        videoCategoryModel.canonicalName = row.value(forKey: CANONICAL_NAME) as! String
        videoCategoryModel.isVisible = row.value(forKey: VISIBILITY_STATUS) as! String
        videoCategoryModel.contentCount = row.value(forKey: CONTENT_COUNT) as! String
        
        return videoCategoryModel
    }
    
//    func clearTable(bundle: AndroidBundle) {
//        let delegate = (UIApplication.shared.delegate as? AppDelegate)
//        let Context = delegate?.persistentContainer.viewContext
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: TABLE_NAME)
//        do {
//            let records = try Context?.fetch(fetchRequest) as! [NSManagedObject]
//            for record in records
//            {
//                Context?.delete(record)
//            }
//            
//        } catch let error as NSError {
//            print("Could not fetch \(error), \(error.userInfo)")
//        }
//    }
    
    
}
