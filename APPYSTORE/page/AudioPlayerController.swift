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

class AudioPlayerController: BaseViewController {

    @IBOutlet weak var audioPlayer: AudioPlayer!
    
    @IBOutlet weak var backButton: CustomButton!
    
    @IBOutlet weak var audioListView: UIView!
    
    var defaultModel: AudioListingModel?
    var playerController:AudioPlayerViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    //    audioPlayer.delegate = self
  
        
    // playerController = AudioPlayerViewController()
      //  print(bundle!)
       // playerController?.playerbundle = bundle
        //  NotificationCenter.default.post(name: NSNotification.Name(rawValue: "audioData"), object: nil, userInfo: bundle)
        // let ss = bundle[BundleConstants.]
        
        self.view.bringSubview(toFront: backButton)
        backButton.addTarget(self, action: #selector(handleBackButtonClick), for: .touchUpInside)
        
    }
    
    override func getComponentProperties() -> ComponentProperties {
        let components = ComponentProperties()
        components.visibleIconsSet = [Item.BTN_BACK]
        
        return components
    }

    func handleBackButtonClick() {
        print("AudioPlayerController handleBackButtonClick")
        
        
        
        mainControllerCommunicator?.performBackButtonClick(self)
    }
    
    override func getPageName() -> String {
        return PageConstants.AUDIO_PLAYER_PAGE
    }
    
    override func getPageNameUniqueIdentifier() -> String {
        return ""
    }
    

}
