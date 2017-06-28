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

class MainControllerUIDelegate: NSObject, UITextFieldDelegate {
    let mainController: MainController
    var fabButton: KCFloatingActionButton! = KCFloatingActionButton()
    var progressView: NVActivityIndicatorView?
    
    lazy var audioCategoryController: AudioCategoryController = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "AudioCategoryController") as! AudioCategoryController
        
        self.addAsChildViewController(childController: viewController, area: nil)
        return viewController
    }()
    
    lazy var historyController: HistoryController = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "HistoryController") as! HistoryController
        
        return viewController
    }()
    
    lazy var videoCategoryController: VideoCategoryController = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "VideoCategoryController") as! VideoCategoryController
        
        return viewController
    }()
    
    init(mainController: MainController) {
        self.mainController = mainController
    }
    
    func viewDidLoad() {
        setButtonsClickLstener()
        
        //fabButton = KCFloatingActionButton()
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
        DimensionManager.setTextSize1280x720(label: mainController.lblCentreText, size: DimensionManager.H3)
        mainController.lblCentreText.isHidden = false
        if text != nil && (text?.characters.count)! > 0 {
            mainController.lblCentreText.text = text!
        } else {
            mainController.lblCentreText.isHidden = true
        }
    }
    
    func setButtonsClickLstener() {
        mainController.topView.imageTapGesture.addTarget(self, action: #selector(handleChildProgressButtonClick))
        mainController.topView.btnBack.addTarget(self, action: #selector(handleBackButtonClick), for: .touchUpInside)
        mainController.topView.btnVideo.addTarget(self, action: #selector(showVideoCategoryPage), for: .touchUpInside)
        mainController.topView.btnAudio.addTarget(self, action: #selector(showAudioCategoryPage), for: .touchUpInside)
        mainController.topView.btnHistory.addTarget(self, action: #selector(showHistoryPage), for: .touchUpInside)
        mainController.topView.btnSearch.addTarget(self, action: #selector(handleSearchButtonClick), for: .touchUpInside)
        
        mainController.topView.tfSearch.delegate = self
        //mainController.topView.tfSearch.addTarget(self, action: #selector(searchTextFieldChanged), for: .editingDidEnd)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let count = (textField.text?.characters.count)! + string.characters.count - range.length
        if count > 0 {
            print(" if searchTextFieldChanged \(count) and range \(range.length)")
            // hide cross icon
        } else {
            print(" else searchTextFieldChanged and range \(range.length)")
            // show cross icon
        }
        
        return true
    }
    
    
    @objc func handleChildProgressButtonClick(_ controller: AnyObject) {
        
        NavigationManager.openChildProgressPage(mainControllerCommunicator: mainController)
        
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
            
            // first time viewWillAppear gets called automatically,
            // but not from second time onwards, hence calling manually
            if videoCategoryController.isViewLoaded {
                videoCategoryController.viewWillAppear(false)
            }
            
            self.addAsChildViewController(childController: videoCategoryController, area: nil)
            videoCategoryController.view.isHidden = false
            mainController.childControllersList?.append(videoCategoryController)
        }
    }
    
    @objc func showAudioCategoryPage() {
        if !(mainController.getCurrentViewController() is AudioCategoryController) {
            removeChildController(childController: mainController.getCurrentViewController())
            audioCategoryController.view.isHidden = false
            mainController.childControllersList?.append(audioCategoryController)
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
    
    func shareApp() {
        let text = "this is the text to share"
        let textToShare = [text]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        mainController.present(activityViewController, animated: true, completion: nil)
    }
    
    func makeFab() {
        
        fabButton.isHidden = true
        fabButton.isUserInteractionEnabled = true
        //fabButton.friendlyTap = true
        let f1 = fabButton.addItem("Parenting Videos", icon: UIImage(named: "video_type_2"))
        f1.size = DimensionManager.getGeneralizedWidth1280x720(width: 104)
        f1.layerColor = .RED
        //f1.handler = {item in
          //  print("hello")
        //}
        
        let f2 = fabButton.addItem("Profile", icon: UIImage(named: "profile"))
        f2.layerColor = .BLUE
        f2.size = DimensionManager.getGeneralizedWidth1280x720(width: 104)
        
        
        let singleTapPlay = UITapGestureRecognizer(target: self, action: #selector(shareApp))
        singleTapPlay.numberOfTapsRequired = 1 // you can change this value
        f2.isUserInteractionEnabled = true
        f2.addGestureRecognizer(singleTapPlay)
        
        let f3 = fabButton.addItem("Share App", icon: UIImage(named: "share"))
        f3.layerColor = .GREEN
        f3.size = DimensionManager.getGeneralizedWidth1280x720(width: 104)
        f3.handler = {item in
            self.shareApp()
        }
        
        let f4 = fabButton.addItem("Write to us", icon: UIImage(named: "edit"))
        f4.layerColor = .VIOLET
        f4.size = DimensionManager.getGeneralizedWidth1280x720(width: 104)
        f4.handler = {item in
            self.shareApp()
        }
        let f5 = fabButton.addItem("Chat", icon: UIImage(named: "icon_chat"))
        f5.layerColor = .PURPLE
        f5.size = DimensionManager.getGeneralizedWidth1280x720(width: 104)
        f5.handler = {item in
            self.shareApp()
        }
        mainController.view.addSubview(fabButton)
        fabButton.superview?.bringSubview(toFront: fabButton)
    }
    
    func addChild(controller: BaseViewController, area: Area?, hideCurrentController: Bool) {
        if hideCurrentController {
            mainController.getCurrentViewController()?.view.isHidden = true
        }
        addAsChildViewController(childController: controller, area: area)
        mainController.childControllersList?.append(controller)
        printBackStack()
    }
    
    func addAsChildViewController(childController: BaseViewController, area: Area?){
        
        mainController.addChildViewController(childController)
        
        childController.mainControllerCommunicator = mainController
        mainController.view.addSubview(childController.view)
        
        if(area == nil || area == Area.MIDDLE) {
            childController.view.frame = mainController.middleView.frame
        } else {
            childController.view.frame = mainController.imgFullBgView.frame
        }
        
        childController.didMove(toParentViewController: childController)
    }
    
    func removeChildController(childController: UIViewController?){
        if  childController != nil {
            if childController is VideoCategoryController || childController is HistoryController || childController is AudioCategoryController ||
            //Added
            
            childController is ChildProgressController
            ///

                {
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
            makeAllItemsUnSelected()
            makeItemsSelected(components: components!)
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
        fabButton.isHidden = !state
    }
    
    func makeItemsVisible(components: ComponentProperties) {
        for item in components.visibleIconsSet {
            switch item {
            case Item.BTN_BACK:
                mainController.topView.btnBack.isHidden = false
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
            case Item.BTN_FAB:
                fabButton.isHidden = false
            case Item.IMG_CHILD:
                let selectedChildImage = UserInfo.getInstance().selectedChild?.avatarImage
                let SelectedChildName  = UserInfo.getInstance().selectedChild?.name
                if let image_url = selectedChildImage{
                    let  url = URL(string: image_url)
                    mainController.topView.imgChild.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "profile") )
                    mainController.topView.childNameLbl.text = SelectedChildName
                    DimensionManager.setTextSize1280x720(label: mainController.topView.childNameLbl, size: DimensionManager.H3)
                }else{
                    mainController.topView.imgChild.image = #imageLiteral(resourceName: "profile")
                }
                mainController.topView.childNameLbl.isHidden = false

            default:
                break
            }
        }
    }
    
    func makeAllItemsUnSelected() {
        mainController.topView.btnBack.buttonColor = ButtonColor.GREY_COLOR
        mainController.topView.btnBack.setNeedsDisplay()
        
        mainController.topView.btnVideo.buttonColor = ButtonColor.GREY_COLOR
        mainController.topView.btnVideo.setNeedsDisplay()
        
        mainController.topView.btnAudio.buttonColor = ButtonColor.GREY_COLOR
        mainController.topView.btnAudio.setNeedsDisplay()
        
        mainController.topView.btnHistory.buttonColor = ButtonColor.GREY_COLOR
        mainController.topView.btnHistory.setNeedsDisplay()
        
        mainController.topView.btnSearch.buttonColor = ButtonColor.GREY_COLOR
        mainController.topView.btnSearch.setNeedsDisplay()
    }

    func makeItemsSelected(components: ComponentProperties) {
        for item in components.selectedIconsSet {
            switch item {
            case Item.BTN_BACK:
                mainController.topView.btnBack.buttonColor = ButtonColor.ORANGE_COLOR
                mainController.topView.btnBack.setNeedsDisplay()
            case Item.BTN_VIDEO:
                mainController.topView.btnVideo.buttonColor = ButtonColor.ORANGE_COLOR
                mainController.topView.btnVideo.setNeedsDisplay()
            case Item.BTN_AUDIO:
                mainController.topView.btnAudio.buttonColor = ButtonColor.ORANGE_COLOR
                mainController.topView.btnAudio.setNeedsDisplay()
            case Item.BTN_HISTORY:
                mainController.topView.btnHistory.buttonColor = ButtonColor.ORANGE_COLOR
                mainController.topView.btnHistory.setNeedsDisplay()
            case Item.BTN_SEARCH:
                mainController.topView.btnSearch.buttonColor = ButtonColor.ORANGE_COLOR
                mainController.topView.btnSearch.setNeedsDisplay()
            default:
                break
            }
        }
    }

    func printBackStack() {
        for childController in mainController.childControllersList! {
            print("printBackStack \(childController.getPageName())")
            print("===============================================")
        }
    }
    
}
