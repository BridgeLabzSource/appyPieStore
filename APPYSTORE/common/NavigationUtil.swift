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
            break
        case _ where x > 2:
            break
        default:
            break
        }
    }
}
