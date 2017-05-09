//  DataFetchFramework.swift
//  APPYSTORE
//
//  Created by ios_dev on 20/03/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//
import Foundation

enum DataSource {
    case LOCAL
    case SERVER
    case BOTH
}

class DataFetchFramework {
    var pageName: String
    var pageUniqueId: String
    var offsetLocal = 0
    var offsetServer = 0
    var limit = 20
    var totalCountOnServer = -1
    var contentList: [BaseModel]
    
    var onDataReceived : (String, AnyObject) -> () = {_ in}
    var isExistingDataDirty = false
    var dataFetchTimePrefKey: String?
    var offsetServerPrefKey: String?
    var totalCountPrefKey: String?
    
    static let END_OF_DATA = "END_OF_DATA"
    
    var dataSource: DataSource?
    var bundle: AndroidBundle
    
    init(pageName: String, pageUniqueId: String, bundle: AndroidBundle) {
        self.pageName = pageName
        self.pageUniqueId = pageUniqueId
        self.bundle = bundle
        contentList = []
        fetchPrefsKey()
        offsetServer = getOffsetServerFromPrefs()
        totalCountOnServer = getTotalCountOnServerFromPrefs()
    }
    
    func getOffsetServerFromPrefs() -> Int {
        if let key = offsetServerPrefKey {
            return (PageDataPlist.getInstance()?.getOffsetServer(key: key))!
        }
        
        return 0
    }
    
    func getTotalCountOnServerFromPrefs() -> Int {
        if let key = totalCountPrefKey {
            let value = (PageDataPlist.getInstance()?.getTotalContentCount(key: key))!
            if value == 0 {
                return -1
            } else {
                return value
            }
        }
        
        return -1
    }
    
    func fetchPrefsKey() {
        dataFetchTimePrefKey = DataManager.getDataFetchTimePrefKey(pageName: pageName, pageUniqueId: pageUniqueId)
        offsetServerPrefKey = DataManager.getOffsetServerPrefKey(pageName: pageName, pageUniqueId: pageUniqueId)
        totalCountPrefKey = DataManager.getTotalCountPrefKey(pageName: pageName, pageUniqueId: pageUniqueId)
    }
    
    func reset() {
        resetPrefsAndVariables()
        clearLocalData()
    }
    
    func resetPrefsAndVariables() {
        contentList.removeAll()
        
        offsetLocal = 0
        offsetServer = 0
        totalCountOnServer = -1
        
        if let key = dataFetchTimePrefKey {
            PageDataPlist.getInstance()?.setPreviousDataFetchTime(key: key, value: 0)
        }
        
        if let key = offsetServerPrefKey {
            PageDataPlist.getInstance()?.setOffsetServer(key: key, value: 0)
        }
        
        if let key = totalCountPrefKey {
            PageDataPlist.getInstance()?.setTotalContentCount(key: key, value: -1)
        }
    }
    
    func getDataFromLocalStorage() {
        print("getDataFromLocalStorage called offsetLocal: \(offsetLocal)")
        if(DataManager.sharedInstance.getRowCountForPage(pageName: pageName, bundle: bundle) >= offsetLocal) {
            DataManager.sharedInstance.getLocalData(pageName: pageName, offset: offsetLocal, limit: limit, bundle: bundle, completion: {
                result in
                
                if let data = result, (result?.count)! > 0 {
                    self.offsetLocal += self.limit
                    self.addToContentList(contentList: data)
                    self.onDataReceived(BaseParser.REQUEST_SUCCESS, self.contentList as AnyObject)
                } else {
                    if self.offsetServer < self.totalCountOnServer && self.dataSource != .LOCAL {
                        self.callServerApiToFetchData()
                    } else {
                        self.onDataReceived(DataFetchFramework.END_OF_DATA, "" as AnyObject)
                    }
                }
                
            })
        } else {
            self.onDataReceived(DataFetchFramework.END_OF_DATA, "" as AnyObject)
        }
    }
    
    func start(dataSource: DataSource) {
        self.dataSource = dataSource
        switch dataSource {
        case .LOCAL:
            if isLocalDataAvailable() {
                getDataFromLocalStorage()
            } else {
                onDataReceived(DataFetchFramework.END_OF_DATA,"" as AnyObject)
            }
            
        case .SERVER:
            callServerApiToFetchData()
        case .BOTH:
            if isLocalDataAvailable() {
                if isTimeExpired() {
                    callServerApiToFetchData()
                } else {
                    getDataFromLocalStorage()
                }
            } else {
                callServerApiToFetchData()
            }
            
        }
    }
    
    func isLocalDataAvailable() -> Bool {
        var count = 0
        count = DataManager.sharedInstance.getRowCountForPage(pageName: pageName, bundle: bundle)
        print("isLocalDataAvailable count \(count)")
        return count > 0
    }
    
    func callServerApiToFetchData() {
        print("callServerApiToFetchData called offsetServer: \(offsetServer)")
//        if totalCountOnServer != -1 && offsetServer >= totalCountOnServer {
//            self.handleResponse(statusType: DataFetchFramework.END_OF_DATA, result: "" as AnyObject)
//        } else {
            if self.dataSource != DataSource.SERVER && isTimeExpired() {
                isExistingDataDirty = true
                offsetServer = 0
                print("TimeExpired hence offsetServer: \(offsetServer)")
            }
           DataManager.sharedInstance.getData(pageName: pageName, offset: offsetServer, limit: limit, bundle: bundle, returndata: {
                statusType, result in
                
                self.handleResponse(statusType: statusType, result: result)
            })
    //    }
    }
    
    func handleResponse(statusType: String, result: AnyObject) {
        if statusType == BaseParser.REQUEST_SUCCESS {
            if let resultModel = result as? ContentListingApiResponseModel {
                if !resultModel.contentList.isEmpty {
                    let result = resultModel.contentList
                    
                    if self.isExistingDataDirty {
                        self.resetPrefsAndVariables()
                        self.savePreviousDataFetchTime()
                        clearLocalData()
                        
                        self.isExistingDataDirty = false
                    }
                    print("handleResponse Server data count : \(result.count) ")
                    if dataSource != .SERVER {
                        saveDataToLocalStorage(dataList: result)
                    }
                    
                    self.totalCountOnServer = Int(resultModel.totalCount)!
                    self.saveTotalCountOnServer(totalCount: self.totalCountOnServer)
                    self.offsetServer += self.limit
                    self.saveOffsetServer(offsetServer: self.offsetServer)
                    //addToContentList(contentList: result)
                    
                    if dataSource != .SERVER && isLocalDataAvailable() {
                        getDataFromLocalStorage()
                    } else {
                        addToContentList(contentList: result)
                        self.onDataReceived(statusType, contentList as AnyObject)
                    }
                } else {
                    self.onDataReceived(BaseParser.REQUEST_FAILURE , result)
                }
            } else {
                self.onDataReceived(BaseParser.REQUEST_FAILURE , result)
            }
        } else {
            //if due to some reason server fails to repond data, atleast show data from local storage if available
            if statusType == BaseParser.CONNECTION_ERROR || statusType == BaseParser.REQUEST_FAILURE {
                if dataSource == .BOTH && isLocalDataAvailable() {
                    getDataFromLocalStorage()
                } else {
                    self.onDataReceived(statusType, result)
                }
            } else {
                self.onDataReceived(DataFetchFramework.END_OF_DATA, result)
            }
        }
    }
    
    func saveDataToLocalStorage(dataList: [BaseModel]) {
        _ = DataManager.sharedInstance.saveDataForPage(pageName: pageName, dataList: dataList)
    }
    
    func saveOffsetServer(offsetServer: Int) {
        if let key = offsetServerPrefKey {
            PageDataPlist.getInstance()?.setOffsetServer(key: key, value: offsetServer)
        }
    }
    
    func saveTotalCountOnServer(totalCount: Int) {
        if let key = totalCountPrefKey {
            PageDataPlist.getInstance()?.setTotalContentCount(key: key, value: totalCount)
        }
    }
    
    func isTimeExpired() -> Bool {
        let isTimeExpired = ( Utils.getCurrentTimeInMilliseconds() - getPreviousDataFetchTime() ) > getDataFetchInterval()
        print("isTimeExpired \(isTimeExpired)")
        return isTimeExpired
    }
    
    func getPreviousDataFetchTime() -> Int64 {
        if let key = dataFetchTimePrefKey {
            return PageDataPlist.getInstance()?.getPreviousDataFetchTime(key: key) ?? 0
        }
        
        return 0
    }
    
    func savePreviousDataFetchTime() {
        if let key = dataFetchTimePrefKey {
            PageDataPlist.getInstance()?.setPreviousDataFetchTime(key: key, value: Utils.getCurrentTimeInMilliseconds())
        }
    }
    
    func getDataFetchInterval() -> Int64 {
        return Int64(Utils.DAY_IN_MILLIS)
    }
    
    func clearLocalData() {
        print("clearLocalData called")
        DataManager.sharedInstance.deleteDataForPage(pageName: pageName, bundle: bundle)
    }
    
    func addToContentList(contentList: [BaseModel]) {
        if contentList.count > 0 {
            self.contentList.append(contentsOf: contentList)
        }
    }
    
    func updateBundle(keys:[String], values: [Any]) {
        var i = 0
        for key in keys {
            bundle?[key] = values[i]
            i += 1
        }
    }
    
}
