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
        let x = (UserInfo.getInstance().childList?.count)!
        switch x {
        case 0:
            NavigationManager.openRegistrationPage(mainControllerCommunicator: mainControllerCommunicator, pageType: BundleConstants.PAGE_TYPE_REGISTER)
        case 1:
            NavigationManager.openVideoCategoryPage(mainControllerCommunicator: mainControllerCommunicator)
        case _ where x > 2:
            NavigationManager.openChildSelectionPage(mainControllerCommunicator: mainControllerCommunicator)
            break
        default:
            break
        }
        
        //NavigationManager.openRegistrationPage(mainControllerCommunicator: mainControllerCommunicator, pageType: BundleConstants.PAGE_TYPE_REGISTER)
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
