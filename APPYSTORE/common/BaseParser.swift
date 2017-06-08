//Purpose: parse basic information

import Foundation
import SwiftyJSON
import Alamofire

class BaseParser: NSObject {
    
    static let USER_ALREADY_SUBSCRIBED = "USER_ALREADY_SUBSCRIBED"
    static let REQUEST_FAILURE = "REQUEST_FAILURE"
    static let REQUEST_SUCCESS = "REQUEST_SUCCESS"
    static let CONNECTION_ERROR = "CONNECTION_ERROR"
    static let NO_INTERNET_CONNECTION_STATUS_CODE = "430"
    
    var responseCode: String!
    var responseMessage: String!
    var responseDetails: JSON!
    var url: String?
    var params: Parameters?
    
    func parse(params: Parameters,completion: @escaping (_ responseStatus: String, _ listOfData: AnyObject?) -> Void) {
        
        self.url = AppConstants.BASE_URL
        
        self.params = params
        
        if Utils.isInternetAvailable() {
            HttpConnection.post(url: self.url, params: params, completion: { response in
                
                let strongSelf = self
                print("BaseParser Request params : \(params)")
                print("BaseParser Request headers : \(HttpRequestBuilder.getHeaders())")
                if response.result.error != nil {
                    completion(BaseParser.CONNECTION_ERROR, nil)
                } else {
                    let result = JSON( response.result.value as! NSDictionary )
                    
                    print("BaseParser Response : \(result)")
                    
                    strongSelf.responseCode = String(describing: result["ResponseCode"].int ?? 0)
                    
                    strongSelf.responseMessage = result["ResponseMessage"].string
                    
                    if StringUtil.compareIgnoreCase(firstString: strongSelf.responseCode, secondString: HttpConnection.RESPONSECODE_SUCCESS){
                        
                        strongSelf.responseDetails = result["Responsedetails"] as JSON
                        
                        //let parsedResponseData = strongSelf.parseJSONData(responseData: strongSelf.responseDetails)
                        let parsedResponseData = strongSelf.getResponseData(wholeData: result, responseDetail: strongSelf.responseDetails)
                        
                        self.callback(BaseParser.REQUEST_SUCCESS, strongSelf.responseCode, parsedResponseData, completion)
                        //completion(DataFetchFramework.REQUEST_SUCCESS, parsedResponseData)
                    } else {
                        self.callback(BaseParser.REQUEST_FAILURE, strongSelf.responseCode, strongSelf.responseMessage as AnyObject?, completion)
                        //completion(DataFetchFramework.REQUEST_FAILURE, strongSelf.responseMessage as AnyObject?)
                    }
                    
                }
                
            })
        } else {
            completion(BaseParser.CONNECTION_ERROR, "No network connection" as AnyObject?)
        }
        
    }
    
    func callback(_ status: String, _ code: String, _ data: AnyObject?,_ completion: @escaping (_ responseStatus: String, _ listOfData: AnyObject?) -> Void  ){
        
        completion(status, data)
    }
    
    func getResponseData(wholeData: JSON, responseDetail: JSON) -> AnyObject? {
        return parseJSONData(responseData: responseDetail)
    }
    
    func parseJSONData(responseData:JSON) -> AnyObject? {
        return nil
    }
    
}
