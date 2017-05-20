

//Purpose:make http connection

import Foundation
import Alamofire
import SwiftyJSON

class HttpConnection: NSObject{
    
    private static var jsonData: JSON?
    private static let url = "http://www.appystore.in/appy_app/appyApi_handler.php?"
    
    static let RESPONSECODE_SUCCESS = "200"
    static let RESPONSECODE_ERROR = "201"
    static let RESPONSECODE_INVALID_CREDENTIAL = "202"
    static let RESPONSECODE_REQUESTABORT = "210"
    static let RESPONSECODE_REQUESTFAILED = "211"
    
    
    static let RESPONSECODE_API_KEY_MISSING = "405"
    static let RESPONSECODE_INVALID_API_KEY = "406"
    static let RESPONSECODE_SERVER_ERROR = "500"
    static let RESPONSECODE_REQUEST_SUCCESS = "900"
    static let RESPONSECODE_CONNECTION_ERROR = "9001"
    
    static let READ_TIMEOUT = 150000
    static let CONNECTION_TIMEOUT = 200000
    
    static let RESPONSE_REQUESTABORT = "abort"
    static let RESPONSE_REQUESTFAILED = "failed"
    
    
    
    
    static func post(url: String, params: Parameters, headers: HTTPHeaders, completion:@escaping (_ response: DataResponse<Any>) -> Void) {
        
        //  print("url:\(url) \n params:\(params) \n headers:\(headers)")
        print("Ganesh : url: \(url) \n params: \(params)")
        Alamofire.request(url, parameters: params, headers: headers).responseJSON{ (response) in
            print("Ganesh : url response: \(response)")
           
            
            completion(response)
        }
        
    }
    
    static func post(params: Parameters, headers: HTTPHeaders, completion:@escaping (_ result: DataResponse<Any>)-> Void) {
        post(url: self.url, params: params, headers: headers, completion:{
            result in
            completion(result)
        })
    }
    
    static func post(url: String?, params: Parameters , completion: @escaping (_ result: DataResponse<Any>) ->Void ) {
        
        post(url: url!, params: params, headers: HttpRequestBuilder.getHeaders(), completion:{
            result in
            completion(result)
        })
    }
    
    static func getJSONKeyvalue(jsonObject: JSON, key: String) -> String?{
        var value: String?
        
        if jsonObject[key].exists() {
            if !StringUtil.isEmptyOrNullString(stringToCheck: String(describing: jsonObject[key].rawValue)){
                value = String(describing: jsonObject[key].rawValue)
                print("Ganesh \(key) : \(value)")
            }
        }
        
        return value
    }
    
    
}
