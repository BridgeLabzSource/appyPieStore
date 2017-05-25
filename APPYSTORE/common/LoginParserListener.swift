//
//  LoginParserListener.swift
//  APPYSTORE
//
//  Created by ios_dev on 16/03/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import Foundation

protocol LoginParserListener: ParserListener {
    func userIdChanged(userInfoOld: UserInfo?)
    func userTypeChanged(userInfoOld: UserInfo?)
}
