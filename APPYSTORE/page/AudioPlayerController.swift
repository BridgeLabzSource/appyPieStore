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
import MediaPlayer

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
    
    
    override func viewWillAppear(_ animated: Bool) {
        setupNowPlayingInfoCenter()
       //updateNowPlayingInfoCenter()
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
       
        if content.payType == "paid" {
            let bundle = [String: Any]()
            NavigationManager.openTrialPopUp(mainControllerCommunicator: mainControllerCommunicator!, bundle: bundle)
        }else{
            updateNowPlayingInfoCenter()
            audioPlayer?.replaceAudio(playerModel: content)
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
        recommendedController.showAudioEquilizerAnimation()
    }
    func onPause() {
        recommendedController.hideAudioEquilizerAnimation()
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
        defaultModel = content
      playAudioContent(content: content)
        
       // recommendedController.view.frame = self.audioListView.frame
       //  recommendedController.view.bounds = self.audioListView.bounds
    }
    
    
    
    
//----------------------------------------------------------------------
                        // App notification code
//----------------------------------------------------------------------
    func downloadImage(url:NSURL, completion: @escaping ((_ image: UIImage?) -> Void)){
        print("Started downloading \"\(url.deletingPathExtension!.lastPathComponent)\".")
        getDataFromUrl(url: url) { data in
          
            //   DispatchQueue.main.asynchronously()
            DispatchQueue.global(qos: .background).async   {
                
                        completion(UIImage(data: data! as Data))
                
            }
        }
    }
    
    func getDataFromUrl(url:NSURL, completion: @escaping ((_ data: NSData?) -> Void)) {
        URLSession.shared.dataTask(with: url as URL) { (data, response, error) in
            completion(data! as NSData?)
            }.resume()
    }
    
    
    //----------------------------------------------------------------------
    func setupNowPlayingInfoCenter() {
        UIApplication.shared.beginReceivingRemoteControlEvents()
        
        let commandCenter = MPRemoteCommandCenter.shared()
        
        commandCenter.pauseCommand.addTarget { (event) -> MPRemoteCommandHandlerStatus in
            //Update your button here for the pause command
            AudioPlayerHelper.sharedHelper.audioPlayer.pause()
            return .success
        }
        
        commandCenter.playCommand.addTarget { (event) -> MPRemoteCommandHandlerStatus in
            //Update your button here for the play command
            AudioPlayerHelper.sharedHelper.audioPlayer.play()
            return .success
        }
        MPRemoteCommandCenter.shared().nextTrackCommand.addTarget {event in
            self.onNext()
           // self.updateNowPlayingInfoCenter()
            return .success
        }
        MPRemoteCommandCenter.shared().previousTrackCommand.addTarget {event in
            self.onPrevious()
          //  self.updateNowPlayingInfoCenter()
            return .success
        }
        
    }
    /////==-=-==-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
    
  //  update the info when audio is changed 
    func updateNowPlayingInfoCenter() {
      
        MPNowPlayingInfoCenter.default().nowPlayingInfo = [String: AnyObject]()
        
        
    
        if NSClassFromString("MPNowPlayingInfoCenter") != nil {
          
            let url = NSURL(string: (defaultModel?.imagePath)!) // your url path
            //check your url or another condidtions you want
            self.downloadImage(url: url!, completion: { (image) -> Void in
                
               let albumArt = MPMediaItemArtwork.init(boundsSize: (image?.size)!, requestHandler: { (size) -> UIImage in
                    return image!
                })
                MPNowPlayingInfoCenter.default().nowPlayingInfo = [
                    MPMediaItemPropertyTitle: self.defaultModel?.title ?? "Title",
                    MPMediaItemPropertyAlbumTitle: self.defaultModel?.subCategoryTitle ?? "Catagory Name",
                    MPMediaItemPropertyArtwork :  albumArt] as [String : Any]
                
            })
        }
    }
}
