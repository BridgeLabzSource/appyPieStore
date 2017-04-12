//
//  SearchController.swift
//  APPYSTORE
//
//  Created by BridgeLabz Solution LLP on 04/03/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit

class SearchResultPair {
//    init() {
//        
//    }
    var searchKeyword: String?
    var dataFetchFramework: DataFetchFramework?
}

class SearchResultController: BaseListingViewController {
    var searchKeyword = ""
    var searchList: [SearchResultPair] = []
    override internal func getPageName() -> String {
        return PageConstants.SEARCH_RESULT_PAGE
    }
    
    override func viewDidLoad() {
        dataFetchFramework = DataFetchFramework(pageName: getPageName(), pageUniqueId: "",  bundle: bundle)
        super.viewDidLoad()
    }
    
    /*func doNewSearch(keyword: String) {
    
        if (isDuplicateKeyword(keyword)) {
            print("Previously searched Keyword");
        } else {
            //todo
            /*noDataFoundTv.setVisibility(View.GONE);
            iFragmentController.showProgressBar(true);*/
            addPreviousSearchResult();
            if (isAlreadySearchedItem(keyword)) {
                retrieveSearchResultFromSavedList(keyword);
            } else {
                startSearch(keyword);
            }
        }
        rcvMain.smoothScrollToPosition(0);
    }
    
    func addPreviousSearchResult() {
        let searchPair = SearchResultPair()
        searchPair.searchKeyword = (dataFetchFramework.getFetchDataCommunicator().getPageNameUniqueIdentifier());
        searchPair.setFetchDataFramework(fetchDataFramework);
        searchList.add(searchPair);
    }
    
    func isDuplicateKeyword(keyword: String) -> Bool {
        retrun StringUtil.compareIgnoreCase(firstString: keyword, secondString: getPageNameUniqueIdentifier())
    }*/
    
    override func getDataSource() -> DataSource{
        return DataSource.SERVER
    }
    
    override func getComponentProperties() -> ComponentProperties {
        let components = ComponentProperties()
        components.visibleIconsSet = [Item.BTN_BACK, Item.TF_SEARCH , Item.BTN_SEARCH]
        return components
    }

}
