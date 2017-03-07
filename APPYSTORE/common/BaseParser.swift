//Purpose: parse basic information

import Foundation
import SwiftyJSON
import Alamofire
class BaseParser: NSObject
{
     var ResponseCode: String!
     var ResponseMessage: String!
     var ResponseDetails:JSON!
     var status:Bool = false
    
    func parse(params:Parameters,completion:@escaping (_ listOfData:[BaseModel]) -> Void)
    {
        HttpConnection.post(params: params, completion:
            {result in
                if result != nil
                {
                    self.ResponseCode = result["ResponseCode"].string
                    self.ResponseMessage = result["ResponseMessage"].string
                    self.ResponseDetails = result["Responsedetails"] as JSON
                    self.status = true
                    let parsedResponseData = self.parseJSONData(responseData: self.ResponseDetails)
                    
                   
                    completion(parsedResponseData!)
                    
                
                }
        })
    }
    
    func parseJSONData(responseData:JSON) -> [BaseModel]?{
        return nil
    }
    
    
    
    
    
}
