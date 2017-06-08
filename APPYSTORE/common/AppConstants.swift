//
//  AppConstants.swift
//  APPYSTORE
//
//  Created by ios_dev on 06/04/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit

typealias AndroidBundle = [String: Any?]?

class AppConstants {
    static let APP_FONT_NAME = "KGMissKindyChunky"
    static let BUTTON_HEIGHT: CGFloat = 104.0
    
    //static let BASE_URL = "http://www.appystore.in/appy_app/appyApi_handler.php?"
    static let BASE_URL = "http://beta.appystore.in/appy_app/appyApi_handler.php?"
    
    //value is assigned in AppConfigurationHandler
    static var VENDOR_ID : String?
    
    static var DATE_FORMAT = "MMM d, yyyy"
    static let LANGUAGE = "en"
    
    static let SMM_KEY_TRIAL_NEW_USER = "appyt-f"
    static let SMM_KEY_TRIAL_EXISTING_USER = "appyt-m"
    
    static let USER_AGENT = UIWebView().stringByEvaluatingJavaScript(from: "navigator.userAgent")!
}
