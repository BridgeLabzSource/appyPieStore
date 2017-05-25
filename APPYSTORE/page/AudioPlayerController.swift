//
//  AudioPlayerController.swift
//  APPYSTORE
//
//  Created by BridgeLabz Solutions LLP  on 5/3/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit
import AVFoundation
import WebKit

class AudioPlayerController: BaseViewController, AudioDelegate,RecommendedAudioDelegate{
    
    @IBOutlet weak var audioPlayer: AudioPlayer!
    
    @IBOutlet weak var backButton: CustomButton!
    
    @IBOutlet weak var audioListView: UIView!
    
    var defaultModel: AudioListingModel?
    lazy var recommendedController: RecommendedAudioViewController = {
        print("AudioPlayerController lazyload")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "RecommendedAudioViewController") as! RecommendedAudioViewController
        
        viewController.listingModel = self.defaultModel
        self.addAsChildViewController(childController: viewController)
        self.addChildViewController(viewController)
        return viewController
    }()

    func addAsChildViewController(childController: BaseViewController){
        print("VideoPlayerController addAsChildViewController")
        addChildViewController(childController)
        audioListView.addSubview(childController.view)
        
        childController.view.frame = audioListView.bounds
        childController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        childController.didMove(toParentViewController: self)
        
    }

    override func getPageName() -> String {
        return PageConstants.AUDIO_PLAYER_PAGE
    }
    
    override func getPageNameUniqueIdentifier() -> String {
        return ""
    }
    
    override func getComponentProperties() -> ComponentProperties {
        let components = ComponentProperties()
        components.visibleIconsSet = [Item.BTN_BACK]
        
        return components
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        audioPlayer.delegate = self
        addAsChildViewController(childController: recommendedController)

    //  playAudioContent(content: defaultModel!)
        
        print("AudioPlayerController viewDidLoad====",defaultModel?.imagePath)
  
    // playerController = AudioPlayerViewController()
      //  print(bundle!)
       // playerController?.playerbundle = bundle
        //  NotificationCenter.default.post(name: NSNotification.Name(rawValue: "audioData"), object: nil, userInfo: bundle)
        // let ss = bundle[BundleConstants.]
        recommendedController.delegate = self
        
        self.view.bringSubview(toFront: backButton)
        backButton.addTarget(self, action: #selector(handleBackButtonClick), for: .touchUpInside)
        
    }

    func handleBackButtonClick() {
        print("AudioPlayerController handleBackButtonClick")
//audioPlayer.avPlayer?.pause()
//        audioPlayer.avPlayerLayer.removeFromSuperlayer()
//        audioPlayer.avPlayer = nil

//        NavigationManager.openAudioListingPlayerPage(mainControllerCommunicator: mainControllerCommunicator!, bundle: AudioListingModel)
        count = 0
        mainControllerCommunicator?.performBackButtonClick(self)
    }
    
    func playAudioContent(content: AudioListingModel) {
       // MusicHelper.sharedHelper.audioPlayer?.pause()
       // AudioPlayerHelper.sharedHelper.stopCurrentAudio()
       // AudioPlayerHelper.sharedHelper.replaceAudio(playerModel: content)
       // AudioPlayerHelper.sharedHelper.play()
       
        print(content.downloadUrl)
       // audioPlayer.view.setNeedsDisplay()
        audioPlayer?.replaceAudio(playerModel: content)
        if content.payType == "paid" {
            let bundle = [String: Any]()
            NavigationManager.openTrialPopUp(mainControllerCommunicator: mainControllerCommunicator!, bundle: bundle)
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("AudioPlayerController viewDidAppear")
        playAudioContent(content: defaultModel!)
    }
    
    func onAudioCompleted() {
        recommendedController.nextAudio()
    }
    
    func onTaskStarted() {
        recommendedController.isClickedEnable = false
    }
    
    func onTaskCompleted() {
        recommendedController.isClickedEnable = true
    }
    
    func onNext() {
        recommendedController.nextAudio()
    }
    
    func onPrevious() {
        recommendedController.previousAudio()
    }
    
    override func resetPage() {
        super.resetPage()
        //playVideoContent(content: defaultModel!)
        recommendedController.resetPage()
    }
    
    func onContentChange(content: AudioListingModel) {
      playAudioContent(content: content)
       // recommendedController.view.frame = self.audioListView.frame
      //  recommendedController.view.bounds = self.audioListView.bounds
    }
    
}
