//
//  MainControllerUIDelegate.swift
//  APPYSTORE
//
//  Created by ios_dev on 07/04/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit

class MainControllerUIDelegate {
    let mainController: MainController
    var fabButton: KCFloatingActionButton!
    
    lazy var historyController: HistoryController = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "HistoryController") as! HistoryController
        
        self.addAsChildViewController(childController: viewController)
        return viewController
    }()
    
    lazy var videoCategoryController: VideoCategoryController = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "VideoCategoryController") as! VideoCategoryController
        
        self.addAsChildViewController(childController: viewController)
        return viewController
    }()
    
    init(mainController: MainController) {
        self.mainController = mainController
    }
    
    func viewDidLoad() {
        setButtonsClickLstener()
        
        fabButton = KCFloatingActionButton()
        fabButton.buttonImage = UIImage(named: "fab_settings")
        fabButton.size = DimensionManager.getGeneralizedHeight1280x720(height: 104)
        fabButton.paddingX = DimensionManager.getGeneralizedWidth1280x720(width: 32)
        fabButton.paddingY = DimensionManager.getGeneralizedHeight1280x720(height: 32)
        makeFab()
        
    }
    
    func setButtonsClickLstener() {
        mainController.topView.btnBack.addTarget(self, action: #selector(handleBackButtonClick), for: .touchUpInside)
        mainController.topView.btnVideo.addTarget(self, action: #selector(showVideoCategoryPage), for: .touchUpInside)
        mainController.topView.btnHistory.addTarget(self, action: #selector(showHistoryPage), for: .touchUpInside)
        mainController.topView.btnSearch.addTarget(self, action: #selector(handleSearchButtonClick), for: .touchUpInside)
    }
    
    @objc func handleBackButtonClick() {
        let currentViewController = mainController.getCurrentViewController()
        mainController.childControllersList?.removeLast()
        removeChildController(childController: currentViewController)
        mainController.onBackPressed()
    }
    
    @objc func handleSearchButtonClick() {
        if mainController.topView.tfSearch.isHidden {
            NavigationManager.openSearchTagsPage(mainControllerCommunicator: mainController)
        } else {
            var bundle = [String: Any]()
            bundle[BundleConstants.SEARCH_KEYWORD] = mainController.topView.tfSearch.text
            NavigationManager.openSearchResultPage(mainControllerCommunicator: mainController, bundle: bundle)
        }
    }
    
    @objc func showVideoCategoryPage() {
        if !(mainController.getCurrentViewController() is VideoCategoryController) {
            removeChildController(childController: mainController.getCurrentViewController())
            videoCategoryController.view.isHidden = false
            mainController.childControllersList?.append(videoCategoryController)
        }
    }
    
    @objc func showHistoryPage() {
        
        if !(mainController.getCurrentViewController() is HistoryController) {
            removeChildController(childController: mainController.getCurrentViewController())
            historyController.view.isHidden = false
            mainController.childControllersList?.append(historyController)
        }
    }
    
    func makeFab() {
        let f1 = fabButton.addItem("Parenting Videos", icon: UIImage(named: "video_type_2"))
        f1.size = DimensionManager.getGeneralizedWidth1280x720(width: 104)
        f1.layerColor = .RED
        
        let f2 = fabButton.addItem("Profile", icon: UIImage(named: "profile"))
        f2.layerColor = .BLUE
        f2.size = DimensionManager.getGeneralizedWidth1280x720(width: 104)
        
        let f3 = fabButton.addItem("Share App", icon: UIImage(named: "share"))
        f3.layerColor = .GREEN
        f3.size = DimensionManager.getGeneralizedWidth1280x720(width: 104)
        
        let f4 = fabButton.addItem("Write to us", icon: UIImage(named: "edit"))
        f4.layerColor = .VIOLET
        f4.size = DimensionManager.getGeneralizedWidth1280x720(width: 104)
        
        let f5 = fabButton.addItem("Chat", icon: UIImage(named: "icon_chat"))
        f5.layerColor = .PURPLE
        f5.size = DimensionManager.getGeneralizedWidth1280x720(width: 104)
        
        mainController.view.addSubview(fabButton)
    }
    
    func addChild(controller: BaseViewController) {
        addAsChildViewController(childController: controller)
        mainController.childControllersList?.append(controller)
    }
    
    func addAsChildViewController(childController: BaseViewController){
        mainController.addChildViewController(childController)
        mainController.view.addSubview(childController.view)
        childController.view.frame = mainController.middleView.frame
        childController.didMove(toParentViewController: childController)
        childController.mainControllerCommunicator = mainController
    }
    
    func removeChildController(childController: UIViewController?) {
        if  childController != nil {
            if childController is VideoCategoryController || childController is HistoryController{
                childController?.view.isHidden = true
            } else {
                childController?.willMove(toParentViewController: nil)
                childController?.view.removeFromSuperview()
                childController?.removeFromParentViewController()
            }
        }
    }
    
    internal func setUIComponents(components: ComponentProperties) {
        if components != nil {
            setAllItemsVisibility(state: false)
            makeItemsVisible(components: components)
        }
    }
    
    func setAllItemsVisibility(state: Bool) {
        mainController.topView.btnBack.isHidden = !state
        mainController.topView.btnVideo.isHidden = !state
        mainController.topView.btnAudio.isHidden = !state
        mainController.topView.btnHistory.isHidden = !state
        mainController.topView.tfSearch.isHidden = !state
        mainController.topView.btnSearch.isHidden = !state
    }
    
    func makeItemsVisible(components: ComponentProperties) {
        for item in components.visibleIconsSet {
            switch item {
            case Item.BTN_BACK:
                mainController.topView.btnBack.isHidden = false
                break
            case Item.BTN_VIDEO:
                mainController.topView.btnVideo.isHidden = false
            case Item.BTN_AUDIO:
                mainController.topView.btnAudio.isHidden = false
            case Item.BTN_HISTORY:
                mainController.topView.btnHistory.isHidden = false
            case Item.TF_SEARCH:
                mainController.topView.tfSearch.isHidden = false
            case Item.BTN_SEARCH:
                mainController.topView.btnSearch.isHidden = false
            default:
                break
            }
        }
    }
    
    
}
