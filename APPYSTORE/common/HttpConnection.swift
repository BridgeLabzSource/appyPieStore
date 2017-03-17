

//Purpose:make http connection

import Foundation
import Alamofire
import SwiftyJSON

class HttpConnection: NSObject{
    
    private static var jsonData: JSON?
    private static let url = "http://www.appystore.in/appy_app/appyApi_handler.php?"
    
    static func post(url: String, params: Parameters, headers: HTTPHeaders, completion:@escaping (_ getjsonData:JSON) -> Void)
    {
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
    
    static func post(params: Parameters , completion:@escaping (_ result:JSON)->Void )
    {
        post(url: self.url, params: params, headers: HttpRequestBuilder.getHeaders(), completion:{
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
