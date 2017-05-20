//
//  NavigationUtil.swift
//  APPYSTORE
//
//  Created by ios_dev on 17/04/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import Foundation

class NavigationUtil {
    
    static func navigateAsPerChildSize(mainControllerCommunicator: MainControllerCommunicator) {
        let x = UserInfo.getInstance().childList.count
        switch x {
        case 0:
            NavigationManager.openRegistrationPage(mainControllerCommunicator: mainControllerCommunicator, pageType: BundleConstants.PAGE_TYPE_REGISTER)
        case 1:
            //make sure selected child is not null
            UserInfo.getInstance().selectedChild = UserInfo.getInstance().childList[0]
            UserInfo.getInstance().saveUserInfoToUserDefaults()
            
            NavigationManager.openVideoCategoryPage(mainControllerCommunicator: mainControllerCommunicator)
        case _ where x >= 2:
            NavigationManager.openChildSelectionPage(mainControllerCommunicator: mainControllerCommunicator)
            break
        default:
            break
        }
    }
    
    static func handleLoginSuccessAfterOtpVerification(mainControllerCommunicator: MainControllerCommunicator) {
        var childList = UserInfo.getInstance().childList
        let selectedChild = UserInfo.getInstance().selectedChild
        
        if childList.isEmpty {
            //can be porting issue or trial subscription occurred from login page
            
            mainControllerCommunicator.clearBackStack()
            NavigationUtil.navigateAsPerChildSize(mainControllerCommunicator: mainControllerCommunicator)
        } else {
            if selectedChild == nil {
                // should not happen or trial subscription occurred from login page
                UserInfo.getInstance().selectedChild = childList[0]
                NavigationUtil.navigateAsPerChildSize(mainControllerCommunicator: mainControllerCommunicator)
            } else {
                handlePortedChild()
                NavigationUtil.clearChildSpecificData()
                mainControllerCommunicator.refreshAllPages()
            }
            NavigationManager.openTrialSuccessPopup(mainControllerCommunicator: mainControllerCommunicator)
        }
    }
    
    static func handlePortedChild() {
        var childList = UserInfo.getInstance().childList
        let selectedChild = UserInfo.getInstance().selectedChild
        
        var portedSelectedChild: ChildInfo? = nil
        
        //check if previous selected child exist in new child list
        for child in childList {
            if  selectedChild?.name == child.name {
                portedSelectedChild = child
                break
            }
        }
        
        if portedSelectedChild == nil {
            print("previous selected child didn't ported to new child list")
            UserInfo.getInstance().selectedChild = childList[0]
        } else {
            print("previous selected child ported successfully")
            //since child id may have changed after porting hence reassignment is necessary
            UserInfo.getInstance().selectedChild = portedSelectedChild
        }
    }
    
    // if a child is upadated or changed, all pages data must be reset
    static func onChildChangeOrUpdate(currentChild: ChildInfo) {
        UserInfo.getInstance().selectedChild = currentChild
        UserInfo.getInstance().saveUserInfoToUserDefaults()
        
        //clear child specific data
        clearChildSpecificData()
    }
    
    static func clearChildSpecificData() {
        PageDataPlist.getInstance()?.clearAll()
        
        VideoDBManager.sharedInstance.clearTable(bundle: nil)
        VideoListingDBManager.sharedInstance.clearTable(bundle: nil)
        HistoryDBManager.sharedInstance.clearTable(bundle: nil)
        //todo delete from remaining tables
        
//        DBVideoCategoryManager.getInstance().clearTable();
//        DBVideoListingManager.getInstance().clearTable();
//        DBHistoryManager.getInstance().clearTable();
//        DBParentingVideoCategoryManager.getInstance().clearTable();
//        DBAudioCategoryManager.getInstance().clearTable();
//        DBAudioListingManager.getInstance().clearTable();
    }
}
