//
//  ParserListener.swift
//  APPYSTORE
//
//  Created by ios_dev on 16/03/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import Foundation

protocol ParserListener {
    func onSuccess(object: AnyObject?)
    func onFailure(errorMessage: String?)
    func onConnectionError()
}
