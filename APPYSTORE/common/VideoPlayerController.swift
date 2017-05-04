//
//  SampleViewController.swift
//  APPYSTORE
//
//  Created by ios_dev on 04/04/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit
import AVFoundation

class VideoPlayerController: BaseViewController, VideoDelegate, RecommendedVideoDelegate {
    
    @IBOutlet weak var miniFrame: UIView!
    @IBOutlet var rootView: UIView!
    
    @IBOutlet weak var recommendedContainer: UIView!
    @IBOutlet weak var videoPlayer: VideoPlayer!
    
    lazy var recommendedController: RecommendedVideoViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "RecommendedVideoViewController") as! RecommendedVideoViewController
        
        self.addAsChildViewController(childController: viewController)
        return viewController
    }()
    
    func addAsChildViewController(childController: BaseViewController){
        self.addChildViewController(childController)
        self.view.addSubview(childController.view)
        //recommendedContainer.clipsToBounds = true
        childController.didMove(toParentViewController: childController)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let playerModel = VideoListingModel()
        playerModel.cdnUrl = "https://content.jwplatform.com/manifests/vM7nH0Kl.m3u8"
        videoPlayer.delegate = self
        //playVideoContent(content: playerModel)
        
        addAsChildViewController(childController: recommendedController)
        recommendedController.delegate = self
        
    }
    
    func onContentChange(content: VideoListingModel) {
        playVideoContent(content: content)
    }
    
    func playVideoContent(content: VideoListingModel) {
        videoPlayer.replaceVideo(playerModel: content)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        videoPlayer.play()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        recommendedController.view.frame = self.recommendedContainer.frame
        recommendedController.view.bounds = self.recommendedContainer.bounds
            
        onVideoMaximize()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onVideoMaximize() {
        videoPlayer.rootView.frame = rootView.frame
        videoPlayer.avPlayerLayer.frame = videoPlayer.rootView.bounds
        
        rootView.bringSubview(toFront: videoPlayer)
    }
    
    func onVideoMinimize() {
        videoPlayer.rootView.frame = miniFrame.frame
        videoPlayer.avPlayerLayer.frame = videoPlayer.rootView.bounds
        
        rootView.bringSubview(toFront: recommendedController.view)
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
}
