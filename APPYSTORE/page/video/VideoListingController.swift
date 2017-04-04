//
//  VideoListingController.swift
//  APPYSTORE
//
//  Created by ios_dev on 28/03/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit

class VideoListingController: BaseListingViewController {

    override func viewDidLoad() {
        dataFetchFramework = DataFetchFramework(pageName: PageConstants.VIDEO_LISTING_PAGE)
        super.viewDidLoad()
    }
}
