//
//  AvatarDBManager.swift
//  APPYSTORE
//
//  Created by ios_dev on 21/04/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import CoreData
import UIKit

class AvatarDBManager: BaseDBManager {
    
    static let sharedInstance = AvatarDBManager()
    
    private override init() {
        
    }
    
    override var TABLE_NAME: String {
        get {return "AvatarTable"}
        set{}
    }
    
    let AVATAR_ID = "avatar_id"
    let AVATAR_IMG = "avatar_img"
    
    override func insertBulkRecords(userId: String?, childId: String?, modelList: [BaseModel]?) -> Int?
    {
        var result:[AvatarModel]? = (modelList as? [AvatarModel])!
        var recordsInserted: Int = 0
        if (result != nil && (result?.count)! > 0) {
            for i in stride(from: 0, to: (result?.count)!, by: 1) {
                let delegate = (UIApplication.shared.delegate as? AppDelegate)
                let Context = delegate?.persistentContainer.viewContext
                let entity =  NSEntityDescription.entity(forEntityName: self.TABLE_NAME, in:Context!)
                let object = NSManagedObject(entity: entity!,insertInto: Context)
                
                object.setValue(result?[i].id, forKey: AVATAR_ID)
                object.setValue(result?[i].imagePath, forKey: AVATAR_IMG)
                
                
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
        
        return recordsInserted
    }
    
    override func fetchDataWithLimit(childId: String, offset: Int, limit: Int, bundle: AndroidBundle) -> [BaseModel]?
    {
        return nil
    }
    
    override func fetchAll() -> [BaseModel]? {
        var list = [BaseModel]()
        let delegate = (UIApplication.shared.delegate as? AppDelegate)
        let Context = delegate?.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: TABLE_NAME)
        do {
            let result = try Context?.fetch(fetchRequest)
            list = getModelArrayFromFetchedResult(result: result as! [NSManagedObject])
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        return list
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
    
    private func getModelArrayFromFetchedResult(result: [NSManagedObject]) -> [BaseModel]
    {
        var list = [AvatarModel]()
        for i in stride(from: 0, to: result.count, by: 1)
        {
            let row = result[i]
            let model: AvatarModel = getAvatarModel(row: row)
            list.append(model)
        }
        return list
    }
    
    private func getAvatarModel(row: NSManagedObject) -> AvatarModel
    {
        let model = AvatarModel()
        
        model.id = row.value(forKey: AVATAR_ID) as! String
        model.imagePath = row.value(forKey: AVATAR_IMG) as! String
        return model
    }
    
//    override func clearTable(bundle: AndroidBundle)
//    {
//        let delegate = (UIApplication.shared.delegate as? AppDelegate)
//        let Context = delegate?.persistentContainer.viewContext
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: self.TABLE_NAME)
//        do {
//            let records = try Context?.fetch(fetchRequest) as! [NSManagedObject]
//            for record in records {
//                Context?.delete(record)
//            }
//        } catch let error as NSError {
//            print("Could not fetch \(error), \(error.userInfo)")
//        }
//    }
    
}
