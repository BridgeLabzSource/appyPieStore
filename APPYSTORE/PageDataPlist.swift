//
//  PageDataPlist.swift
//  APPYSTORE
//
//  Created by ios_dev on 22/03/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import Foundation

class PageDataPlist {
    static var instance: PageDataPlist? = nil
    
    static func getInstance() -> PageDataPlist? {
        if PageDataPlist.instance == nil {
            instance = PageDataPlist()
        }
        return instance
    }
    
    func getPListPath() -> String {
        let plistFileName = "PageData"
        let plistPath: String? = Bundle.main.path(forResource: plistFileName, ofType: "plist")!
        return plistPath!
    }
    
    func getPreviousDataFetchTime(key: String) -> Int64 {
        let plistPath = self.getPListPath()
        if FileManager.default.fileExists(atPath: plistPath) {
            if let dic = NSDictionary(contentsOfFile: plistPath) as? [String: Any] {
                if dic[key] != nil {
                    return dic[key] as! Int64
                }
            }
        }
        return 0
    }
    
    func setPreviousDataFetchTime(key: String, value: Int64) {
        let plistPath = self.getPListPath()
        if FileManager.default.fileExists(atPath: plistPath) {
            let keyValue = NSMutableDictionary(contentsOfFile: plistPath)!
            keyValue.setValue(value, forKey: key)
            keyValue.write(toFile: plistPath, atomically: true)
        }
    }
    
    func setTotalContentCount(key: String, value: Int) {
        let plistPath = self.getPListPath()
        if FileManager.default.fileExists(atPath: plistPath) {
            let keyValue = NSMutableDictionary(contentsOfFile: plistPath)!
            keyValue.setValue(value, forKey: key)
            keyValue.write(toFile: plistPath, atomically: true)
        }
    }
    
    func getTotalContentCount(key: String) -> Int {
        let plistPath = self.getPListPath()
        if FileManager.default.fileExists(atPath: plistPath) {
            if let dic = NSDictionary(contentsOfFile: plistPath) as? [String: Any] {
                if dic[key] != nil {
                    return dic[key] as! Int
                }
            }
        }
        return 0
    }
    
    func setOffsetServer(key: String, value: Int) {
        let plistPath = self.getPListPath()
        if FileManager.default.fileExists(atPath: plistPath) {
            let keyValue = NSMutableDictionary(contentsOfFile: plistPath)!
            keyValue.setValue(value, forKey: key)
            keyValue.write(toFile: plistPath, atomically: true)
        }
    }
    
    func getOffsetServer(key: String) -> Int {
        let plistPath = self.getPListPath()
        if FileManager.default.fileExists(atPath: plistPath) {
            if let dic = NSDictionary(contentsOfFile: plistPath) as? [String: Any] {
                if dic[key] != nil {
                    return dic[key] as! Int
                }
            }
        }
        return 0
    }
    
    func clearAll() {
        let plistPath = self.getPListPath()
        if FileManager.default.fileExists(atPath: plistPath) {
            let rootDictionary = NSMutableDictionary(contentsOfFile: plistPath)!
            rootDictionary.removeAllObjects()
            rootDictionary.write(toFile: plistPath, atomically: true)
        }
    }
}
