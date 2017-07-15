//
//  SampleViewController.swift
//  APPYSTORE
//
//  Created by ios_dev on 04/04/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit
import AVFoundation
import WebKit

class VideoPlayerController: BaseViewController, VideoDelegate, RecommendedVideoDelegate {
    
    @IBOutlet weak var miniFrame: UIView!
    @IBOutlet var rootView: UIView!
    
    @IBOutlet weak var backButton: CustomButton!
    @IBOutlet weak var recommendedContainer: UIView!
    @IBOutlet weak var videoPlayer: VideoPlayer!
    
    var isMinimize = true
    var defaultModel: VideoListingModel?
    
    lazy var recommendedController: RecommendedVideoViewController = {
        print("VideoPlayerController lazyload")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "RecommendedVideoViewController") as! RecommendedVideoViewController
        
        viewController.listingModel = self.defaultModel
        //self.addAsChildViewController(childController: viewController)
        self.addChildViewController(viewController)
        return viewController
    }()
    
    override func getPageName() -> String {
        return PageConstants.VIDEO_PLAYER_PAGE
    }
    
    override func getPageNameUniqueIdentifier() -> String {
        return ""
    }
    
    func addAsChildViewController(childController: BaseViewController){
        print("VideoPlayerController addAsChildViewController")
        addChildViewController(childController)
        view.addSubview(childController.view)
        
        childController.view.frame = recommendedContainer.bounds
        childController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        childController.didMove(toParentViewController: self)
        
    }
    
    override func getComponentProperties() -> ComponentProperties {
        let components = ComponentProperties()
        components.visibleIconsSet = [Item.BTN_BACK]
        
        return components
    }
    
    override func viewDidLoad() {
        print("VideoPlayerController viewDidLoad")
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        videoPlayer.delegate = self
        
        addAsChildViewController(childController: recommendedController)
        recommendedController.delegate = self
        
        backButton.addTarget(self, action: #selector(handleBackButtonClick), for: .touchUpInside)
        ////////////
        
        ///////////
    }
       
    func handleBackButtonClick() {
        print("VideoPlayerController handleBackButtonClick")
        videoPlayer.avPlayer?.pause()
        MusicHelper.sharedHelper.audioPlayer?.play()
        videoPlayer.avPlayerLayer.removeFromSuperlayer()
        videoPlayer.avPlayer = nil
        //self.dismiss(animated: false, completion: nil)
        mainControllerCommunicator?.performBackButtonClick(self)
    }
    
    func onContentChange(content: VideoListingModel) {
        playVideoContent(content: content)
        recommendedController.view.frame = self.recommendedContainer.frame
        recommendedController.view.bounds = self.recommendedContainer.bounds
    }
    
    func playVideoContent(content: VideoListingModel) {
        videoPlayer.replaceVideo(playerModel: content)
        if content.payType == "paid" {
            let bundle = [String: Any]()
            NavigationManager.openTrialPopUp(mainControllerCommunicator: mainControllerCommunicator!, bundle: bundle)
        }
    }
    
    /*
    override func viewWillAppear(_ animated: Bool) {
        print("VideoPlayerController viewWillAppear")
        super.viewWillAppear(animated)
        videoPlayer.play()
    }
 */
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        print("VideoPlayerController viewWillTransition")
    }
    
    override func beginAppearanceTransition(_ isAppearing: Bool, animated: Bool) {
        super.beginAppearanceTransition(isAppearing, animated: animated)
    }
    
    /*
    override func endAppearanceTransition() {
        super.endAppearanceTransition()
        print("VideoPlayerController endAppearanceTransition")
        recommendedController.view.frame = self.recommendedContainer.frame
        recommendedController.view.bounds = self.recommendedContainer.bounds
        onVideoMinimize()
        playVideoContent(content: defaultModel!)
    }
 */
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("VideoPlayerController viewDidAppear")
        
        recommendedController.view.frame = self.recommendedContainer.frame
        recommendedController.view.bounds = self.recommendedContainer.bounds
        
        playVideoContent(content: defaultModel!)
        onVideoMinimize()
        /*
        videoPlayer.frame = view.frame
        videoPlayer.avPlayerLayer.frame = videoPlayer.frame
        videoPlayer.rootView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        rootView.bringSubview(toFront: videoPlayer)
        */
        
    }
 
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onContainerClick() {
        if isMinimize {
            onVideoMaximize()
        } else {
            onVideoMinimize()
        }
    }
    
    func onVideoMaximize() {
        isMinimize = false
        videoPlayer.rootView.frame = rootView.frame
        videoPlayer.avPlayerLayer.frame = videoPlayer.rootView.bounds
        
        rootView.bringSubview(toFront: videoPlayer)
    }
    
    func onVideoMinimize() {
        videoPlayer.rootView.frame = miniFrame.frame
        videoPlayer.avPlayerLayer.frame = videoPlayer.rootView.bounds
        
        rootView.bringSubview(toFront: recommendedController.view)
        
        isMinimize = true
    }
    
    func onVideoCompleted() {
        recommendedController.nextVideo()
    }
    
    func onTaskStarted() {
        recommendedController.isClickedEnable = false
    }
    
    func onTaskCompleted() {
        recommendedController.isClickedEnable = true
    }
    
    func onNext() {
        recommendedController.nextVideo()
    }
    
    func onPrevious() {
        recommendedController.previousVideo()
    }
    
    override func resetPage() {
        super.resetPage()
        //playVideoContent(content: defaultModel!)
        recommendedController.resetPage()
    }
 }
