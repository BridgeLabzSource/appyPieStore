//
//  ChildProgressModel.swift
//  APPYSTORE
//
//  Created by BridgeLabz Solution LLP on 09/05/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import Foundation

class ChildProgressModel:BaseModel{
    
    public static let CONTENT_TYPE_AUDIO = "audios"
    public static let CONTENT_TYPE_VIDEO = "videos"

    public var count = ""
    public var parent_category_id = ""
    public var parent_category_name = ""
    public var category_id = ""
    public var category_name = ""
    public var content_type_id = ""
    public var content_type_label = ""
    public var trans_count = ""
}
