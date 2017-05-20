//
//  ChildSelectionController.swift
//  APPYSTORE
//
//  Created by ios_dev on 26/04/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit

class ChildSelectionController: BaseListingViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    
    override internal func getPageName() -> String {
        return PageConstants.CHILD_SELECTION_PAGE
    }
    
    override internal func getPageNameUniqueIdentifier() -> String {
        return ""
    }
    
    override func viewDidLoad() {
        dataFetchFramework = DataFetchFramework(pageName: getPageName(), pageUniqueId: getPageNameUniqueIdentifier(), bundle: bundle)
        
        setViews()
        super.viewDidLoad()

    }
    

    func setViews() {
        containerView.layer.cornerRadius = BasePopUpController.POPUP_CORNER_RADIUS
        containerView.showShadowRightBottom()
        
        DimensionManager.setTextSize1280x720(label: lblTitle, size: DimensionManager.H1)
    }
    
    override func getDataSource() -> DataSource{
        return DataSource.LOCAL
    }
    
    override func registerCard() {
        self.collectionView.register(UINib(nibName: "ChildCard", bundle: nil), forCellWithReuseIdentifier: "ChildCard")
    }
    
    override func getModelToFillCard(index: IndexPath) -> BaseModel {
        let childModel = (dataFetchFramework?.contentList[index.row])! as! ChildInfo
        let avatarModel: AvatarModel = ChildInfoToAvatarModelAdapter(childInfo: childModel)
        return avatarModel
    }
    
    override func getCell(indexPath: IndexPath) -> BaseCard {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "ChildCard", for: indexPath) as! BaseCard
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.bounds.size.height
        let width = height / 1.7
        
        return CGSize(width: width, height: height);
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let childModel = dataFetchFramework?.contentList[indexPath.row] as! ChildInfo
        print("ChildSelectionController : selected child \(childModel.name!)")
        
        if(childModel.id != UserInfo.getInstance().selectedChild?.id) {
            NavigationUtil.onChildChangeOrUpdate(currentChild: childModel)
        }
        
        NavigationManager.openVideoCategoryPage(mainControllerCommunicator: mainControllerCommunicator!)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
        let CellHeight: Int = Int(collectionView.bounds.size.height)
        let CellWidth: Int = Int(Float(CellHeight) / Float(1.7))
        
        let totalCellWidth = CellWidth * collectionView.numberOfItems(inSection: 0)
        let totalSpacingWidth = 10 * (collectionView.numberOfItems(inSection: 0) - 1)
        
        let leftInset = (collectionView.layer.frame.size.width - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
        let rightInset = leftInset
        
        return UIEdgeInsetsMake(0, leftInset, 0, rightInset)
        
    }
}
