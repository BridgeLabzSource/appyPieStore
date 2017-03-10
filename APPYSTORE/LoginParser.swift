//
//  LoginParser.swift
//  APPYSTORE
//
//  Created by gaurav on 08/03/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import Foundation
import SwiftyJSON

class LoginParser: BaseParser{
    
    private let METHOD_NAME = "login"
    private let USERID = "UserId"
    private let UTYPE = "Utype"
    
    private let IS_ADDRESS_UPDATED = "is_address_updated"
    // user subscription validity
    private let USV = "usv"
    // type of subscription taken
    private let SMM_KEY = "smm_key"
    private let MSISDN = "msisdn"
    private let IS_ELIGIBLE_FOR_TRIAL_SUBSCRIPTION = "free_sub"
    private let TINFO = "tinfo"
    
    private let TRIAL_MSG_PRICE = "price"
    private let NUM_WORKSHEET = "num_worksheet"
    private let NUM_DAYS = "num_days"
    
    private let IS_UPGRADED = "is_upgraded"
    private let IS_VERSION_UPGRADE = "is_version_upgrade";
    private let IS_TRIAL_EXPIRED = "is_trial_expired";
    private let IS_NEW_USER = "is_new_user";
    
    private let PCP_ID = "pcp_id";
    private let CAMPAIGN_ID = "campaign_id";
    
    private let SERVER_CONFIG = "server_config";
    private let SERVER_CONFIG_TIMESTAMP = "_timestamp";
    private let SUBSCRIPTION_VALIDITY = "subscription_validity";
    
    private var userInfo: UserInfo? = nil;
    private var userInfoOld: UserInfo? = nil;
    
    private let CHILD_LIST = "childlist";
    private let CHILD_ID = "childId";
    private let DOB = "dob";
    private let AGE = "age";
    private let MONTH = "ageMonth";
    
    private let CHILD_TYPE = "childType";
    private let CHILD_NAME = "childName";
    private let AVATAR_ID = "avatarId";
    private let AVATAR_IMG = "avatarIMG";
    
    override init() {
        userInfoOld = UserInfo.getInstance()
    }
    
    override func parseJSONData(responseData: JSON) -> AnyObject? {
        
        
        print("Login Parser response = \(responseData)" )
        userInfo = UserInfo.getInstance()
        
        if !StringUtil.compareIgnoreCase(firstString: getValueForKey(inputJson: responseData, key: USERID), secondString: userInfo?.id) {
            //
        }
        
        if !StringUtil.compareIgnoreCase(firstString: getValueForKey(inputJson: responseData, key: UTYPE), secondString: userInfo?.id) {
            //
        }
        
        setUserData(inputJson: responseData)
        parseServerConfigAndTimeStamp(jsonObject: responseData)
        parseSubscriptionValidity(jsonObject: responseData)
        parseGlobalConfig()
        
        return userInfo
    }
    
    
    func getValueForKey(inputJson: JSON, key: String) -> String? {
        return HttpConnection.getJSONKeyvalue(jsonObject: inputJson, key: key)
    }
    
    func setUserData(inputJson: JSON) {
        if let userInfo = userInfo {
            userInfo.id = getValueForKey(inputJson: inputJson, key: USERID)
            userInfo.type = getValueForKey(inputJson: inputJson, key: UTYPE)
            userInfo.msisdn = getValueForKey(inputJson: inputJson, key: MSISDN)
            userInfo.smmKey = getValueForKey(inputJson: inputJson, key: SMM_KEY)
            userInfo.childList = parseChildDetail(jsonChildArray: inputJson[CHILD_LIST].array)
            userInfo.childCount = UserInfo.getChildCount(childList: userInfo.childList)
            userInfo.isAddressUpdated = StringUtil.compareIgnoreCase(firstString: getValueForKey(inputJson: inputJson, key: IS_ADDRESS_UPDATED), secondString: "true")
            userInfo.usv = getValueForKey(inputJson: inputJson, key: USV)
            if inputJson[IS_ELIGIBLE_FOR_TRIAL_SUBSCRIPTION].exists(){
                let isEligibleForTrial = StringUtil.compareIgnoreCase(firstString: getValueForKey(inputJson: inputJson, key: IS_ELIGIBLE_FOR_TRIAL_SUBSCRIPTION), secondString: "1")
                
                userInfo.isDeviceEligibleForTrialSubscription = isEligibleForTrial
                //
            }
            
            userInfo.tInfo = getValueForKey(inputJson: inputJson, key: TINFO)
            userInfo.trialMsgPrice = getValueForKey(inputJson: inputJson, key: TRIAL_MSG_PRICE)
            userInfo.numWorksheet = getValueForKey(inputJson: inputJson, key: NUM_WORKSHEET)
            userInfo.numOfDaysTrial = getValueForKey(inputJson: inputJson, key: NUM_DAYS)
            userInfo.isNewUser = StringUtil.compareIgnoreCase(firstString: getValueForKey(inputJson: inputJson, key: IS_NEW_USER), secondString: "Y")
            userInfo.isUpgraded = StringUtil.compareIgnoreCase(firstString: getValueForKey(inputJson: inputJson, key: IS_UPGRADED), secondString: "1")
            userInfo.isVersionUpgraded = StringUtil.compareIgnoreCase(firstString: getValueForKey(inputJson: inputJson, key: IS_VERSION_UPGRADE), secondString: "true")
            userInfo.isTrialExpired = StringUtil.compareIgnoreCase(firstString: getValueForKey(inputJson: inputJson, key: IS_TRIAL_EXPIRED), secondString: "1")
            //
            
            
        }
        
    }
    
    func parseChildDetail(jsonChildArray: [JSON]?) -> [ChildInfo]{
        var childList: [ChildInfo] = [];
        
        if jsonChildArray != nil && !(jsonChildArray?.isEmpty)! {
            for child in jsonChildArray!{
                if child != nil{
                    let childInfo = ChildInfo();
                    childInfo.id = getValueForKey(inputJson: child, key: CHILD_ID)
                    childInfo.name = getValueForKey(inputJson: child, key: CHILD_NAME)
                    childInfo.dob = getValueForKey(inputJson: child, key: DOB)
                    childInfo.age = getValueForKey(inputJson: child, key: AGE)
                    childInfo.month = getValueForKey(inputJson: child, key: MONTH)
                    childInfo.type = getValueForKey(inputJson: child, key: CHILD_TYPE)
                    childInfo.avatarId = getValueForKey(inputJson: child, key: AVATAR_ID)
                    childInfo.avatarImage = getValueForKey(inputJson: child, key: AVATAR_IMG)
                    
                    childList.append(childInfo)
                    
                }
            }
        }
        
        return childList
    }
    
    func parseServerConfigAndTimeStamp(jsonObject: JSON){
        if jsonObject[SERVER_CONFIG].exists() {
            let config = jsonObject[SERVER_CONFIG]
            
            if config[SERVER_CONFIG_TIMESTAMP].exists(){
            
            }
        }
    }
    
    func parseSubscriptionValidity(jsonObject: JSON){
        if let subValue = getValueForKey(inputJson: jsonObject, key: SUBSCRIPTION_VALIDITY){
        
        }
    }
    
    func parseGlobalConfig(){
    
    }

}
