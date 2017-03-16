//
//  PreChatFormField.swift
//  APPYSTORE
//
//  Created by gaurav on 13/03/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import Foundation

class PreChatFormField{
    static let NOT_REQUIRED = "NOT_REQUIRED"
    static let OPTIONAL = "OPTIONAL"
    static let REQUIRED = "REQUIRED"
    static let OPTIONAL_EDITABLE = "OPTIONAL_EDITABLE"
    static let REQUIRED_EDITABLE = "REQUIRED_EDITABLE"
    
    var name: String?
    var email: String?
    var phone: String?
    var message: String?
    var nameField: String?
    var emailField: String?
    var phoneField: String?
    var messageField: String?
    var isAutoSendMessage = false
    var isEnable = false
}
