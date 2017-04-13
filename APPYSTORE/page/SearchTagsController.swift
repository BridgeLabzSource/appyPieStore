//
//  SearchTagsController.swift
//  APPYSTORE
//
//  Created by ios_dev on 07/04/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit

class SearchTagsController: BaseViewController {

    override internal func getPageName() -> String {
        return PageConstants.SEARCH_TAGS_PAGE
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func getComponentProperties() -> ComponentProperties {
        let components = ComponentProperties()
        components.visibleIconsSet = [Item.BTN_BACK, Item.TF_SEARCH, Item.BTN_SEARCH]
        
        return components
    }
}
