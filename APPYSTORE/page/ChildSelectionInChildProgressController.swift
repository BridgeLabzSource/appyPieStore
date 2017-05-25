//
//  ChildSelectionInChildProgressController.swift
//  APPYSTORE
//
//  Created by BridgeLabz Solution LLP on 11/05/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit

protocol ChildSelectionInChildProgressControllerDelegate{
func changeChildOnSelect(indexPath : IndexPath)
}

class ChildSelectionInChildProgressController: BaseListingViewController{
    var count:Int = 0
    var delegate : ChildSelectionInChildProgressControllerDelegate?
    
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
        return childModel
        
    }
    
    
    override func getCell(indexPath: IndexPath) -> ChildProgress {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "ChildProgress", for: indexPath) as! ChildProgress
       
    }
    
   
    override func getComponentProperties() -> ComponentProperties {
        let components = ComponentProperties()
        components.visibleIconsSet = [Item.BTN_BACK]
        
        return components
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.bounds.size.height - 20
        let width = height / 1.7
        
        return CGSize(width: width, height: height);
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       if indexPath.row < (dataFetchFramework?.contentList.count)!
       {  let childModel = dataFetchFramework?.contentList[indexPath.row] as! ChildInfo
        if(childModel.id != UserInfo.getInstance().selectedChild?.id) {
            
            NavigationUtil.onChildChangeOrUpdate(currentChild: childModel)
            setScrollDirection()
            collectionView.reloadData()
            delegate?.changeChildOnSelect(indexPath : indexPath)
        }else{
                NavigationManager.openRegistrationPage(mainControllerCommunicator: self.mainControllerCommunicator!, pageType: BundleConstants.PAGE_TYPE_REGISTER_ADD)
        
        }
       }else{
        NavigationManager.openRegistrationPage(mainControllerCommunicator: self.mainControllerCommunicator!, pageType: BundleConstants.PAGE_TYPE_REGISTER_ADD)
        }
    }
        
    

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (dataFetchFramework?.contentList.count)! + 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = getCell(indexPath: indexPath)
        if indexPath.row >= (dataFetchFramework?.contentList.count)! {
            cell.childimg.image =  #imageLiteral(resourceName: "icon_plus_addchild")
            cell.childName.text = "Add Child"
            cell.childAge.text = ""
            DimensionManager.setTextSize1280x720(label: cell.childName, size: DimensionManager.H3)
            cell.editImg.isHidden = true
            cell.childimg.layer.borderColor = UIColor.white.cgColor
            cell.childimg.layer.backgroundColor = UIColor.clear.cgColor
            cell.childimg.layer.borderWidth = 0
        }else{
        cell.fillCard(model: getModelToFillCard(index: indexPath))
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
        let CellHeight: Int = Int(collectionView.bounds.size.height)
        let CellWidth: Int = Int(Float(CellHeight) / Float(1.7))
        
        let totalCellWidth = CellWidth * collectionView.numberOfItems(inSection: 0)
        let totalSpacingWidth = 10 * (collectionView.numberOfItems(inSection: 0) - 1)
        
        let leftInset = (collectionView.layer.frame.size.width - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
        let rightInset = leftInset
        
        return UIEdgeInsetsMake(20, 40, 20, rightInset)
        
    }

    
    }
