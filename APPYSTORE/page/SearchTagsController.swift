//
//  SearchTagsController.swift
//  APPYSTORE
//
//  Created by ios_dev on 07/04/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit

class SearchTagsController: BaseListingViewController {

    @IBOutlet weak var lblTitle: UILabel!
    override internal func getPageName() -> String {
        return PageConstants.SEARCH_TAGS_PAGE
    }
    
    override func viewDidLoad() {
        dataFetchFramework = DataFetchFramework(pageName: getPageName(), pageUniqueId: "",  bundle: bundle)
        
        DimensionManager.setTextSize1280x720(label: lblTitle, size: DimensionManager.H2)
        super.viewDidLoad()
    }
    
    override func setScrollDirection() {
        self.collectionView.setScrollDirectionVertical()
    }
    
    override func registerCard() {
        self.collectionView.register(UINib(nibName: "TagsCard", bundle: nil), forCellWithReuseIdentifier: "TagsCard")
    }
    
    override func getCell(indexPath: IndexPath) -> BaseCard {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "TagsCard", for: indexPath) as! BaseCard
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let searchTagsModel = dataFetchFramework?.contentList[indexPath.row] as! SearchTagsModel
        NavigationManager.openSearchResultPage(mainControllerCommunicator: mainControllerCommunicator!, keyword: searchTagsModel.searchName!)
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let searchTagsModel = (dataFetchFramework?.contentList[indexPath.row])! as! SearchTagsModel
        let font = UIFont(name: AppConstants.APP_FONT_NAME, size: DimensionManager.H3)
        
        let width = searchTagsModel.searchName!.widthOfString(usingFont: font!)
        let height = searchTagsModel.searchName!.heightOfString(usingFont: font!)
        
        
        return CGSize(width: width, height: height);
    }
    
    override func getComponentProperties() -> ComponentProperties {
        let components = ComponentProperties()
        components.visibleIconsSet = [Item.BTN_BACK, Item.TF_SEARCH, Item.BTN_SEARCH]
        
        return components
    }
}
