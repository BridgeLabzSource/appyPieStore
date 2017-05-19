//
//  AppConfigurationHandler.swift
//  APPYSTORE
//
//  Created by ios_dev on 10/05/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit

class AppConfigurationHandler {
    func start() {
        setVendorId()
        
    }
    
    func setVendorId() {
        var vendorId: String? = KeychainManager.getVendorId()
        if(vendorId == nil || vendorId?.characters.count == 0) {
            vendorId = UIDevice.current.identifierForVendor?.uuidString
            KeychainManager.saveVendorId(value: vendorId! as NSString)
        }
        print("vendorID:" + vendorId!)
        
        //hardcode this value to treat as a new user
        AppConstants.VENDOR_ID = vendorId
    }
}
