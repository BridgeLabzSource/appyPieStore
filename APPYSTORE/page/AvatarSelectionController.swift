//
//  AvatarSelectionController.swift
//  APPYSTORE
//
//  Created by ios_dev on 19/04/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit

class AvatarSelectionController: BaseListingViewController {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnSave: CustomButton!
    @IBOutlet weak var btnAdd: CustomButton!
    
    var givenChild: ChildInfo!
    
    var pageType: Int!
    
    let ACTION_SAVE = 0
    let ACTION_ADD = 1
    var btnAction: Int = 0
    
    var lastSelectedIndex = 0
    
    

    @IBAction func onAddChildTouchUp(_ sender: CustomButton) {
        btnAction = ACTION_ADD
        callRegistrationApiAndNavigate()
    }
    
    @IBAction func onSaveContinueTouchUp(_ sender: CustomButton) {
        btnAction = ACTION_SAVE
        callRegistrationApiAndNavigate()
    }
    
    func callRegistrationApiAndNavigate() {
        let dob = givenChild.dob!.formatDate(originalFormat: "MMM d, yyyy", destinationFormat: "yyyy-MM-dd")
        ChildRegistrationParser().parse(params: HttpRequestBuilder.getChildRegistrationParameters(method: ChildRegistrationParser.METHOD_NAME, childName: givenChild.name!, childDob: dob!, avatarId: getValidAvatarId(childInfo: givenChild), pageId: "AvatarSelection"), completion: {
            statusType, result in
            
            if statusType == BaseParser.REQUEST_SUCCESS {
                let registerApiResponseModel = result as! RegisterApiResponseModel
                UserInfo.getInstance().id = registerApiResponseModel.userId
                
                //Note: registration api returns currently added child only, not the all childs
                if registerApiResponseModel.childInfoList != nil && (registerApiResponseModel.childInfoList?.count)! > 0 {
                    UserInfo.getInstance().childList.append((registerApiResponseModel.childInfoList?[0])!)
                    UserInfo.getInstance().saveUserInfoToUserDefaults()
                }
                // Navigate to appropriate page
                if self.btnAction == self.ACTION_SAVE {
                    if (self.pageType == BundleConstants.PAGE_TYPE_REGISTER || self.pageType == BundleConstants.PAGE_TYPE_REGISTER_ADD) {
                        NavigationUtil.navigateAsPerChildSize(mainControllerCommunicator: self.mainControllerCommunicator!)
                    } else if self.pageType == BundleConstants.PAGE_TYPE_ADD{
                        //todo open child progress page
                    }
                } else if self.btnAction == self.ACTION_ADD {
                    NavigationManager.openRegistrationPage(mainControllerCommunicator: self.mainControllerCommunicator!, pageType: BundleConstants.PAGE_TYPE_REGISTER_ADD)
                }
                
            }
        })
    }
    
    internal override func getPageName() -> String {
        var pageName = PageConstants.SELECT_AVATAR_PAGE_NEW
        
        switch pageType {
        case BundleConstants.PAGE_TYPE_REGISTER:
            pageName = PageConstants.SELECT_AVATAR_PAGE_NEW
        case BundleConstants.PAGE_TYPE_REGISTER_ADD:
            pageName = PageConstants.SELECT_AVATAR_PAGE_NEW
        case BundleConstants.PAGE_TYPE_ADD:
            pageName = PageConstants.SELECT_AVATAR_PAGE_ADD
        case BundleConstants.PAGE_TYPE_EDIT:
            pageName = PageConstants.SELECT_AVATAR_PAGE_EDIT
        default:
            assert(false, "Illegal Page type")
        }
        
        return pageName
    }
    
    internal override func getPageNameUniqueIdentifier() -> String {
        return ""
    }
    
    override func viewDidLoad() {
        initializeView()
        dataFetchFramework = DataFetchFramework(pageName: getPageName(), pageUniqueId: "",  bundle: bundle)
        super.viewDidLoad()
        
    }
    
    func getValidAvatarId(childInfo: ChildInfo?) -> String {
        var avatarId = "1"
        if childInfo != nil && childInfo?.avatarId != nil && childInfo?.avatarId != "0" {
            avatarId = (childInfo?.avatarId)!
        }
        return avatarId
    }
    
    func initializeView() {
        DimensionManager.setTextSize1280x720(label: lblTitle, size: DimensionManager.H1)
    }
    
    override func registerCard() {
        self.collectionView.register(UINib(nibName: "ChildCard", bundle: nil), forCellWithReuseIdentifier: "ChildCard")
    }
    
    override func getCell(indexPath: IndexPath) -> BaseCard {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "ChildCard", for: indexPath) as! BaseCard
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.bounds.size.height
        let width = height
        
        return CGSize(width: width, height: height);
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //deselect previous card
        let previousSelectedModel = dataFetchFramework?.contentList[lastSelectedIndex] as! AvatarModel
        previousSelectedModel.isSelected = false
        
        let currentModel = dataFetchFramework?.contentList[indexPath.row] as! AvatarModel
        givenChild.avatarId = currentModel.id
        currentModel.isSelected = true
        
        collectionView.reloadData()
        
        lastSelectedIndex = indexPath.row
    }

}
