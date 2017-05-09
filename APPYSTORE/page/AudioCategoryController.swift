//
//  AudioCategoryController.swift
//  APPYSTORE
//
//  Created by BridgeLabz Solutions LLP  on 5/3/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import Alamofire
import SwiftyJSON

class AudioCategoryController: BaseListingViewController {
    
    let url = "http://www.appystore.in/appy_app/appyApi_handler.php?"
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var bundle = [String: Any]()
        let audioCategoryModel = dataFetchFramework?.contentList[indexPath.row] as! AudioCategoryModel
        bundle[BundleConstants.CATEGORY_ID] = audioCategoryModel.categoryId
        bundle[BundleConstants.PARENT_CATEGORY_ID] = audioCategoryModel.parentCategoryId
        bundle[BundleConstants.CATEGORY_NAME] = audioCategoryModel.categoryName
        NavigationManager.openAudioListingPage(mainControllerCommunicator: mainControllerCommunicator, bundle: bundle)
    }
    
    override func getDataSource() -> DataSource {
        return DataSource.SERVER
    }
    
    override internal func getPageName() -> String {
        return PageConstants.AUDIO_CATEGORY_PAGE
    }
    
    override func viewDidLoad() {
        dataFetchFramework = DataFetchFramework(pageName: getPageName(), pageUniqueId: "",  bundle: bundle)
    //    dataFromServer()

        super.viewDidLoad()
    }
    
    override func registerCard() {
        self.collectionView.register(UINib(nibName: "AudioCategoryCard", bundle: nil), forCellWithReuseIdentifier: "AudioCategoryCard")
    }
    
    override func getCell(indexPath: IndexPath) -> BaseCard {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "AudioCategoryCard", for: indexPath) as! BaseCard
    }
    
    override func getComponentProperties() -> ComponentProperties {
        let components = ComponentProperties()
        components.visibleIconsSet = [Item.IV_CHILD, Item.BTN_VIDEO, Item.BTN_AUDIO, Item.BTN_HISTORY , Item.BTN_SEARCH]
        
        return components
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
                let height = (self.collectionView?.frame.height)! - 16
                let width = height * 0.733 //aspect ratio 264/360
        
                return CGSize(width: width, height: height)
            }
    
//    func dataFromServer()
//    {
//        Alamofire.request(url, parameters: HttpRequestBuilder.getAudioCategoryParameters(), headers: HttpRequestBuilder.getHeaders()).responseJSON{ (response) in
//            
//            if let hasData = response.data
//            {
//               let jsonData = JSON(data: hasData)
//               print(jsonData)
//            }
//        }
//    }
}
