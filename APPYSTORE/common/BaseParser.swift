//Purpose: parse basic information

import Foundation
import SwiftyJSON
import Alamofire
class BaseParser<T>: NSObject
{
    var ResponseCode: String!
    var ResponseMessage: String!
    var ResponseDetails:JSON!
    var status:Bool = false
    var parserListener: T?
    
    
    func parse(params:Parameters,completion:@escaping (_ listOfData:AnyObject?) -> Void)
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
                    
                    
                    completion(parsedResponseData)
                    
                    
                }
        })
    }
    
    func parseJSONData(responseData:JSON) -> AnyObject?{
        return nil
    }
    
    func setParserListener(parserListener: T){
        self.parserListener = parserListener
    }
    
    func getParserListener() -> T? {
        return parserListener
    }
    
    
    
}
