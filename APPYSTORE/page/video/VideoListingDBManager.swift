//
//  VideoListingDBManager.swift
//  APPYSTORE
//
//  Created by ios_dev on 05/04/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//


import Foundation
import CoreData
import UIKit

//var data = [NSManagedObject]()
class VideoListingDBManager: BaseDBManager{
    
    static let sharedInstance = VideoListingDBManager()
    
    private override init() {
        
    }
    
    override var TABLE_NAME: String {
        get {return "VideoListingTable"}
        set{}
    }
    
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
    
    
    override func insertBulkRecords(userId: String?, childId: String?, modelList: [BaseModel]?) -> Int?
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
                    
                    let entity =  NSEntityDescription.entity(forEntityName: TABLE_NAME, in:Context!)
                    
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
                        //data.append(object)
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
    
    override func fetchDataWithLimit(childId: String, offset: Int, limit: Int, bundle: AndroidBundle) -> [BaseModel]?
    {
        var modelArray = [BaseModel]()
        let delegate = (UIApplication.shared.delegate as? AppDelegate)
        let Context = delegate?.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: TABLE_NAME)
        fetchRequest.fetchLimit = limit
        fetchRequest.fetchOffset = offset
        
        let predicate1 = NSPredicate(format: "%K = %@", CHILD_ID, childId)
        let predicate2 = NSPredicate(format: "\(SUB_CAT_ID) == %@", bundle?[BundleConstants.CATEGORY_ID] as! String)
        
        fetchRequest.predicate = NSCompoundPredicate.init(type: .and, subpredicates: [predicate1,predicate2])
        
        
        do {
            let result = try Context?.fetch(fetchRequest) as! [NSManagedObject]
            modelArray = getModelArrayFromFetchedResult(result: result)
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        return modelArray
    }
    
    override func fetchAll() -> [BaseModel]? {
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
    
    override func getRowCount(bundle: AndroidBundle) -> Int {
        var count = 0
        
        let delegate = (UIApplication.shared.delegate as? AppDelegate)
        let context = delegate?.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: TABLE_NAME)
        fetchRequest.predicate = NSPredicate(format: "\(SUB_CAT_ID) == %@", bundle?[BundleConstants.CATEGORY_ID] as! String)
        
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
        let videoListingModel = VideoListingModel()
        
        videoListingModel.childId = row.value(forKey: CHILD_ID) as! String
        videoListingModel.contentDuration = row.value(forKey: CONTENT_DURATION) as! String
        videoListingModel.contentId = row.value(forKey: CONTENT_ID) as! String
        videoListingModel.downloadUrl = row.value(forKey: DOWNLOAD_URL) as! String
        videoListingModel.downloadStatus = row.value(forKey: DOWNLOAD_STATUS) as! String
        videoListingModel.downloadedFilePath = row.value(forKey: DOWNLOADED_FILE_PATH) as! String
        videoListingModel.imagePath = row.value(forKey: IMAGE_PATH) as! String
        videoListingModel.parentCategoryId = row.value(forKey: P_CAT_ID) as! String
        videoListingModel.payType = row.value(forKey: PAY_TYPE) as! String
        videoListingModel.sequenceNumber = row.value(forKey: SEQ_NUMBER) as! String
        videoListingModel.sequenceType = row.value(forKey: SEQ_TYPE) as! String
        videoListingModel.subCategoryId = row.value(forKey: SUB_CAT_ID) as! String
        videoListingModel.subCategoryTitle = row.value(forKey: SUB_CAT_TITLE) as! String
        videoListingModel.title = row.value(forKey: TITLE) as! String
        videoListingModel.versionId = row.value(forKey: VERSION_ID) as! String
        videoListingModel.isVideoDownloadable = row.value(forKey: IS_VIDEO_DOWNLOADABLE) as! Bool
        return videoListingModel
    }
    
    override func clearTable(bundle: AndroidBundle)
    {
        let delegate = (UIApplication.shared.delegate as? AppDelegate)
        let Context = delegate?.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: TABLE_NAME)
        
        if bundle != nil {
            fetchRequest.predicate = NSPredicate(format: "\(SUB_CAT_ID) == %@", bundle?[BundleConstants.CATEGORY_ID] as! String)
        }
        
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
