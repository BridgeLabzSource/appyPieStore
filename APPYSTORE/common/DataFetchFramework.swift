//
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
    var totalCountOnServer = 0;
    var contentList: [BaseModel]

    var serverHandler : (String, AnyObject) -> () = {_ in}
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
        switch pageName {
        case PageConstants.VIDEO_PAGE:
            dataFetchTimePrefKey = PageConstants.KEY_VIDEO_CATEGORY_DATA_FETCH_TIME
            offsetServerPrefKey = PageConstants.KEY_VIDEO_CATEGORY_SERVER_OFFSET
            totalCountPrefKey = PageConstants.KEY_VIDEO_CATEGORY_TOTAL_CONTENT_COUNT
            
        case PageConstants.HISTORY_PAGE:
            dataFetchTimePrefKey = PageConstants.KEY_HISTORY_DATA_FETCH_TIME
            offsetServerPrefKey = PageConstants.KEY_HISTORY_SERVER_OFFSET
            totalCountPrefKey = PageConstants.KEY_HISTORY_TOTAL_CONTENT_COUNT
        default:
            break
        }
        
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
                self.contentList.append(contentsOf: data)
                self.serverHandler(DataFetchFramework.REQUEST_SUCCESS, data as AnyObject)
            } else {
                if self.offsetServer < self.totalCountOnServer && self.dataSource != .LOCAL {
                    self.callServerApiToFetchData()
                } else {
                    self.serverHandler(DataFetchFramework.END_OF_DATA, "" as AnyObject)
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
                serverHandler(DataFetchFramework.END_OF_DATA,"" as AnyObject)
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
        
        switch pageName {
            case PageConstants.HISTORY_PAGE:
                let historyDBManager = HistoryDBManager()
                count = historyDBManager.getRowCount()
            default:
                break
        }
        
        return count > 0
    }
    
    func getCurrentTimeInMilliseconds() -> Int64 {
        return Int64(Date().timeIntervalSince1970 * 1000)
    }
    
    func callServerApiToFetchData() {
        
        if  isTimeExpired() {
            isExistingDataDirty = true
            offsetServer = 0
        }
        
        DataManager.sharedInstance.getData(pageName: pageName, offset: offsetServer, limit: limit, returndata: {
            statusType, result in
            
            self.handleResponse(statusType: statusType, result: result)
        })
        
    }
    
    func handleResponse(statusType: String, result: AnyObject) {
        switch pageName {
            case PageConstants.HISTORY_PAGE:
                handleHistoryPageResponse(statusType: statusType, result: result)
            default:
                break
        }
    }
    
    func handleHistoryPageResponse(statusType: String, result: AnyObject) {
        
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
                    
                    if dataSource != .SERVER {
                        let historyDBManager = HistoryDBManager()
                        let record = historyDBManager.insertBulkRecords(userId: "107105246", childId: "29518", modelList: result)
                        
                        print("%d Records are inserted succefully..",record!)
                    }
                    
                    /*
                    let localdata = historyDBManager.fetchDataWithLimit(childId: "29518", offset: self.offsetLocal, limit: self.limit, bundle: nil)
                    */
                    self.totalCountOnServer = Int(resultModel.totalCount)!
                    self.saveTotalCountOnServer(totalCount: self.totalCountOnServer)
                    self.offsetServer += self.limit
                    self.saveOffsetServer(offsetServer: self.offsetServer)
                    contentList.append(contentsOf: result)
                    
                    if dataSource != .SERVER && isLocalDataAvailable() {
                        getDataFromLocalStorage()
                    } else {
                        self.serverHandler(statusType, result as AnyObject)
                    }
                }
            } else {
                self.serverHandler(DataFetchFramework.END_OF_DATA , "" as AnyObject)
            }
        } else {
            self.serverHandler(statusType, result)
        }
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
        //return true
        return ( getCurrentTimeInMilliseconds() - getPreviousDataFetchTime() ) > getDataFetchInterval()
    }
    
    func getPreviousDataFetchTime() -> Int64 {
        if let key = dataFetchTimePrefKey {
            return PageDataPref.getInstance()?.getPreviousDataFetchTime(key: key) ?? 0
        }
        
        return 0
    }
    
    func savePreviousDataFetchTime() {
        if let key = dataFetchTimePrefKey {
            PageDataPref.getInstance()?.setPreviousDataFetchTime(key: key, value: getCurrentTimeInMilliseconds())
        }
    }
    
    func getDataFetchInterval() -> Int64 {
        return Int64(Utils.DAY_IN_MILLIS)
    }
    
    func clearLocalData() {
        switch pageName {
        case PageConstants.HISTORY_PAGE:
            let historyDBManager = HistoryDBManager()
            historyDBManager.removeAll()
        default:
            break
            
        }
    }
    
}
