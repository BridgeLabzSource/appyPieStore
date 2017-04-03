//
//  NavigationManager.swift
//  APPYSTORE
//
//  Created by ios_dev on 31/03/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit

class NavigationManager {
    
    
    static func openVideoCategoryPage(mainControllerCommunicator: MainControllerCommunicator) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "VideoCategoryController") as! VideoCategoryController
        viewController.mainControllerCommunicator = mainControllerCommunicator
        mainControllerCommunicator.addChild(controller: viewController)
    }
    
    static func openVideoListingPage(mainControllerCommunicator: MainControllerCommunicator?) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "VideoListingController") as! VideoListingController
        mainControllerCommunicator?.addChild(controller: viewController)
    }
    
    static func openHistoryPage(mainControllerCommunicator: MainControllerCommunicator) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "HistoryController") as! HistoryController
        viewController.mainControllerCommunicator = mainControllerCommunicator
        mainControllerCommunicator.addChild(controller: viewController)
    }
    
}
