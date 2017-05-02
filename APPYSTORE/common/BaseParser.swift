//Purpose: parse basic information

import Foundation
import SwiftyJSON
import Alamofire

class BaseParser: NSObject {
    
    var responseCode: String!
    var responseMessage: String!
    var responseDetails: JSON!
    var url: String?
    var params: Parameters?
    
    func parse(params: Parameters,completion: @escaping (_ responseStatus: String, _ listOfData: AnyObject?) -> Void) {
        
        self.url = AppConstants.BASE_URL
        
        self.params = params
        
        HttpConnection.post(url: self.url, params: params,
                            completion: { response in
                
            let strongSelf = self
            if response.result.error != nil {
                completion(DataFetchFramework.CONNECTION_ERROR, nil)
            } else {
                let result = JSON( response.result.value as! NSDictionary )
                
                print("Response Ganesh : \(result)")
                
                strongSelf.responseCode = String(describing: result["ResponseCode"].int ?? 0)
                
                strongSelf.responseMessage = result["ResponseMessage"].string
                
                if StringUtil.compareIgnoreCase(firstString: strongSelf.responseCode, secondString: HttpConnection.RESPONSECODE_SUCCESS){
                    
                    strongSelf.responseDetails = result["Responsedetails"] as JSON
                    
                    //let parsedResponseData = strongSelf.parseJSONData(responseData: strongSelf.responseDetails)
                    let parsedResponseData = strongSelf.getResponseData(wholeData: result, responseDetail: strongSelf.responseDetails)
                    
                    completion(DataFetchFramework.REQUEST_SUCCESS, parsedResponseData)
                } else {
                    completion(DataFetchFramework.REQUEST_FAILURE, strongSelf.responseMessage as AnyObject?)
                }
                
            }
                
        })
    }
    
    func getResponseData(wholeData: JSON, responseDetail: JSON) -> AnyObject? {
        return parseJSONData(responseData: responseDetail)
    }
    
    func parseJSONData(responseData:JSON) -> AnyObject? {
        return nil
    }
    
}
