//
//  NavigationManager.swift
//  APPYSTORE
//
//  Created by ios_dev on 31/03/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit

class NavigationManager {
    
    static func openRegistrationPage(mainControllerCommunicator: MainControllerCommunicator, pageType: Int) {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ChildRegistrationController") as! ChildRegistrationController
        viewController.mainControllerCommunicator = mainControllerCommunicator
        //mainControllerCommunicator.addChild(controller: viewController)
        mainControllerCommunicator.getContext().present(viewController, animated: true, completion: nil)
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
    /////////////
    static func openAudioCategoryPage(mainControllerCommunicator: MainControllerCommunicator) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "AudioCategoryController") as! AudioCategoryController
        viewController.mainControllerCommunicator = mainControllerCommunicator
        mainControllerCommunicator.addChild(controller: viewController)
    }
    ////////////////////
    
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
