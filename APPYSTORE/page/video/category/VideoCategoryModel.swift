//
//  VideoCategoryModel.swift
//  APPYSTORE
//
//  Created by BridgeLabz on 07/03/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import Foundation

class VideoCategoryModel: BaseModel
{
    public var categoryId: String
    public var categoryName: String
    public var contentCount: String
    public var imagePath: String
    public var parentCategoryId: String
    public var isCategoryBlocked: String
    public var parentCategoryName: String
    public var canonicalName: String
    public var isVisible: String
}
