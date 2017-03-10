
import Foundation
import CoreData
class VideoDBManager:BaseDBManager{
    //MARK: insert bulk data
    func insertBulkRecords(userId: String?, childId: String?, modelList: [BaseModel]?) -> Int?
    {
        print("")
        return nil
    }
    //MARK:fetch data with limit
    func fetchDataWithLimit(childId: String, offset: Int, limit: Int, bundle: Bundle?) -> [BaseModel]?
    {
        return nil
    }
    
    //MARK:fetch all data
    func fetchAll() -> [BaseModel]?
    {
        return nil
    }
}
