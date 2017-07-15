//
//  AudioCategoryModel.swift
//  APPYSTORE
//
//  Created by BridgeLabz Solutions LLP  on 5/5/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import Foundation

class AudioCategoryModel: BaseModel
{
    public var categoryId: String = ""
    public var categoryName: String = ""
    public var contentCount: String = ""
    public var imagePath: String = ""
    public var parentCategoryId: String = ""
    public var isCategoryBlocked: String = ""
    public var parentCategoryName: String = ""
    public var canonicalName: String = ""
    public var isVisible: String = ""
}
