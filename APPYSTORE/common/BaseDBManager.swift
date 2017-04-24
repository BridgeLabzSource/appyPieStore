
import Foundation

protocol BaseDBManager {
 
    func insertBulkRecords(userId: String?, childId: String?, modelList: [BaseModel]?) -> Int?
    
    func fetchDataWithLimit(childId:String, offset:Int, limit:Int, bundle: AndroidBundle) -> [BaseModel]?
    
    func fetchAll() -> [BaseModel]?
    
    func getRowCount(bundle: AndroidBundle) -> Int
    
    func removeAll(bundle: AndroidBundle)
    
}
