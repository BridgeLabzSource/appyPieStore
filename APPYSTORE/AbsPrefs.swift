//
//  AbsPrefs.swift
//  APPYSTORE
//
//  Created by gaurav on 14/03/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import Foundation

class AbsPrefs {
    var preferences: UserDefaults? = nil
    
    init(preferences: UserDefaults) {
        self.preferences = preferences
    }
    
    func setString(key: String, value: String?){
        preferences?.setValue(value, forKey: key)
    }
    
    func getString(key: String, defaultString: String?) -> String? {
        if let value = preferences?.string(forKey: key) {
            return value
        }
        
        return defaultString
    }
    
    func setBoolean(key: String, value: Bool) {
        preferences?.setValue(value, forKey: key)
    }
    
    func getBoolean(key: String, defaultBool: Bool = false) -> Bool {
        if let value = preferences?.bool(forKey: key) {
            return value
        }
        
        return defaultBool
    }
    
    func setInt(key: String, value: Int)  {
        preferences?.setValue(value, forKey: key)
    }
    
    func getInt(key: String, defaultInt: Int) -> Int {
        if let value = preferences?.integer(forKey: key) {
            return value
        }
        
        return defaultInt
    }
    
    func setDouble(key: String, value: Double) {
        preferences?.setValue(value, forKey: key)
    }
    
    func getDouble(key: String, defaultDouble: Double) -> Double{
        if let value = preferences?.double(forKey: key) {
            return value
        }
    
        return defaultDouble
    }
    
    func clearPreferences(){
        preferences?.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
    }
    
    
}
