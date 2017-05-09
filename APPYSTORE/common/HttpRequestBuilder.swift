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
    static let LAST_CONTENT_ID = "last_content_id"
    static let FLAG_AT_ITEM_AT_FIRST_POSITION = "flag"
    static let SEQUENCE_TYPE = "sequence_type"
    static let SEQUENCE_NUMBER = "sequence_number"
    static let RETURN_CONTENT_TYPE = "return_content_type"

    static let KEYWORD = "keyword"
    static let IGNORE_CAT_ID = "ignore_cat_id"
    static let IS_POPULAR = "is_popular"
    
    static let MO = "mo"
    static let MSISDN = "msisdn"
    static let EMAILID = "userEmail"
    

    static let SMM_KEY = "smm_key"
    static let ANDROID_ID = "android_id"
    static let IMEI = "imei"
    

    static let CHILD_NAME = "child_name"
    static let CHILD_DOB = "child_dob"
    static let CHILD_AVATAR_ID = "child_avtarid"
    
    //dummy values
    static let IMEI_VALUE = "a5b9d7b7fe1425ea"
    static let PCP_VALUE = "999"
    static let CAMPAIGN_VALUE = "8700441600"
    static let ANDROID_ID_VALUE = "a5b9d7b7fe1425ea5"
    static let API_KEY_VALUE = "gh610rt23eqwpll"
    static let USER_ID = "user_id"
    static let OTP = "otp"
    
    static func getHeaders() -> HTTPHeaders {
        
        let headers: HTTPHeaders = [
            X_APPY_CONTENT_TYPE:"application/x-www-from-urlencoded",
               X_APPY_IMEI: IMEI_VALUE,
               X_APPY_PCP_ID: PCP_VALUE,// get from userdefaults
               X_APPY_CAMPAIGN_ID: CAMPAIGN_VALUE,
               X_APPY_USERID: UserInfo.getInstance().id ?? "",//107105246
               X_APPY_UTYPE: UserInfo.getInstance().type ?? "",
               X_APPY_UserAgent:"Mozilla/5.0 (Linux; Android 5.0.2; Panasonic ELUGA Switch Build/LRX22G; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/56.0.2924.87 Mobile Safari/537.36",
               X_APPY_DEVICE_WIDTH: "\(AppDelegate.DEVICE_WIDTH)",
               X_APPY_DEVICE_HEIGHT: "\(AppDelegate.DEVICE_HEIGHT)",
               X_APPY_ANDROID_ID: ANDROID_ID_VALUE,
               X_APPY_API_KEY: API_KEY_VALUE,
               X_APPY_CHILD_ID: UserInfo.getInstance().selectedChild?.id ?? "",//29518
               ACCEPT: "text/html,application/xhtml+xml,application/xml;q=0.9,*;q=0.8",
               ACCEPT_ENCODING: "",
               ACCEPT_LANGUAGE: "en-US,en;q=0.5",
               X_APPY_CONN_TYPE: Utils.getNetworkConnectionType(),
               X_APPY_TINFO: UserInfo.getInstance().tInfo ?? "",
               X_APPY_VISITOR_ID: ANDROID_ID_VALUE,//13cfcb08de0d2e84
               X_APPY_OST:"",
               X_APPY_USV: UserInfo.getInstance().usv ?? "",
               X_APPY_REG_KEY: "abcd",// gcmregkey
               X_APPY_VERSION: "18",
               X_APPY_VERSION_NAME: "1.0.7xx",
               X_APPY_TTR: "10800000",
               X_APPY_SESSION_ID: "abcd",
               X_APPY_APP_TYPE: APPY_LITE,
               
               X_APPY_IS_NEW_USER: "\(UserInfo.getInstance().isNewUser)",
               X_APPY_MSISDN: UserInfo.getInstance().msisdn ?? "",
               X_APPY_SUB_KEY: UserInfo.getInstance().smmKey ?? "",
               X_APPY_OS: "ios",
               X_APPY_OS_VERSION: "1.0",
               X_APPY_GOOGLE_CAMPAIGN_ID: "8700441600",// get from userdefaults
               X_APPY_IS_UPGRADED: "\(UserInfo.getInstance().isUpgraded)",//"false",
               X_APPY_IS_VERSION_UPGRADE: "\(UserInfo.getInstance().isVersionUpgraded)",//"false",
               X_APPY_IS_GOOGLE_BOT: "false",
               X_APPY_UTM_SOURCE: "abcd",
               X_APPY_UTM_MEDIUM: "abcd",
               X_APPY_SCREEN_NAME: "",
                                   ]
        return headers
    }
    
    static func getLoginParameters(method: String, msisdn: String, pageId: String, emailId: String) -> Parameters {
        return [METHOD: method,
                MO: msisdn,
                PAGEID: pageId,
                EMAILID: emailId
        ]
    }
    
    static func getHistoryParameters(offset: String, limit: String) -> Parameters {
        
        return [METHOD: "getAllHistory",
                CHILD_ID: (UserInfo.getInstance().selectedChild?.id)!,
                PAGEID: "History",
                OFFSET: offset,
                LIMIT: limit
        ]
    }
    
    static func getVideoCategoryParameters() -> Parameters
    {
        return [METHOD: "getCategoryList",
                LIMIT_START: "0",
                AGE: (UserInfo.getInstance().selectedChild?.age)!,
                INCL_AGE: "",
                CONTENT_TYPE:"videos"]
    }
    
    static func getAudioCategoryParameters() -> Parameters
    {
        return [METHOD:"getCategoryList",
                LIMIT_START:"20",
                AGE:"2",
                INCL_AGE:"0",
                CONTENT_TYPE:"audio"]
    }

    static func getVideoListingParameters(method: String, contentType: String, offset: String, limit: String, catId: String, pCatId: String, age: String, inclAge: String, pageId: String) -> Parameters
   {
        return [METHOD: "getContentList",
                CONTENT_TYPE: "videos",
                OFFSET: offset,
                LIMIT: limit,
                CATID: catId,
                PCATID: pCatId,
                AGE: (UserInfo.getInstance().selectedChild?.age)!,
                INCL_AGE: "",
                PAGEID: "videos"
        ]
    }
    
    static func getAudioListingParameters(method: String, contentType: String, offset: String, limit: String, catId: String, pCatId: String, age: String, inclAge: String, pageId: String) -> Parameters
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


    static func getRecommendedVideoListingParameters(offset: String, limit: String, catId: String, pCatId: String, contentId: String, sequenceType: String, sequenceNumber: String, lastContentId: String) -> Parameters {
        
        return [
            METHOD: "getRecommendation",
            CONTENT_TYPE: "videos",
            OFFSET: offset,
            LIMIT: limit,
            CATID: catId,
            PCATID: pCatId,
            CONTENT_ID: contentId,
            SEQUENCE_TYPE: sequenceType,
            SEQUENCE_NUMBER: sequenceNumber,
            AGE: (UserInfo.getInstance().selectedChild?.age)!,
            INCL_AGE: "",
            RETURN_CONTENT_TYPE: "videos",
            PAGEID: "videoRecommendation",
            FLAG_AT_ITEM_AT_FIRST_POSITION: "1",
            LAST_CONTENT_ID: lastContentId
        ]
    }
    
    static func getSearchResultParameters(keyword: String, offset: String, limit: String, ignoreCatId: String, isPopular: String) -> Parameters
    {
        return [METHOD: "search",
                KEYWORD: keyword,
                CONTENT_TYPE: "videos",
                OFFSET: offset,
                LIMIT: limit,
                AGE: (UserInfo.getInstance().selectedChild?.age)!,
                INCL_AGE: "",
                IGNORE_CAT_ID: ignoreCatId,
                PAGEID: "SearchFragment",
                IS_POPULAR: isPopular

        ]
    }
    
    static func getSearchTagsParameters() -> Parameters {
        return [METHOD: "getPopularSearch",
                PAGEID: "SearchFragment"
        ]
    }
    
    static func getAvatarParameters() -> Parameters {
        return [METHOD: AvatarParser.METHOD_NAME,
                PAGEID: "SelectAvatar"
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
    
    static func getOtpVerificationParameters(method: String, userId: String, msisdn: String, otp: String, smmKey: String, androidId: String, imei: String) -> Parameters {
        
        return [
            METHOD: method,
            USER_ID: userId,
            MSISDN: msisdn,
            OTP: otp,
            SMM_KEY: smmKey,
            ANDROID_ID: androidId,
            IMEI: imei
        ]
    }

    static func getChildRegistrationParameters(method: String, childName: String, childDob: String, avatarId: String, pageId: String) -> Parameters {
        return [METHOD: method,
                PAGEID: pageId,
                CHILD_NAME: childName,
                CHILD_DOB: childDob,
                CHILD_AVATAR_ID: avatarId

        ]
    }
    
}
