//
//  PageDataPref.swift
//  APPYSTORE
//
//  Created by ios_dev on 22/03/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import Foundation

class PageDataPref: AbsPrefs {
    static var instance: PageDataPref? = nil
    
    override init(preferences: UserDefaults) {
        super.init(preferences: preferences)
    }
    
    static func getInstance() -> PageDataPref? {
        if PageDataPref.instance == nil {
            let sp = UserDefaults(suiteName: "pageSpecificData")
            instance = PageDataPref(preferences: sp!)
        }
        
        return instance
    }
    
    func getPreviousDataFetchTime(key: String) -> Int64 {
        return getInt64(key: key, defaultInt: 0)
    }
    
    func setPreviousDataFetchTime(key: String, value: Int64) {
        setInt64(key: key, value: value)
    }
    
    func setTotalContentCount(key: String, value: Int) {
        setInt(key: key, value: value)
    }
    
    func getTotalContentCount(key: String) -> Int {
        return getInt(key: key, defaultInt: -1)
    }
    
    func setOffsetServer(key: String, value: Int) {
        setInt(key: key, value: value)
    }
    
    func getOffsetServer(key: String) -> Int {
        return getInt(key: key, defaultInt: 0)
    }
}
