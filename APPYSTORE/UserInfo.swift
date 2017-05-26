//
//  UserInfo.swift
//  APPYSTORE
//
//  Created by gaurav on 13/03/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import Foundation

class UserInfo: NSObject, NSCopying, NSCoding{
    static let USER_TYPE_CLOSED = "C"
    static let USER_TYPE_OPEN = "O"
    private static var instance: UserInfo? = nil;
    
    private override init(){
        
    }
    
    static func getInstance() -> UserInfo{
        if instance == nil {
            UserInfo.getUserInfoFromUserDefaultsAndUpdateInstance()
            if instance == nil {
                instance = UserInfo()
            }
        }
        
        return instance!
    }
    
    required init?(coder aDecoder: NSCoder) {
        id = aDecoder.decodeObject(forKey: "id") as? String
        
        type = aDecoder.decodeObject(forKey: "type") as? String
        email = aDecoder.decodeObject(forKey: "email") as? String
        childList = aDecoder.decodeObject(forKey: "childList") as! [ChildInfo]
        selectedChild = aDecoder.decodeObject(forKey: "selectedChild") as? ChildInfo
        isAddressUpdated = aDecoder.decodeBool(forKey: "isAddressUpdated")
        msisdn = aDecoder.decodeObject(forKey: "msisdn") as? String
        smmKey = aDecoder.decodeObject(forKey: "smmKey") as? String
        isDeviceEligibleForTrialSubscription = aDecoder.decodeBool(forKey: "isDeviceEligibleForTrialSubscription")
        usv = aDecoder.decodeObject(forKey: "usv") as? String
        tInfo = aDecoder.decodeObject(forKey: "tInfo") as? String
        trialMsgPrice = aDecoder.decodeObject(forKey: "trialMsgPrice") as? String
        numWorksheet = aDecoder.decodeObject(forKey: "numWorksheet") as? String
        isNewUser = aDecoder.decodeBool(forKey: "isNewUser")
        isUpgraded = aDecoder.decodeBool(forKey: "isUpgraded")
        isVersionUpgraded = aDecoder.decodeBool(forKey: "isVersionUpgraded")
        isSubscribed = aDecoder.decodeBool(forKey: "isSubscribed")
        isTrialSubscribed = aDecoder.decodeBool(forKey: "isTrialSubscribed")
        isPaidExpired = aDecoder.decodeBool(forKey: "isPaidExpired")
        isUnsubscribed = aDecoder.decodeBool(forKey: "isUnsubscribed")
        isTrialExpired = aDecoder.decodeBool(forKey: "isTrialExpired")
        isPaidExpired = aDecoder.decodeBool(forKey: "isPaidExpired")
        isGuestUser = aDecoder.decodeBool(forKey: "isGuestUser")
        isLoggedIn = aDecoder.decodeBool(forKey: "isLoggedIn")
        isInvalidData = aDecoder.decodeBool(forKey: "isInvalidData")
        preChatFormField = aDecoder.decodeObject(forKey: "preChatFormField") as? PreChatFormField
        ttr = aDecoder.decodeObject(forKey: "ttr") as? String
        visitorId = aDecoder.decodeObject(forKey: "visitorId") as? String
        sessionId = aDecoder.decodeObject(forKey: "sessionId") as? String
        
        super.init()
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(type, forKey: "type")
        aCoder.encode(email, forKey: "email")
        aCoder.encode(childList, forKey: "childList")
        aCoder.encode(selectedChild, forKey: "selectedChild")
        aCoder.encode(isAddressUpdated, forKey: "isAddressUpdated")
        aCoder.encode(msisdn, forKey: "msisdn")
        aCoder.encode(smmKey, forKey: "smmKey")
        aCoder.encode(isDeviceEligibleForTrialSubscription, forKey: "isDeviceEligibleForTrialSubscription")
        aCoder.encode(usv, forKey: "usv")
        aCoder.encode(tInfo, forKey: "tInfo")
        aCoder.encode(trialMsgPrice, forKey: "trialMsgPrice")
        aCoder.encode(numWorksheet, forKey: "numWorksheet")
        aCoder.encode(isNewUser, forKey: "isNewUser")
        aCoder.encode(isUpgraded, forKey: "isUpgraded")
        aCoder.encode(isVersionUpgraded, forKey: "isVersionUpgraded")
        aCoder.encode(isSubscribed, forKey: "isSubscribed")
        aCoder.encode(isTrialSubscribed, forKey: "isTrialSubscribed")
        aCoder.encode(isPaidExpired, forKey: "isPaidExpired")
        aCoder.encode(isUnsubscribed, forKey: "isUnsubscribed")
        aCoder.encode(isTrialExpired, forKey: "isTrialExpired")
        aCoder.encode(isPaidExpired, forKey: "isPaidExpired")
        aCoder.encode(isGuestUser, forKey: "isGuestUser")
        aCoder.encode(isLoggedIn, forKey: "isLoggedIn")
        aCoder.encode(isInvalidData, forKey: "isInvalidData")
        aCoder.encode(preChatFormField, forKey: "preChatFormField")
        aCoder.encode(ttr, forKey: "ttr")
        aCoder.encode(visitorId, forKey: "visitorId")
        aCoder.encode(sessionId, forKey: "sessionId")
        
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        let userInfo = UserInfo()
        
        userInfo.id = id
        userInfo.type = type
        userInfo.email = email
        
        // need to make copy
        userInfo.childList = childList.clone()
        // need to make copy
        userInfo.selectedChild = selectedChild?.copy() as! ChildInfo?
        userInfo.isAddressUpdated = isAddressUpdated
        userInfo.msisdn = msisdn
        userInfo.smmKey = smmKey
        userInfo.isDeviceEligibleForTrialSubscription = isDeviceEligibleForTrialSubscription
        userInfo.usv = usv
        userInfo.tInfo = tInfo
        userInfo.trialMsgPrice = trialMsgPrice
        userInfo.numWorksheet = numWorksheet
        userInfo.numOfDaysTrial = numOfDaysTrial
        userInfo.isNewUser = isNewUser
        userInfo.isUpgraded = isUpgraded
        userInfo.isVersionUpgraded = isVersionUpgraded
        userInfo.isSubscribed = isSubscribed
        userInfo.isTrialSubscribed = isTrialSubscribed
        userInfo.isPaidExpired = isPaidExpired
        userInfo.isUnsubscribed = isUnsubscribed
        userInfo.isTrialExpired = isTrialExpired
        userInfo.isPaidExpired = isPaidExpired
        userInfo.isGuestUser = isGuestUser
        userInfo.isLoggedIn = isLoggedIn
        userInfo.isInvalidData = isInvalidData
        
        // need to make copy
        userInfo.preChatFormField = preChatFormField
        userInfo.ttr = ttr
        userInfo.visitorId = visitorId
        userInfo.sessionId = sessionId
        
        return userInfo
    }
    
    var id: String? = nil
    var type: String? = nil
    var email: String? = nil
    var childList: [ChildInfo] = []
    var selectedChild: ChildInfo? = nil
    var isAddressUpdated = false
    var msisdn: String? = nil
    var smmKey: String? = nil
    var isDeviceEligibleForTrialSubscription = false
    var usv: String? = nil
    var tInfo: String? = nil
    var trialMsgPrice: String? = nil
    var numWorksheet: String? = nil
    var numOfDaysTrial: String? = nil
    var isNewUser = false
    var isUpgraded = false
    var isVersionUpgraded = false
    var isSubscribed = false
    var isTrialSubscribed = false
    var isPaidSubscribed = false
    
    var isUnsubscribed = false
    var isTrialExpired = false
    var isPaidExpired = false
    var isGuestUser = false
    
    var isLoggedIn = false
    var isInvalidData = false
    var preChatFormField: PreChatFormField? = nil
    var ttr: String? = nil
    var visitorId: String? = nil
    var sessionId: String? = nil
    
    func getClone() -> UserInfo? {
        Prefs.getInstance()?.setObject(key: "userInfoObject", value: self)
        
        return Prefs.getInstance()?.getObject(key: "userInfoObject") as? UserInfo
    }
    
    func saveUserInfoToUserDefaults() {
        Prefs.getInstance()?.setUserInfo(value: self)
    }
    
    static func getUserInfoFromUserDefaultsAndUpdateInstance() {
        UserInfo.instance = Prefs.getInstance()?.getUserInfo()
    }
}
