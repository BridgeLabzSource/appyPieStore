//Purpose: for parameter

import Foundation
import Alamofire

class HttpRequestBuilder: NSObject {
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
    
    static let METHOD = "method"
    static let CHILD_ID = "child_id"
    static let PAGEID = "pageid"
    static let OFFSET = "offset"
    static let LIMIT_START = "limit_start"
    static let LIMIT = "limit"
    static let CONTENT_TYPE = "content_type"
    static let CATID = "catid"
    static let PCATID = "pcatid"
    static let AGE = "age"
    static let INCL_AGE = "incl_age"

    static let CONTENT_ID = "content_id"
    static let FLAG_AT_ITEM_AT_FIRST_POSITION = "flag"
    static let SEQUENCE_TYPE = "sequence_type"
    static let SEQUENCE_NUMBER = "sequence_number"
    static let RETURN_CONTENT_TYPE = "return_content_type"

    static let KEYWORD = "keyword"
    static let IGNORE_CAT_ID = "ignore_cat_id"
    static let IS_POPULAR = "is_popular"
    
    static let MSISDN = "msisdn"
    static let EMAILID = "userEmail"
    
    static let SMM_KEY = "smm_key"
    static let ANDROID_ID = "android_id"
    static let IMEI = "imei"
    
    
    static func getHeaders() -> HTTPHeaders {
        
        let headers: HTTPHeaders = [
              X_APPY_CONTENT_TYPE:"application/x-www-from-urlencoded",
               X_APPY_IMEI:"a5b9d7b7fe1425ea",
               X_APPY_PCP_ID:"999",
               X_APPY_CAMPAIGN_ID:"8700441600",
               X_APPY_USERID:"107105246",//107105246
               X_APPY_UTYPE:"O",
               X_APPY_UserAgent:"Mozilla/5.0 (Linux; Android 5.0.2; Panasonic ELUGA Switch Build/LRX22G; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/56.0.2924.87 Mobile Safari/537.36",
               X_APPY_DEVICE_WIDTH:"1080",
               X_APPY_DEVICE_HEIGHT:"1920",
               X_APPY_ANDROID_ID:"a5b9d7b7fe1425ea",
               X_APPY_API_KEY:"gh610rt23eqwpll",
               X_APPY_CHILD_ID:"",//29518
               ACCEPT:"text/html,application/xhtml+xml,application/xml;q=0.9,*;q=0.8",
               ACCEPT_ENCODING:"",
               ACCEPT_LANGUAGE:"en-US,en;q=0.5",
               X_APPY_CONN_TYPE:"w",
               X_APPY_TINFO:"",
               X_APPY_VISITOR_ID:"",//13cfcb08de0d2e84
               X_APPY_OST:"",
               X_APPY_USV:"",
               X_APPY_REG_KEY:"abcd",
               X_APPY_VERSION:"18",
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
    
    static func getLoginParameters(method: String, msisdn: String, pageId: String, emailId: String) -> Parameters {
        return [METHOD: method,
                MSISDN: msisdn,
                PAGEID: pageId,
                EMAILID: emailId
        ]
    }
    
    static func getHistoryParameters(method: String, childId: String, pageId: String, offset: String, limit: String) -> Parameters {
        
        return [METHOD: method,
                CHILD_ID: childId,
                PAGEID: pageId,
                OFFSET: offset,
                LIMIT: limit
        ]
    }
    
    static func getVideoCategoryParameters() -> Parameters
    {
        return [METHOD:"getCategoryList",
                LIMIT_START:"0",
                AGE:"3",
                INCL_AGE:"1",
                CONTENT_TYPE:"videos"]
    }
    
    static func getVideoListingParameters(method: String, contentType: String, offset: String, limit: String, catId: String, pCatId: String, age: String, inclAge: String, pageId: String) -> Parameters
    {
        return [METHOD: method,
                CONTENT_TYPE: contentType,
                OFFSET: offset,
                LIMIT: limit,
                CATID: catId,
                PCATID: pCatId,
                AGE: age,
                INCL_AGE: inclAge,
                PAGEID: pageId
        ]
    }
    

    static func getRecommendedVideoListingParameters(method: String, contentType: String, offset: String, limit: String, catId: String, pCatId: String, contentId: String, sequenceType: String, sequenceNumber: String, age: String, inclAge: String, returnedContentType: String, pageId: String, flagItemAtFirstPosition: String) -> Parameters {
        
        return [
            METHOD: method,
            CONTENT_TYPE: contentType,
            OFFSET: offset,
            LIMIT: limit,
            CATID: catId,
            PCATID: pCatId,
            CONTENT_ID: contentId,
            SEQUENCE_TYPE: sequenceType,
            SEQUENCE_NUMBER: sequenceNumber,
            AGE: age,
            INCL_AGE: inclAge,
            RETURN_CONTENT_TYPE: returnedContentType,
            PAGEID: pageId,
            FLAG_AT_ITEM_AT_FIRST_POSITION: flagItemAtFirstPosition
        ]
    }

    static func getSearchResultParameters(method: String, keyword: String, contentType: String, offset: String, limit: String, age: String, inclAge: String, ignoreCatId: String, pageId: String, isPopular: String) -> Parameters
    {
        return [METHOD: method,
                KEYWORD: keyword,
                CONTENT_TYPE: contentType,
                OFFSET: offset,
                LIMIT: limit,
                AGE: age,
                INCL_AGE: inclAge,
                IGNORE_CAT_ID: ignoreCatId,
                PAGEID: pageId,
                IS_POPULAR: isPopular

        ]
    }
    
    static func getSearchTagsParameters(method: String, pageId: String) -> Parameters {
        return [METHOD: method,
                PAGEID: pageId
        ]
    }
    
    static func getAvatarParameters(method: String, pageId: String) -> Parameters {
        return [METHOD: method,
                PAGEID: pageId
        ]
    }
    
    static func getOtpRequestParameters(method: String, msisdn: String, smmKey: String, androidId: String, imei: String) -> Parameters {
        
        return [
            METHOD: method,
            MSISDN: msisdn,
            SMM_KEY: smmKey,
            ANDROID_ID: androidId,
            IMEI: imei
        ]
    }
    
}
