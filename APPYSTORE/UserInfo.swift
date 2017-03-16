//
//  UserInfo.swift
//  APPYSTORE
//
//  Created by gaurav on 13/03/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import Foundation

class UserInfo: NSCopying, NSCoding{
    static let USER_TYPE_CLOSED = "C"
    static let USER_TYPE_OPEN = "O"
    private static var instance: UserInfo? = nil;
    
    private init(){
        
    }
    
    static func getInstance() -> UserInfo{
        if instance == nil {
            instance = UserInfo()
        }
        
        return instance!
    }
    required init?(coder aDecoder: NSCoder) {
        self.id = aDecoder.decodeObject(forKey: "id") as? String
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
    }
    func copy(with zone: NSZone? = nil) -> Any {
        let userInfo = UserInfo()
        
        userInfo.id = id
        userInfo.type = type
        userInfo.email = email
        
        // need to make copy
        userInfo.childList = childList
        // need to make copy
        userInfo.selectedChild = selectedChild
        userInfo.childCount = childCount
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
        userInfo.isTrialSubscribed = isTrialSubscribed
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
    var childList: [ChildInfo]? = nil
    var selectedChild: ChildInfo? = nil
    var childCount = 0
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
    
    
    static func getChildCount(childList: [ChildInfo]?) -> Int{
        return childList?.count ?? 0
    }
    
}
