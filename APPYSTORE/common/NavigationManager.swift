//
//  NavigationManager.swift
//  APPYSTORE
//
//  Created by ios_dev on 31/03/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit

class NavigationManager {
    

    
    static func openChildProgressPage(mainControllerCommunicator: MainControllerCommunicator) {
        let storyboard = UIStoryboard(name: "ChildProgress", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ChildProgressController") as! ChildProgressController
        viewController.mainControllerCommunicator = mainControllerCommunicator
        mainControllerCommunicator.addChild(controller: viewController, area: .FULL)
    }

    
    static func openVideoPlayerPage(mainControllerCommunicator: MainControllerCommunicator, model: VideoListingModel) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "VideoPlayerController") as! VideoPlayerController
        viewController.mainControllerCommunicator = mainControllerCommunicator
        viewController.defaultModel = model
        mainControllerCommunicator.addChild(controller: viewController, area: .FULL, hideCurrentController: true)
    }
    
    static func openChildSelectionPage(mainControllerCommunicator: MainControllerCommunicator) {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ChildSelectionController") as! ChildSelectionController
        viewController.mainControllerCommunicator = mainControllerCommunicator
        mainControllerCommunicator.addChild(controller: viewController, area: .FULL, hideCurrentController: true)
    }

    static func openAvatarSelectionPage(mainControllerCommunicator: MainControllerCommunicator, pageType: Int, givenChild: ChildInfo) {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "AvatarSelectionController") as! AvatarSelectionController
        viewController.mainControllerCommunicator = mainControllerCommunicator
        viewController.pageType = pageType
        viewController.givenChild = givenChild
        mainControllerCommunicator.addChild(controller: viewController, area: .FULL, hideCurrentController: true)
    }
    
    static func openRegistrationPage(mainControllerCommunicator: MainControllerCommunicator, pageType: Int) {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ChildRegistrationController") as! ChildRegistrationController
        viewController.mainControllerCommunicator = mainControllerCommunicator
        viewController.pageType = pageType
        mainControllerCommunicator.addChild(controller: viewController, area: Area.FULL, hideCurrentController: true)
    }
    
    static func openVideoCategoryPage(mainControllerCommunicator: MainControllerCommunicator) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "VideoCategoryController") as! VideoCategoryController
        viewController.mainControllerCommunicator = mainControllerCommunicator
        mainControllerCommunicator.addChild(controller: viewController, area: nil, hideCurrentController: true)
    }
    
    static func openVideoListingPage(mainControllerCommunicator: MainControllerCommunicator?, bundle : AndroidBundle) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "VideoListingController") as! VideoListingController
        viewController.bundle = bundle
        viewController.mainControllerCommunicator = mainControllerCommunicator
        mainControllerCommunicator?.addChild(controller: viewController, area: nil, hideCurrentController: true)
    }
    
    static func openHistoryPage(mainControllerCommunicator: MainControllerCommunicator) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "HistoryController") as! HistoryController
        viewController.mainControllerCommunicator = mainControllerCommunicator
        mainControllerCommunicator.addChild(controller: viewController, area: nil, hideCurrentController: true)
    }
    
    static func openSearchTagsPage(mainControllerCommunicator: MainControllerCommunicator) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "SearchTagsController") as! SearchTagsController
        viewController.mainControllerCommunicator = mainControllerCommunicator
        mainControllerCommunicator.addChild(controller: viewController, area: nil, hideCurrentController: true)
        
    }
    
    static func openSearchResultPage(mainControllerCommunicator: MainControllerCommunicator, keyword : String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "SearchResultController") as! SearchResultController
        
        var bundle = [String: Any]()
        bundle[BundleConstants.SEARCH_KEYWORD] = keyword
        viewController.bundle = bundle
        
        viewController.mainControllerCommunicator = mainControllerCommunicator
        mainControllerCommunicator.addChild(controller: viewController, area: nil, hideCurrentController: true)
    }
    
    static func openTrialSuccessPopup(mainControllerCommunicator: MainControllerCommunicator) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "FreeTrialController") as! BasePopUpController
        
        object_setClass(viewController, FreeTrialSuccessPopup.self)
        viewController.mainControllerCommunicator = mainControllerCommunicator
        let subclassObject = viewController as! FreeTrialSuccessPopup
        mainControllerCommunicator.addChild(controller: subclassObject, area: .FULL, hideCurrentController: true)
    }
    
    static func openTrialPopUp(mainControllerCommunicator: MainControllerCommunicator, bundle : AndroidBundle) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "FreeTrialController") as! BasePopUpController
        
        object_setClass(viewController, FreeTrialPopUp.self)
        viewController.bundle = bundle
        viewController.mainControllerCommunicator = mainControllerCommunicator
        let subclassObject = viewController as! FreeTrialPopUp
        mainControllerCommunicator.addChild(controller: subclassObject, area: .FULL, hideCurrentController: false)
    }
    
    static func openOtpPopUp(mainControllerCommunicator: MainControllerCommunicator?, bundle : AndroidBundle, completion: @escaping (String) -> Void) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "FreeTrialController") as! BasePopUpController
        
        object_setClass(viewController, OtpVerificationPopUp.self)
        viewController.bundle = bundle
        viewController.mainControllerCommunicator = mainControllerCommunicator
        
        
        
        let subclassObject = viewController as! OtpVerificationPopUp
        subclassObject.onLoginAfterVerification = completion
        mainControllerCommunicator?.addChild(controller: subclassObject, area: .FULL, hideCurrentController: false)
    }
    
    static func openBuySubscriptionPopUp(mainControllerCommunicator: MainControllerCommunicator) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "FreeTrialController") as! BasePopUpController
        
        object_setClass(viewController, BuySubscriptionPopUp.self)
        viewController.mainControllerCommunicator = mainControllerCommunicator
        let subclassObject = viewController as! BuySubscriptionPopUp
        mainControllerCommunicator.addChild(controller: subclassObject, area: .FULL, hideCurrentController: false)
    }
    
    static func openLoginPage(mainControllerCommunicator: MainControllerCommunicator) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "FreeTrialController") as! BasePopUpController
        
        object_setClass(viewController, LoginPage.self)
        viewController.mainControllerCommunicator = mainControllerCommunicator
        let subclassObject = viewController as! LoginPage
        mainControllerCommunicator.addChild(controller: subclassObject, area: .FULL, hideCurrentController: true)
    }

    static func openLoginFailurePage(mainControllerCommunicator: MainControllerCommunicator, mobileNo: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "FreeTrialController") as! BasePopUpController
        
        object_setClass(viewController, LoginFailurePage.self)
        viewController.mainControllerCommunicator = mainControllerCommunicator
        
        let subclassObject = viewController as! LoginFailurePage
        subclassObject.unRegisteredNumber = mobileNo
        
        mainControllerCommunicator.addChild(controller: subclassObject, area: .FULL, hideCurrentController: true)
    }
}
