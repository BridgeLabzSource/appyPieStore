//
//  SearchController.swift
//  APPYSTORE
//
//  Created by BridgeLabz Solution LLP on 04/03/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit

//class SearchResultPair {
//    var searchKeyword: String?
//    var dataFetchFramework: DataFetchFramework?
//}

class SearchResultController: BaseListingViewController {
    var searchKeyword = ""
    //var searchList: [SearchResultPair]? = []
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
        print("VideoListingController : select video \(videoListingModel.title)")
        
        if videoListingModel.payType == "paid" {
            NavigationManager.openTrialPopUp(mainControllerCommunicator: mainControllerCommunicator!)
        } else {
            NavigationManager.openVideoPlayerPage(mainControllerCommunicator: mainControllerCommunicator!, model: videoListingModel)
        }
    }
//    func doNewSearch(keyword: String) {
//    
//        if (isDuplicateKeyword(keyword: keyword)) {
//            print("Previously searched Keyword");
//        } else {
//            //todo
//            /*noDataFoundTv.setVisibility(View.GONE);
//            iFragmentController.showProgressBar(true);*/
//            addPreviousSearchResult();
//            if (isAlreadySearchedItem(keyword: keyword)) {
//                retrieveSearchResultFromSavedList(keyword: keyword);
//            } else {
//                startSearch(keyword: keyword)
//            }
//        }
//        //todo
//        //rcvMain.smoothScrollToPosition(0);
//    }
//    
//    func retrieveSearchResultFromSavedList(keyword: String) {
//        searchKeyword = keyword;
//        
//        for pair in searchList! {
//            if StringUtil.compareIgnoreCase(firstString: keyword, secondString: pair.searchKeyword) {
//                if (pair.dataFetchFramework?.isConnectionError)! {
//                    startSearch(keyword: pair.searchKeyword!)
//                } else {
//                    dataFetchFramework = pair.dataFetchFramework
//                    collectionView.reloadData()
//                    pageNameUniqueIdentifier = keyword
//                }
//            }
//        }
//        //todo
//        //iFragmentController.setActionUI(getActionButtonProperties());
//    }
//    
//    func startSearch(keyword: String) {
//        //todo
//        //rcvMain.setVisibility(View.GONE);
//        var bundle = [String: Any]()
//        bundle[BundleConstants.SEARCH_KEYWORD] = keyword
//        pageNameUniqueIdentifier = keyword;
//        dataFetchFramework =  DataFetchFramework(pageName: getPageName(), pageUniqueId: pageNameUniqueIdentifier!,  bundle: bundle)
//        dataFetchFramework?.reset()
//        dataFetchFramework?.start(dataSource: getDataSource())
//    }
//    
//    func isAlreadySearchedItem(keyword: String) -> Bool{
//        for pair in searchList! {
//            if StringUtil.compareIgnoreCase(firstString: keyword, secondString: pair.searchKeyword) {
//                return true
//            }
//        }
//        return false;
//    }
//    
//    func addPreviousSearchResult() {
//        let searchPair = SearchResultPair()
//        searchPair.searchKeyword = dataFetchFramework?.pageUniqueId;
//        searchPair.dataFetchFramework = dataFetchFramework;
//        searchList?.append(searchPair)
//    }
//    
//    func isDuplicateKeyword(keyword: String) -> Bool {
//        return StringUtil.compareIgnoreCase(firstString: keyword, secondString: getPageNameUniqueIdentifier())
//    }
//    
    override func getDataSource() -> DataSource{
        return DataSource.SERVER
    }

    override func getComponentProperties() -> ComponentProperties {
        let components = ComponentProperties()
        components.visibleIconsSet = [Item.BTN_BACK, Item.TF_SEARCH , Item.BTN_SEARCH]
        components.searchKeyword = searchKeyword
        return components
    }
//    
//    func onBackPressed() -> Bool {
//        if (searchList != nil && (searchList?.count)! > 0) {
//            searchKeyword = getLatestSearchKeyword(searchList: searchList!)!;
//            if (getLatestSearchFetchDataFramework(searchList: searchList!)?.isConnectionError)! {
//                startSearch(keyword: searchKeyword)
//            } else {
//                dataFetchFramework = getLatestSearchFetchDataFramework(searchList: searchList!)
//                pageNameUniqueIdentifier = searchKeyword
//                if ((dataFetchFramework?.contentList.count)! > 0) {
//                    //dataFetchFramework.setAdapter(fetchDataFramework.getContentList());
//                    collectionView.reloadData()
//                } else {
//                    //todo
//                    //noDataFoundTv.setVisibility(View.VISIBLE);
//                    //rcvMain.setVisibility(View.GONE);
//                }
//            }
//            //todo
//            //iFragmentController.setActionUI(getActionButtonProperties());
//            searchList?.removeLast()
//            return true
//        }
//    
//        return false
//    }
//    
//    func getLatestSearchKeyword(searchList: [SearchResultPair]) -> String? {
//        return searchList[searchList.count - 1].searchKeyword
//    }
//    
//    
//    func getLatestSearchFetchDataFramework(searchList: [SearchResultPair]) -> DataFetchFramework? {
//        return searchList[searchList.count - 1].dataFetchFramework
//    }

}
