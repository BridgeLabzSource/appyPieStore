

//Purpose:make http connection

import Foundation
import Alamofire
import SwiftyJSON

class HttpConnection: NSObject{
    
    private static var jsonData: JSON!
    private static let url = "http://www.appystore.in/appy_app/appyApi_handler.php?"
    
    static func post(url: String, params: Parameters, headers: HTTPHeaders, completion:@escaping (_ getjsonData:JSON) -> Void)
    {
      //  print("url:\(url) \n params:\(params) \n headers:\(headers)")
        Alamofire.request(url, parameters: params, headers: headers).responseJSON{ (response) in
            
            do
            {
                self.jsonData = JSON(response.result.value as! NSDictionary)
              //  print("Response: \(self.jsonData)")
                completion(self.jsonData)
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
    
    
}
