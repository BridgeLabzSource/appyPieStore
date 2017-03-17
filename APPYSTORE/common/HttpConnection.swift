

//Purpose:make http connection

import Foundation
import Alamofire
import SwiftyJSON

class HttpConnection: NSObject{
    
    private static var jsonData: JSON?
    private static let url = "http://www.appystore.in/appy_app/appyApi_handler.php?"
    
    let RESPONSECODE_SUCCESS = "200"
    let RESPONSECODE_ERROR = "201"
    let RESPONSECODE_INVALID_CREDENTIAL = "202"
    let RESPONSECODE_REQUESTABORT = "210"
    let RESPONSECODE_REQUESTFAILED = "211"
    
    
    let RESPONSECODE_API_KEY_MISSING = "405"
    let RESPONSECODE_INVALID_API_KEY = "406"
    let RESPONSECODE_SERVER_ERROR = "500"
    let RESPONSECODE_REQUEST_SUCCESS = "900"
    let RESPONSECODE_CONNECTION_ERROR = "9001"
    
    let READ_TIMEOUT = 150000
    let CONNECTION_TIMEOUT = 200000
    
    let RESPONSE_REQUESTABORT = "abort"
    let RESPONSE_REQUESTFAILED = "failed"
    
    
    
    
    static func post(url: String, params: Parameters, headers: HTTPHeaders, completion:@escaping (_ getjsonData:JSON) -> Void){
        
        //  print("url:\(url) \n params:\(params) \n headers:\(headers)")
        Alamofire.request(url, parameters: params, headers: headers).responseJSON{ (response) in
            
            do
            {
                let j = JSON(response.result.value as! NSDictionary)
                if j.isEmpty == false
                {
                    completion(j)
                    
                }
                
                
            }
        }
        
    }
    
    static func post(params: Parameters, headers: HTTPHeaders, completion:@escaping (_ result:JSON)-> Void)
    {
        post(url: self.url, params: params, headers: headers, completion:{
            result in
            completion(result)
        })
    }
    
    static func post(url: String?, params: Parameters , completion:@escaping (_ result:JSON)->Void )
    {
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
