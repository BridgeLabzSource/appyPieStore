//Purpose: for parameter

import Foundation
import Alamofire

class HttpRequestBuilder: NSObject
{
    //MARK: Header Constants
    private static let X_APPY_CONTENT_TYPE = "Content-Type"
    private static let X_APPY_IMEI = "X_APPY_IMEI"
    private static let X_APPY_PCP_ID = "X_APPY_PCP_ID"
    private static let X_APPY_CAMPAIGN_ID = "X_APPY_CAMPAIGN_ID"
    private static let X_APPY_UserAgent = "X_APPY_UserAgent"
    private static let X_APPY_USERID = "X_APPY_USERID"
    private static let X_APPY_UTYPE = "X_APPY_UTYPE"
    private static let X_APPY_DEVICE_WIDTH = "X_APPY_DEVICE_WIDTH"
    private static let X_APPY_DEVICE_HEIGHT = "X_APPY_DEVICE_HEIGHT"
    private static let X_APPY_ANDROID_ID = "X_APPY_ANDROID_ID"
    private static let X_APPY_API_KEY = "X_APPY_API_KEY"
    private static let X_APPY_CHILD_ID = "X_APPY_CHILD_ID"
    private static let ACCEPT = "Accept"
    private static let ACCEPT_ENCODING = "Accept-Encoding"
    private static let ACCEPT_LANGUAGE = "Accept-Language"
    private static let X_APPY_CONN_TYPE = "X_APPY_CONN_TYPE"
    private static let X_APPY_TINFO = "X_APPY_TINFO"
    private static let X_APPY_VISITOR_ID = "X_APPY_VISITOR_ID"
    private static let X_APPY_OST = "X_APPY_OST"
    private static let X_APPY_USV = "X_APPY_USV"
    private static let X_APPY_REG_KEY = "X_APPY_REG_KEY"
    private static let X_APPY_VERSION = "X_APPY_VERSION"
    private static let X_APPY_VERSION_NAME = "X_APPY_VERSION_NAME"
    private static let X_APPY_TTR = "X_APPY_TTR"
    private static let X_APPY_SESSION_ID = "X_APPY_SESSION_ID"
    private static let X_APPY_APP_TYPE = "X_APPY_APP_TYPE"
    private static let APPY_LITE = "lite"
    private static let X_APPY_IS_NEW_USER = "X_APPY_IS_NEW_USER"
    private static let X_APPY_MSISDN = "X_APPY_MSISDN"
    private static let X_APPY_SUB_KEY = "X_APPY_SUB_KEY"
    private static let X_APPY_OS = "X_APPY_OS"
    private static let X_APPY_OS_VERSION = "X_APPY_OS_VERSION"
    private static let X_APPY_GOOGLE_CAMPAIGN_ID = "X_APPY_GOOGLE_CAMPAIGN_ID"
    private static let X_APPY_IS_UPGRADED = "X_APPY_IS_UPGRADED"
    private static let X_APPY_IS_VERSION_UPGRADE = "X_APPY_IS_VERSION_UPGRADE"
    private static let X_APPY_IS_GOOGLE_BOT = "X_APPY_IS_GOOGLE_BOT"
    private static let X_APPY_UTM_SOURCE = "X_APPY_UTM_SOURCE"
    private static let X_APPY_UTM_MEDIUM = "X_APPY_UTM_MEDIUM"
    private static let X_APPY_SCREEN_NAME = "X_APPY_SCREEN_NAME"
    
    // let X_APPY_LAST_PAGE_NAME = "X_APPY_LAST_PAGE_NAME"
    // let X_APPY_INLINE_PLAY = "X_APPY_INLINE_PLAY"
    
    
   static func getHeaders() -> HTTPHeaders
    {
        let headers:HTTPHeaders = [
              X_APPY_CONTENT_TYPE:"application/x-www-from-urlencoded",
               X_APPY_IMEI:"862188036890804",
               X_APPY_PCP_ID:"999",
               X_APPY_CAMPAIGN_ID:"8700441600",
               X_APPY_USERID:"107105246",
               X_APPY_UTYPE:"O",
               X_APPY_UserAgent:"Mozilla/5.0 (Linux; Android 5.0.2; Panasonic ELUGA Switch Build/LRX22G; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/56.0.2924.87 Mobile Safari/537.36",
               X_APPY_DEVICE_WIDTH:"1080",
               X_APPY_DEVICE_HEIGHT:"1920",
               X_APPY_ANDROID_ID:"13cfcb08de0d2e84",
               X_APPY_API_KEY:"gh610rt23eqwpll",
               X_APPY_CHILD_ID:"29518",
               ACCEPT:"text/html,application/xhtml+xml,application/xml;q=0.9,*;q=0.8",
               ACCEPT_ENCODING:"",
               ACCEPT_LANGUAGE:"en-US,en;q=0.5",
               X_APPY_CONN_TYPE:"w",
               X_APPY_TINFO:"",
               X_APPY_VISITOR_ID:"13cfcb08de0d2e84",
               X_APPY_OST:"",
               X_APPY_USV:"",
               X_APPY_REG_KEY:"abcd",
               X_APPY_VERSION:"11",
               X_APPY_VERSION_NAME:"1.0.7xx",
               X_APPY_TTR:"10800000",
               X_APPY_SESSION_ID:"abcd",
               X_APPY_APP_TYPE:"lite",
               
               X_APPY_IS_NEW_USER:"N",
               X_APPY_MSISDN:"",
               X_APPY_SUB_KEY:"",
               X_APPY_OS:"ios",
               X_APPY_OS_VERSION:"1.0",
               X_APPY_GOOGLE_CAMPAIGN_ID:"8700441600",
               X_APPY_IS_UPGRADED:"false",
               X_APPY_IS_VERSION_UPGRADE:"false",
               X_APPY_IS_GOOGLE_BOT:"false",
               X_APPY_UTM_SOURCE:"abcd",
               X_APPY_UTM_MEDIUM:"abcd",
               X_APPY_SCREEN_NAME:"",
                                   ]
        return headers
    }
    
  static func getHistoryParameters() -> Parameters
    {
        let params = ["method":"getAllHistory",
                      "child_id":"29518",
                      "page_id":"History",
                      "offset":"1",

                      "limit":"149"]
        return params
    }
    
    static func getVideoCategoryParameters() -> Parameters
    {
        let params = ["method":"getCategoryList",
                      "limit_start":"0",
                      "age":"3",
                      "incl_age":"1",
                      "content_type":"videos"]
        return params
    }
    
}
