
import Foundation

protocol BaseDBManager {
 
    func insertBulkRecords(userId: String?, childId: String?, modelList: [BaseModel]?) -> Int?
    
    func fetchDataWithLimit(childId:String,offset:Int,limit:Int,bundle:Bundle?) -> [BaseModel]?
    
    func fetchAll() -> [BaseModel]?
    
}
