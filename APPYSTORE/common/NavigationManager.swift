//
//  NavigationManager.swift
//  APPYSTORE
//
//  Created by ios_dev on 31/03/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit

class NavigationManager {
    
    static func openVideoPlayerPage(mainControllerCommunicator: MainControllerCommunicator) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "VideoPlayerController") as! VideoPlayerController
        viewController.mainControllerCommunicator = mainControllerCommunicator
        //mainControllerCommunicator.addChild(controller: viewController)
        //mainControllerCommunicator.getContext().present(viewController, animated: false, completion: nil)
    }
    
    static func openVideoCategoryPage(mainControllerCommunicator: MainControllerCommunicator) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "VideoCategoryController") as! VideoCategoryController
        viewController.mainControllerCommunicator = mainControllerCommunicator
        mainControllerCommunicator.addChild(controller: viewController)
    }
    
    static func openVideoListingPage(mainControllerCommunicator: MainControllerCommunicator?, bundle : AndroidBundle) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "VideoListingController") as! VideoListingController
        viewController.bundle = bundle
        viewController.mainControllerCommunicator = mainControllerCommunicator
        mainControllerCommunicator?.addChild(controller: viewController)
    }
    
    static func openHistoryPage(mainControllerCommunicator: MainControllerCommunicator) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "HistoryController") as! HistoryController
        viewController.mainControllerCommunicator = mainControllerCommunicator
        mainControllerCommunicator.addChild(controller: viewController)
    }
    
    static func openSearchTagsPage(mainControllerCommunicator: MainControllerCommunicator) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "SearchTagsController") as! SearchTagsController
        viewController.mainControllerCommunicator = mainControllerCommunicator
        mainControllerCommunicator.addChild(controller: viewController)
        
    }
    
    static func openSearchResultPage(mainControllerCommunicator: MainControllerCommunicator, keyword : String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "SearchResultController") as! SearchResultController
        
        var bundle = [String: Any]()
        bundle[BundleConstants.SEARCH_KEYWORD] = keyword
        viewController.bundle = bundle
        
        viewController.mainControllerCommunicator = mainControllerCommunicator
        mainControllerCommunicator.addChild(controller: viewController)
    }
    
}
