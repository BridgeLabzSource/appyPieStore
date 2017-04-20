//
//  AppNavigationHandler.swift
//  APPYSTORE
//
//  Created by ios_dev on 17/04/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import Foundation
class AppNavigationHandler {
    let mainControllerCommunicator: MainControllerCommunicator
    
    init(mainControllerCommunicator: MainControllerCommunicator) {
        self.mainControllerCommunicator = mainControllerCommunicator
    }
    
    func NavigateAtAppOpen() {
        if(isFromGcmNotification() || isFromDeepLinkedUrl() || isFromDownloadNotification()) {
            
        } else {
            handleDefaultLoginFlow()
        }
    }
    
    func isFromGcmNotification() -> Bool {
        return false
    }
    
    func isFromDeepLinkedUrl() -> Bool {
        return false
    }
    
    func isFromDownloadNotification() -> Bool {
        return false
    }
    
    func handleDefaultLoginFlow() {
        //todo proper params
        LoginParser().parse(params: HttpRequestBuilder.getLoginParameters(method: LoginParser.METHOD_NAME, msisdn: "", pageId: "login", emailId: ""), completion: {
            statusType, result in
            if statusType == DataFetchFramework.REQUEST_SUCCESS {
                NavigationUtil.navigateAsPerChildSize(mainControllerCommunicator: self.mainControllerCommunicator)
                
                //self.mainControllerCommunicator.getContext().uiDelegate?.showVideoCategoryPage()

            } else if statusType == DataFetchFramework.REQUEST_FAILURE {
                
            } else if statusType == DataFetchFramework.CONNECTION_ERROR {
                
            }
        })
    }
}
