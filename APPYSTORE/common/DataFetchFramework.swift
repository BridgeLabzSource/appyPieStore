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
    var offsetLocal = 0
    var offsetServer = 0
    var limit = 20
    var totalCountOnServer = -1;
    var contentList: [BaseModel]
    
    var onDataReceived : (String, AnyObject) -> () = {_ in}
    var isExistingDataDirty = false
    var dataFetchTimePrefKey: String?
    var offsetServerPrefKey: String?
    var totalCountPrefKey: String?
    
    static let REQUEST_FAILURE = "REQUEST_FAILURE"
    static let REQUEST_SUCCESS = "REQUEST_SUCCESS"
    static let CONNECTION_ERROR = "CONNECTION_ERROR"
    static let END_OF_DATA = "END_OF_DATA"
    var dataSource: DataSource?
    
    
    init(pageName: String) {
        self.pageName = pageName
        contentList = []
        fetchPrefsKey()
    }
    
    
    func fetchPrefsKey() {
        dataFetchTimePrefKey = DataManager.getDataFetchTimePrefKey(pageName: pageName)
        offsetServerPrefKey = DataManager.getOffsetServerPrefKey(pageName: pageName)
        totalCountPrefKey = DataManager.getTotalCountPrefKey(pageName: pageName)
    }
    
    func reset() {
        resetPrefsAndVariables()
        clearLocalData()
    }
    
    func resetPrefsAndVariables() {
        contentList.removeAll()
        
        offsetLocal = 0
        offsetServer = 0
        totalCountOnServer = 0
        
        if let key = dataFetchTimePrefKey {
            PageDataPref.getInstance()?.setPreviousDataFetchTime(key: key, value: 0)
        }
        
        if let key = offsetServerPrefKey {
            PageDataPref.getInstance()?.setOffsetServer(key: key, value: 0)
        }
        
        if let key = totalCountPrefKey {
            PageDataPref.getInstance()?.setTotalContentCount(key: key, value: 0)
        }
    }
    
    func getDataFromLocalStorage() {
        DataManager.sharedInstance.getLocalData(pageName: pageName, offset: offsetLocal, limit: limit, completion: {
            result in
            
            if let data = result, (result?.count)! > 0 {
                self.offsetLocal += self.limit
                self.addToContentList(contentList: data)
                self.onDataReceived(DataFetchFramework.REQUEST_SUCCESS, self.contentList as AnyObject)
            } else {
                if self.offsetServer < self.totalCountOnServer && self.dataSource != .LOCAL {
                    self.callServerApiToFetchData()
                } else {
                    self.onDataReceived(DataFetchFramework.END_OF_DATA, "" as AnyObject)
                }
            }
            
        })
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
        count = DataManager.sharedInstance.getRowCountForPage(pageName: pageName)
        return count > 0
    }
    
    func callServerApiToFetchData() {
        
        if totalCountOnServer != -1 && offsetServer >= totalCountOnServer {
            self.handleResponse(statusType: DataFetchFramework.END_OF_DATA, result: "" as AnyObject)
        } else {
            if  isTimeExpired() {
                isExistingDataDirty = true
                offsetServer = 0
            }
            print("Ganesh Server offsetServer : \(offsetServer) limit : \(limit)")
            DataManager.sharedInstance.getData(pageName: pageName, offset: offsetServer, limit: limit, returndata: {
                statusType, result in
                
                self.handleResponse(statusType: statusType, result: result)
            })
        }
    }
    
    func handleResponse(statusType: String, result: AnyObject) {
        if statusType == DataFetchFramework.REQUEST_SUCCESS {
            if let resultModel = result as? ContentListingApiResponseModel {
                if !resultModel.contentList.isEmpty {
                    let result = resultModel.contentList
                    
                    if self.isExistingDataDirty {
                        self.resetPrefsAndVariables()
                        self.savePreviousDataFetchTime()
                        clearLocalData()
                        
                        self.isExistingDataDirty = false
                    }
                    print("Ganesh Server response count : \(result.count) ")
                    if dataSource != .SERVER {
                        saveDataToLocalStorage(dataList: result)
                    }
                    
                    self.totalCountOnServer = Int(resultModel.totalCount)!
                    self.saveTotalCountOnServer(totalCount: self.totalCountOnServer)
                    self.offsetServer += self.limit
                    self.saveOffsetServer(offsetServer: self.offsetServer)
                    addToContentList(contentList: result)
                    
                    if dataSource != .SERVER && isLocalDataAvailable() {
                        getDataFromLocalStorage()
                    } else {
                        self.onDataReceived(statusType, contentList as AnyObject)
                    }
                } else {
                    self.onDataReceived(DataFetchFramework.REQUEST_FAILURE , result)
                }
            } else {
                self.onDataReceived(DataFetchFramework.REQUEST_FAILURE , result)
            }
        } else {
            if dataSource == .BOTH && isLocalDataAvailable() {
                getDataFromLocalStorage()
            } else {
                self.onDataReceived(statusType, result)
            }
        }
    }
    
    func saveDataToLocalStorage(dataList: [BaseModel]) {
        _ = DataManager.sharedInstance.saveDataForPage(pageName: pageName, dataList: dataList)
    }
    
    func saveOffsetServer(offsetServer: Int) {
        if let key = offsetServerPrefKey {
            PageDataPref.getInstance()?.setOffsetServer(key: key, value: offsetServer)
        }
    }
    
    func saveTotalCountOnServer(totalCount: Int) {
        if let key = totalCountPrefKey {
            PageDataPref.getInstance()?.setTotalContentCount(key: key, value: totalCount)
        }
    }
    
    func isTimeExpired() -> Bool {
        return ( Utils.getCurrentTimeInMilliseconds() - getPreviousDataFetchTime() ) > getDataFetchInterval()
    }
    
    func getPreviousDataFetchTime() -> Int64 {
        if let key = dataFetchTimePrefKey {
            return PageDataPref.getInstance()?.getPreviousDataFetchTime(key: key) ?? 0
        }
        
        return 0
    }
    
    func savePreviousDataFetchTime() {
        if let key = dataFetchTimePrefKey {
            PageDataPref.getInstance()?.setPreviousDataFetchTime(key: key, value: Utils.getCurrentTimeInMilliseconds())
        }
    }
    
    func getDataFetchInterval() -> Int64 {
        return Int64(Utils.DAY_IN_MILLIS)
    }
    
    func clearLocalData() {
        DataManager.sharedInstance.deleteDataForPage(pageName: pageName)
    }
    
    func addToContentList(contentList: [BaseModel]) {
        if contentList.count > 0 {
            self.contentList.append(contentsOf: contentList)
        }
    }
    
}
