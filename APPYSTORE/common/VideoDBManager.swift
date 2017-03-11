
import Foundation
import CoreData
import UIKit
class VideoDBManager:BaseDBManager{
    
    let TABLE_NAME = "VideoTable"
    
    /*TABLE_VIDEO_CATEGORY Column Names*/
    let VIDEO_CATEGORY_USER_ID = "user_id";
    let VIDEO_CATEGORY_CHILD_ID = "child_id";
    let VIDEO_CATEGORY_CAT_ID = "category_id";
    let VIDEO_CATEGORY_NAME = "category_name";
    let VIDEO_CATEGORY_PCAT_ID = "parent_category_id";
    let VIDEO_CATEGORY_PCAT_NAME = "parent_category_name";
    let VIDEO_CATEGORY_BLOCKED_STATUS = "blocked_status";
    let VIDEO_CATEGORY_CAT_THUMB = "cat_thumb_url";
    let VIDEO_CATEGORY_CANONICAL_NAME = "canonical_name";
    let VIDEO_CATEGORY_VISIBILITY_STATUS = "visibility_status";
    let VIDEO_CATEGORY_CONTENT_COUNT = "content_count";

    
    //MARK: insert bulk data
    func insertBulkRecords(userId: String?, childId: String?, modelList: [BaseModel]?) -> Int?
    {
        var result:[VideoCategoryModel]? = (modelList as? [VideoCategoryModel])!
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
                    
                    object.setValue(result?[i].imagePath, forKey: VIDEO_CATEGORY_CAT_THUMB)
                    object.setValue(childId, forKey:VIDEO_CATEGORY_CHILD_ID )
                    object.setValue(result?[i].contentCount, forKey: VIDEO_CATEGORY_CONTENT_COUNT)
                    object.setValue(result?[i].categoryId, forKey: VIDEO_CATEGORY_CAT_ID)
                    object.setValue(result?[i].categoryName, forKey: VIDEO_CATEGORY_NAME)
                    object.setValue(result?[i].parentCategoryId, forKey: VIDEO_CATEGORY_PCAT_ID)
                    object.setValue(result?[i].parentCategoryName, forKey: VIDEO_CATEGORY_PCAT_NAME)
                    object.setValue(result?[i].isCategoryBlocked, forKey: VIDEO_CATEGORY_BLOCKED_STATUS)
                    object.setValue(result?[i].canonicalName, forKey: VIDEO_CATEGORY_CANONICAL_NAME)
                    object.setValue(result?[i].isVisible, forKey: VIDEO_CATEGORY_VISIBILITY_STATUS)
                    object.setValue(result?[i].contentCount, forKey: VIDEO_CATEGORY_CONTENT_COUNT)
                    object.setValue(userId, forKey: VIDEO_CATEGORY_USER_ID)
                    
                    //end
                    do
                    {
                        try Context?.save()
                        
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
    func fetchDataWithLimit(childId: String, offset: Int, limit: Int, bundle: Bundle?) -> [BaseModel]?
    {
        var videocategorylist = [BaseModel]()
        let delegate = (UIApplication.shared.delegate as? AppDelegate)
        let Context = delegate?.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: self.getTableName())
        fetchRequest.fetchLimit = limit
        fetchRequest.fetchOffset = offset
        
        fetchRequest.predicate = NSPredicate(format: "%K = %@","child_id",childId)
        do
        {
           
            let result = try Context?.fetch(fetchRequest) as! [NSManagedObject]
            videocategorylist = getModelArrayFromFetchedResult(result: result)
        } catch let error as NSError
        {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        return videocategorylist

    }
    //MARK:get table name
    private func getTableName() -> String
    {
        return TABLE_NAME
    }
    //MARK:fetch all data
    func fetchAll() -> [BaseModel]?
    {
        var videocategorylist = [BaseModel]()
        let delegate = (UIApplication.shared.delegate as? AppDelegate)
        let Context = delegate?.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: self.getTableName())
        do
        {
            let result = try Context?.fetch(fetchRequest)
            videocategorylist = getModelArrayFromFetchedResult(result: result as! [NSManagedObject])
        } catch let error as NSError
        {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        return videocategorylist

    }
    
    //MARK: get array from database fetched result
    private func getModelArrayFromFetchedResult(result:[NSManagedObject]) -> [BaseModel]
    {
      
        var videocategorylist = [VideoCategoryModel]()
        for i in stride(from: 0, to: result.count, by: 1)
        {
            let row = result[i]
            //  print(row)
            let videoModel:VideoCategoryModel = getVideoCategoryModel(row: row)
            videocategorylist.append(videoModel)
        }
        return videocategorylist
    }
    //MARK: getVideoListingModel
    private func getVideoCategoryModel(row:NSManagedObject) -> VideoCategoryModel
    {
        let videoCategoryModel = VideoCategoryModel()
        
        videoCategoryModel.categoryId = row.value(forKey: VIDEO_CATEGORY_CAT_ID) as! String
        videoCategoryModel.categoryName = row.value(forKey: VIDEO_CATEGORY_NAME) as! String
        videoCategoryModel.contentCount = row.value(forKey: VIDEO_CATEGORY_CONTENT_COUNT) as! String
        videoCategoryModel.imagePath = row.value(forKey: VIDEO_CATEGORY_CAT_THUMB) as! String
        videoCategoryModel.parentCategoryId = row.value(forKey: VIDEO_CATEGORY_CAT_ID) as! String
        videoCategoryModel.parentCategoryName = row.value(forKey: VIDEO_CATEGORY_NAME) as! String
        videoCategoryModel.isCategoryBlocked = row.value(forKey: VIDEO_CATEGORY_BLOCKED_STATUS) as! String
        videoCategoryModel.canonicalName = row.value(forKey: VIDEO_CATEGORY_CANONICAL_NAME) as! String
        videoCategoryModel.isVisible = row.value(forKey: VIDEO_CATEGORY_VISIBILITY_STATUS) as! String
       
        return videoCategoryModel
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
