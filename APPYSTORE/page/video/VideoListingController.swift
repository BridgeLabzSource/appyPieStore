//
//  VideoListingController.swift
//  APPYSTORE
//
//  Created by ios_dev on 28/03/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit

class VideoListingController: BaseListingViewController {
    var catId: String = ""
    var catName: String = ""
    var pCatId: String = ""

    override internal func getPageName() -> String {
        return PageConstants.VIDEO_LISTING_PAGE
    }
    
    override func viewDidLoad() {
        self.catId = bundle?[BundleConstants.CATEGORY_ID] as! String
        self.pCatId = bundle?[BundleConstants.PARENT_CATEGORY_ID] as! String
        self.catName = bundle?[BundleConstants.CATEGORY_NAME] as! String
        dataFetchFramework = DataFetchFramework(pageName: PageConstants.VIDEO_LISTING_PAGE, pageUniqueId: catName, bundle: bundle)
        super.viewDidLoad()
    }
    
    override func getComponentProperties() -> ComponentProperties {
        let components = ComponentProperties()
        components.visibleIconsSet = [Item.BTN_BACK, Item.BTN_VIDEO, Item.BTN_AUDIO, Item.BTN_HISTORY , Item.BTN_SEARCH]
        
        return components
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let videoListingModel = dataFetchFramework?.contentList[indexPath.row] as! VideoListingModel
        print("VideoListingController : select video \(videoListingModel.title)")
        
        if videoListingModel.payType == "paid" {
            var bundle = [String: Any]()
            //NavigationManager.openTrialSuccess(mainControllerCommunicator: self.mainControllerCommunicator!)
            NavigationManager.openTrialPopUp(mainControllerCommunicator: mainControllerCommunicator!, bundle: bundle)
        } else {
            NavigationManager.openVideoPlayerPage(mainControllerCommunicator: mainControllerCommunicator!, model: videoListingModel)
        }
        
        /*
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "VideoPlayerController") as! VideoPlayerController
        
        //mainControllerCommunicator.addChild(controller: viewController)
        mainControllerCommunicator?.getContext().present(viewController, animated: false, completion: nil)
        //performSegue(withIdentifier: "same", sender: nil)
        */
        
    }
}
