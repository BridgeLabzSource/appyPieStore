//
//  AudioPlayerViewController.swift
//  APPYSTORE
//
//  Created by BridgeLabz Solutions LLP  on 5/11/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import Foundation
import UIKit

class AudioPlayerViewController:BaseViewController{
    
    @IBOutlet weak var audioPlayerView: AudioPlayer!
    
    var playerbundle:AndroidBundle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
   
    override func getPageName() -> String {
        return PageConstants.AUDIO_PLAYER_PAGE
    }
    
    override func getPageNameUniqueIdentifier() -> String {
        return ""
    }

//    func getDictionary(bundle: AndroidBundle) {
//        self.audioPlayerView.getUrl = bundle?["dnld_url"] as? String
//    }

}
