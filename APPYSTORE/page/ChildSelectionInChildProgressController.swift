//
//  ChildSelectionInChildProgressController.swift
//  APPYSTORE
//
//  Created by BridgeLabz Solution LLP on 11/05/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit

class ChildSelectionInChildProgressController: BaseListingViewController{
    
    
    
    override func viewDidLoad() {
        
        dataFetchFramework = DataFetchFramework(pageName: getPageName(), pageUniqueId: "",  bundle: bundle)
        super.viewDidLoad()
    }
    
    
        override internal func getPageName() -> String {
        return PageConstants.SELECT_CHILD_LIST_PAGE
    }
    
    
    override internal func getPageNameUniqueIdentifier() -> String {
        return ""
    }
   
    
    // Overridden
    override func setScrollDirection() {
        self.collectionView.setScrollDirectionHorizontal()
    }
    

    override func getDataSource() -> DataSource{
        return DataSource.LOCAL
    }
    
    override func registerCard() {
       self.collectionView.register(UINib(nibName: "ChildProgress", bundle: nil), forCellWithReuseIdentifier: "ChildProgress")
        
    }
    
 
    override func getModelToFillCard(index: IndexPath) -> BaseModel {
        
        let childModel = (dataFetchFramework?.contentList[index.row])! as! ChildInfo
     /*   let avatarModel: AvatarModel = ChildInfoToAvatarModelAdapter(childInfo: childModel)
        let avatarModel = AvatarModel()*/
        return childModel
        
    }
    
    
    override func getCell(indexPath: IndexPath) -> BaseCard {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "ChildProgress", for: indexPath) as! BaseCard
       
    }
    
    override func getComponentProperties() -> ComponentProperties {
        let components = ComponentProperties()
        components.visibleIconsSet = []
        
        return components
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.bounds.size.height - 20
        let width = height / 1.7
        
        return CGSize(width: width, height: height);
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        var bundle = [String: Any]()
        //        let videoCategoryModel = dataFetchFramework?.contentList[indexPath.row] as! VideoCategoryModel
        //        bundle[BundleConstants.CATEGORY_ID] = videoCategoryModel.categoryId
        //        bundle[BundleConstants.PARENT_CATEGORY_ID] = videoCategoryModel.parentCategoryId
        //        bundle[BundleConstants.CATEGORY_NAME] = videoCategoryModel.categoryName
        //        NavigationManager.openVideoListingPage(mainControllerCommunicator: mainControllerCommunicator, bundle: bundle)
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
        let CellHeight: Int = Int(collectionView.bounds.size.height)
        let CellWidth: Int = Int(Float(CellHeight) / Float(1.7))
        
        let totalCellWidth = CellWidth * collectionView.numberOfItems(inSection: 0)
        let totalSpacingWidth = 10 * (collectionView.numberOfItems(inSection: 0) - 1)
        
        let leftInset = (collectionView.layer.frame.size.width - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
        let rightInset = leftInset
        
        return UIEdgeInsetsMake(20, leftInset, 20, rightInset)
        
    }

    
    }
