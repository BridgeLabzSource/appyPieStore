//
//  ChildSelectionInChildProgressController.swift
//  APPYSTORE
//
//  Created by BridgeLabz Solution LLP on 11/05/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit

class ChildSelectionInChildProgressController: BaseListingViewController{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        var bundle = [String: Any]()
//        let videoCategoryModel = dataFetchFramework?.contentList[indexPath.row] as! VideoCategoryModel
//        bundle[BundleConstants.CATEGORY_ID] = videoCategoryModel.categoryId
//        bundle[BundleConstants.PARENT_CATEGORY_ID] = videoCategoryModel.parentCategoryId
//        bundle[BundleConstants.CATEGORY_NAME] = videoCategoryModel.categoryName
//        NavigationManager.openVideoListingPage(mainControllerCommunicator: mainControllerCommunicator, bundle: bundle)
    }
    
    override internal func getPageName() -> String {
        return PageConstants.SELECT_CHILD_LIST_PAGE
    }
    
    override func getDataSource() -> DataSource{
        return DataSource.SERVER
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (dataFetchFramework?.childList.count)!
    }
    
    
    //to be overridden if required
    override func getModelToFillCard(index: IndexPath) -> BaseModel {
        return (dataFetchFramework?.childList[index.row])!
    }
    
    override func viewDidLoad() {
        dataFetchFramework = DataFetchFramework(pageName: getPageName(), pageUniqueId: "",  bundle: bundle)
        super.viewDidLoad()
    }
    
    override func registerCard() {
        self.collectionView.register(UINib(nibName: "ChildProgress", bundle: nil), forCellWithReuseIdentifier: "ChildProgress")
    }
    
    override func getCell(indexPath: IndexPath) -> BaseCard {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "ChildProgress", for: indexPath) as! BaseCard
    }
    
    override func getComponentProperties() -> ComponentProperties {
        let components = ComponentProperties()
        components.visibleIconsSet = []
        
        return components
    }

    
    }
