//
//  SearchController.swift
//  APPYSTORE
//
//  Created by BridgeLabz Solution LLP on 04/03/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit

class SearchResultController: BaseListingViewController {
    var searchKeyword = ""
    
    override internal func getPageName() -> String {
        return PageConstants.SEARCH_RESULT_PAGE
    }
    
    override func viewDidLoad() {
        searchKeyword = bundle?[BundleConstants.SEARCH_KEYWORD] as! String
        dataFetchFramework = DataFetchFramework(pageName: getPageName(), pageUniqueId: "",  bundle: bundle)
        super.viewDidLoad()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let videoListingModel = dataFetchFramework?.contentList[indexPath.row] as! VideoListingModel
        
        if videoListingModel.payType == "paid" {
            let bundle = [String: Any]()
            NavigationManager.openTrialPopUp(mainControllerCommunicator: mainControllerCommunicator!, bundle: bundle)
        } else {
            NavigationManager.openVideoPlayerPage(mainControllerCommunicator: mainControllerCommunicator!, model: videoListingModel)
        }
    }

    override func getDataSource() -> DataSource{
        return DataSource.SERVER
    }

    override func handleRequestFailure() {
        mainControllerCommunicator?.showCenterText(text: "NO_RESULT_FOUND".localized(lang: AppConstants.LANGUAGE))
    }
    
    override func getComponentProperties() -> ComponentProperties {
        let components = ComponentProperties()
        components.visibleIconsSet = [Item.BTN_BACK, Item.TF_SEARCH , Item.BTN_SEARCH]
        components.searchKeyword = searchKeyword
        return components
    }

}
