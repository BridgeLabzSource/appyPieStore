//
//  VideoController.swift
//  APPYSTORE
//
//  Created by BridgeLabz on 02/03/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class VideoCategoryController: BaseListingViewController {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var bundle = [String: Any]()
        let videoCategoryModel = dataFetchFramework?.contentList[indexPath.row] as! VideoCategoryModel
        bundle[BundleConstants.CATEGORY_ID] = videoCategoryModel.categoryId
        bundle[BundleConstants.PARENT_CATEGORY_ID] = videoCategoryModel.parentCategoryId
        bundle[BundleConstants.CATEGORY_NAME] = videoCategoryModel.categoryName
        NavigationManager.openVideoListingPage(mainControllerCommunicator: mainControllerCommunicator, bundle: bundle)
    }

    override internal func getPageName() -> String {
        return PageConstants.VIDEO_CATEGORY_PAGE
    }
    
    override func viewDidLoad() {
        dataFetchFramework = DataFetchFramework(pageName: getPageName(), pageUniqueId: "",  bundle: bundle)
        super.viewDidLoad()
    }
    
    override func registerCard() {
        self.collectionView.register(UINib(nibName: "VideoCategoryCard", bundle: nil), forCellWithReuseIdentifier: "VideoCategoryCard")
    }
    
    override func getCell(indexPath: IndexPath) -> BaseCard {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCategoryCard", for: indexPath) as! BaseCard
    }
    
    override func getComponentProperties() -> ComponentProperties {
        let components = ComponentProperties()
        components.visibleIconsSet = [Item.IV_CHILD, Item.BTN_VIDEO, Item.BTN_AUDIO, Item.BTN_HISTORY , Item.BTN_SEARCH,Item.IMG_CHILD]
        components.selectedIconsSet = [Item.BTN_VIDEO]
        
        return components
    }
}

