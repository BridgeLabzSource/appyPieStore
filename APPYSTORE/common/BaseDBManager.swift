
import Foundation
import CoreData
import UIKit

class BaseDBManager {
 
    var TABLE_NAME: String = ""
    
    func insertBulkRecords(userId: String?, childId: String?, modelList: [BaseModel]?) -> Int? {
        assert(false, "method must be implemented")
    }
    
    func fetchDataWithLimit(childId:String, offset:Int, limit:Int, bundle: AndroidBundle) -> [BaseModel]? {
        assert(false, "method must be implemented")
    }
    
    func fetchAll() -> [BaseModel]? {
        assert(false, "method must be implemented")
    }
    
    func getRowCount(bundle: AndroidBundle) -> Int {
        assert(false, "method must be implemented")
    }
    
    func clearTable(bundle: AndroidBundle) {
        let delegate = (UIApplication.shared.delegate as? AppDelegate)
        let Context = delegate?.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: TABLE_NAME)
        do {
            let records = try Context?.fetch(fetchRequest) as! [NSManagedObject]
            for record in records
            {
                Context?.delete(record)
            }
            
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
}
