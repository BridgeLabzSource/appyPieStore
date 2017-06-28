//
//  ComponentProperties.swift
//  APPYSTORE
//
//  Created by ios_dev on 07/04/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import Foundation

enum Item {
    case BTN_BACK; case BTN_SEARCH; case BTN_FAB; case BTN_CART; case BTN_VIDEO; case BTN_AUDIO;case BTN_HISTORY; case BTN_WORKSHEET; case TV_PAGE_TITLE; case TF_SEARCH; case IV_CHILD; case IMG_CHILD
}

enum FabItem {
    case FAB_SOUND; case FAB_RCB; case FAB_CHAT; case FAB_SHARE; case FAB_PARENTING_VIDEOS; case FAB_PROFILE; case FAB_WRITE_TO_US
}

class ComponentProperties {
    
    var visibleIconsSet = Set<Item>()
    var invisibleIconsSet = Set<Item>()
    var selectedIconsSet = Set<Item>()
    var pageTitle: String = ""
    var searchKeyword: String = ""
    var fabItemsSet = Set<FabItem>()
    var doNothing: Bool = false
    var disableAllComponents: Bool = false
    
}


