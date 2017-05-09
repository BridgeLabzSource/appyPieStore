//
//  AudioListingModel.swift
//  APPYSTORE
//
//  Created by BridgeLabz Solutions LLP  on 5/8/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import Foundation

class AudioListingModel: BaseModel{
    //TODO header and headerTitle Diff???
    public var header=""
    public var title = ""
    //TODO isFeatchedFromDb to be removed after verification
    public var parentCategoryTitle = ""
    public var parentCategoryId = ""
    public var subCategoryId = ""
    public var subCategoryTitle = ""
    public var minAge = ""
    public var maxAge = ""
    public var cdnUrl = ""
    public var versionId = ""
    //TODO itemRC to be removed after verification
    public var itemRC = [-1,-1]
    public var childId = ""
    public var count = ""
    //TODO contentTypeId and contentId Diff???
    public var contentTypeId = ""
    public var contentId = ""
    public var contentTypeLable = ""
    public var buildId = ""
    public var imagePath = ""
    public var contentDuration = ""
    public var downloadUrl = ""
    public var downloadStatus = "0"
    public var downloadedFilePath = ""
    public var payType = ""
    public var sequenceType = ""
    public var sequenceNumber = ""
    public var groupId = ""
   // public var isAudioDownloadable:Bool = true
    public var isSelected:Bool = false
    public var canonicalName = ""
    
}
