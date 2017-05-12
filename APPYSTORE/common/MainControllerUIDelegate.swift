//
//  MainControllerUIDelegate.swift
//  APPYSTORE
//
//  Created by ios_dev on 07/04/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

enum Area {
    case FULL
    case MIDDLE
}

class MainControllerUIDelegate {
    let mainController: MainController
    var fabButton: KCFloatingActionButton!
    var progressView: NVActivityIndicatorView?
    
    lazy var historyController: HistoryController = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "HistoryController") as! HistoryController
        
        //self.addAsChildViewController(childController: viewController, area: nil)
        return viewController
    }()
    
    lazy var videoCategoryController: VideoCategoryController = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "VideoCategoryController") as! VideoCategoryController
        
        self.addAsChildViewController(childController: viewController, area: nil)
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
        initProgressBar()
    }
    
    private func initProgressBar() {
        print("initProgressBar x = \(mainController.view.center.x) y = \(mainController.view.center.y)")
        let width = DimensionManager.getGeneralizedWidth1280x720(width: 210)
        let height = DimensionManager.getGeneralizedHeight1280x720(height: 70)
        let frame = CGRect(x: CGFloat(mainController.view.center.x - width / 2), y: CGFloat(mainController.view.center.y - height / 2), width: width, height: height)
        progressView = NVActivityIndicatorView(frame: frame, type: NVActivityIndicatorType.ballPulse, color: UIColor.orange, padding: CGFloat(0))
        
    }
    
    func showProgressBar() {
        progressView?.startAnimating()
        mainController.view.addSubview(progressView!)
        mainController.view.bringSubview(toFront: progressView!)
    }
    
    func hideProgressBar() {
        progressView?.stopAnimating()
        progressView?.removeFromSuperview()
    }
    
    func showCenterText(text: String?) {
        mainController.lblCentreText.isHidden = false
        if (text?).characters.count > 0 {
            mainController.lblCentreText.text = text!
        }
    }
    
    func setButtonsClickLstener() {
        mainController.topView.btnBack.addTarget(self, action: #selector(handleBackButtonClick), for: .touchUpInside)
        mainController.topView.btnVideo.addTarget(self, action: #selector(showVideoCategoryPage), for: .touchUpInside)
        mainController.topView.btnHistory.addTarget(self, action: #selector(showHistoryPage), for: .touchUpInside)
        mainController.topView.btnSearch.addTarget(self, action: #selector(handleSearchButtonClick), for: .touchUpInside)
    }
    
    @objc func handleBackButtonClick(_ controller: AnyObject) {
        let currentViewController = mainController.getCurrentViewController()
        print("handleBackButtonClick \(currentViewController?.getPageName())")
        
        if controller is CustomButton || currentViewController?.getPageName() == (controller as! BaseViewController).getPageName() {
            mainController.childControllersList?.removeLast()
            removeChildController(childController: currentViewController)
            mainController.onBackPressed()
            printBackStack()
        }
        
    }
    
    @objc func handleSearchButtonClick() {
        //NavigationManager.openTrialPopUp(mainControllerCommunicator: mainController)
        
        if mainController.topView.tfSearch.isHidden {
            NavigationManager.openSearchTagsPage(mainControllerCommunicator: mainController)
        } else {
            NavigationManager.openSearchResultPage(mainControllerCommunicator: mainController, keyword: mainController.topView.tfSearch.text!)
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
            
            // first time viewWillAppear gets called automatically,
            // but not from second time onwards, hence calling manually
            if historyController.isViewLoaded {
                historyController.viewWillAppear(false)
            }
            
            self.addAsChildViewController(childController: historyController, area: nil)
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
    
    func addChild(controller: BaseViewController, area: Area?) {
        addAsChildViewController(childController: controller, area: area)
        mainController.childControllersList?.append(controller)
        printBackStack()
    }
    
    func addAsChildViewController(childController: BaseViewController, area: Area?){
        mainController.getCurrentViewController()?.view.isHidden = true
        mainController.addChildViewController(childController)
        mainController.view.addSubview(childController.view)
        
        if(area == nil || area == Area.MIDDLE) {
            childController.view.frame = mainController.middleView.frame
        } else {
            childController.view.frame = mainController.imgFullBgView.frame
        }
        
        childController.didMove(toParentViewController: childController)
        childController.mainControllerCommunicator = mainController
    }
    
    func removeChildController(childController: UIViewController?) {
        if  childController != nil {
            if childController is VideoCategoryController || childController is HistoryController {
                childController?.view.isHidden = true
            } else {
                childController?.willMove(toParentViewController: nil)
                childController?.view.removeFromSuperview()
                childController?.removeFromParentViewController()
            }
        }
    }
    
    internal func setUIComponents(components: ComponentProperties?) {
        if components != nil {
            setAllItemsVisibility(state: false)
            makeItemsVisible(components: components!)
            mainController.topView.tfSearch.text = components?.searchKeyword
        }
    }
    
    func setAllItemsVisibility(state: Bool) {
        mainController.topView.btnBack.isHidden = !state
        mainController.topView.btnVideo.isHidden = !state
        mainController.topView.lblVideos.isHidden = !state
        mainController.topView.btnAudio.isHidden = !state
        mainController.topView.lblSongs.isHidden = !state
        mainController.topView.btnHistory.isHidden = !state
        mainController.topView.lblHistory.isHidden = !state
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
                mainController.topView.lblVideos.isHidden = false
            case Item.BTN_AUDIO:
                mainController.topView.btnAudio.isHidden = false
                mainController.topView.lblSongs.isHidden = false
            case Item.BTN_HISTORY:
                mainController.topView.btnHistory.isHidden = false
                mainController.topView.lblHistory.isHidden = false
            case Item.TF_SEARCH:
                mainController.topView.tfSearch.isHidden = false
            case Item.BTN_SEARCH:
                mainController.topView.btnSearch.isHidden = false
            default:
                break
            }
        }
    }
    
    func printBackStack() {
        for childController in mainController.childControllersList! {
            print("printBackStack \(childController.getPageName())")
        }
    }
    
}
