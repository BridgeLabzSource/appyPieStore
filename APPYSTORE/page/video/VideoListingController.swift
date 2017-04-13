//
//  VideoListingController.swift
//  APPYSTORE
//
//  Created by ios_dev on 28/03/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit

class VideoListingController: BaseListingViewController {
    var catId: String = ""
    var catName: String = ""
    var pCatId: String = ""

    override internal func getPageName() -> String {
        return PageConstants.VIDEO_LISTING_PAGE
    }
    
    override func viewDidLoad() {
        self.catId = bundle?[BundleConstants.CATEGORY_ID] as! String
        self.pCatId = bundle?[BundleConstants.PARENT_CATEGORY_ID] as! String
        self.catName = bundle?[BundleConstants.CATEGORY_NAME] as! String
        dataFetchFramework = DataFetchFramework(pageName: PageConstants.VIDEO_LISTING_PAGE, pageUniqueId: catName, bundle: bundle)
        super.viewDidLoad()
    }
}
