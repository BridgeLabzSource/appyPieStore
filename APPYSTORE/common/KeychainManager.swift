//
//  KeychainManager.swift
//  APPYSTORE
//
//  Created by ios_dev on 09/05/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import Foundation
import Security

// Constant Identifiers
let userAccount = "AuthenticatedUser"
let accessGroup = "SecurityService"


/**
 *  User defined keys for new entry
 *  Note: add new keys for new secure item and use them in load and save methods
 */

let vendorKey = "vendorKey"

// Arguments for the keychain queries
let kSecClassValue = NSString(format: kSecClass)
let kSecAttrAccountValue = NSString(format: kSecAttrAccount)
let kSecValueDataValue = NSString(format: kSecValueData)
let kSecClassGenericPasswordValue = NSString(format: kSecClassGenericPassword)
let kSecAttrServiceValue = NSString(format: kSecAttrService)
let kSecMatchLimitValue = NSString(format: kSecMatchLimit)
let kSecReturnDataValue = NSString(format: kSecReturnData)
let kSecMatchLimitOneValue = NSString(format: kSecMatchLimitOne)

public class KeychainManager: NSObject {
    
    /**
     * Exposed methods to perform save and load queries.
     */
    
    public class func saveVendorId(value: NSString) {
        self.save(key: vendorKey as NSString, value: value)
    }
    
    public class func getVendorId() -> String? {
        return self.load(key: vendorKey as NSString) as! String
    }
    
    /**
     * Internal methods for querying the keychain.
     */
    
    private class func save(key: NSString, value: NSString) {
        let dataFromString: NSData = value.data(using: String.Encoding.utf8.rawValue, allowLossyConversion: false)! as NSData
        
        // Instantiate a new default keychain query
        let keychainQuery: NSMutableDictionary = NSMutableDictionary(objects: [kSecClassGenericPasswordValue, key, userAccount, dataFromString], forKeys: [kSecClassValue, kSecAttrServiceValue, kSecAttrAccountValue, kSecValueDataValue])
        
        // Delete any existing items
        SecItemDelete(keychainQuery as CFDictionary)
        
        // Add the new keychain item
        SecItemAdd(keychainQuery as CFDictionary, nil)
    }
    
    private class func load(key: NSString) -> NSString? {
        // Instantiate a new default keychain query
        // Tell the query to return a result
        // Limit our results to one item
        let keychainQuery: NSMutableDictionary = NSMutableDictionary(objects: [kSecClassGenericPasswordValue, key, userAccount, kCFBooleanTrue, kSecMatchLimitOneValue], forKeys: [kSecClassValue, kSecAttrServiceValue, kSecAttrAccountValue, kSecReturnDataValue, kSecMatchLimitValue])
        
        var dataTypeRef :AnyObject?
        
        // Search for the keychain items
        let status: OSStatus = SecItemCopyMatching(keychainQuery, &dataTypeRef)
        var contentsOfKeychain: NSString? = nil
        
        if status == errSecSuccess {
            if let retrievedData = dataTypeRef as? NSData {
                contentsOfKeychain = NSString(data: retrievedData as Data, encoding: String.Encoding.utf8.rawValue)
            }
        } else {
            print("Nothing was retrieved from the keychain. Status code \(status)")
        }
        
        return contentsOfKeychain
    }
}
