//
//  AuthenticationUtil.swift
//  APPYSTORE
//
//  Created by ios_dev on 03/05/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import Foundation

class AuthenticationUtil {
    
    static func isSubscribedUser() -> Bool {
        return UserInfo.USER_TYPE_CLOSED == UserInfo.getInstance().type
    }
    
    static func clearDataAfterSubscription() {
        
    }

}
