//
//  AudioPlayer.swift
//  APPYSTORE
//
//  Created by BridgeLabz Solutions LLP  on 5/3/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit
import AVFoundation
import SwiftyJSON
import Alamofire
import AVKit

//enum PlayerState {
//    case PLAY
//    case PAUSE
//    case BUFFERING_START
//    case BUFFERING_END
//    case STOP
//    case LOCK
//}

protocol AudioDelegate {
    func onContainerClick()
    func onVideoCompleted()
    func onTaskStarted()
    func onTaskCompleted()
    func onNext()
    func onPrevious()
}

@IBDesignable class AudioPlayer: UIView{
    
    @IBOutlet var rootView: UIView!
   
    @IBOutlet weak var audioImage: UIImageView!
    
    @IBOutlet weak var audioTitle: UILabel!
    
    @IBOutlet weak var lockIcon: UIImageView!
    
    @IBOutlet weak var audioCategoryTitle: UILabel!
    
    @IBOutlet weak var seekbar: UISlider!
    
    @IBOutlet weak var playTimeLabel: UILabel!

    @IBOutlet weak var totalTimeLabel: UILabel!
    
    @IBOutlet weak var playIcon: UIImageView!
    
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    @IBOutlet weak var pauseIcon: UIImageView!
    
    @IBOutlet weak var audioPlayNextButton: UIButton!
    
    @IBOutlet weak var audioPlayPrevButton: UIButton!
    
    @IBOutlet weak var titleView: UIView!
    
    @IBOutlet weak var seekerView: UIView!
    
    @IBOutlet weak var playView: UIView!
  
    var audioplayer : AVAudioPlayer?
    var getUrl:String?
    
  //  var avPlayer: AVPlayer? = AVPlayer()
    var avPlayerLayer: AVPlayerLayer!
    var timeObserver: AnyObject!
    var playerRateBeforeSeek: Float = 0
    var isMinimize = false
   // var delegate: AudioDelegate?
    var task: URLSessionDataTask!
    var session: URLSession!
    var audioModel: AudioListingModel!
    let operationQueue = OperationQueue()
    
  //  var currentState: PlayerState!
    var showControls = true
    var isParenting = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue:"myNotification"), object: nil, queue: nil, using: startPlayer)
        initialise()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialise()
    }
//    
//    func getDictionary(bundle: AndroidBundle) {
//        self.getUrl = bundle?["dnld_url"] as? String
//    }
    func initialise(){
        UINib(nibName: "AudioPlayer", bundle: nil).instantiate(withOwner: self, options: nil)
        makeDefaultVisibility()
        showVideoThumbnail()

        addSubview(rootView)
        
        DimensionManager.setTextSize1280x720(label: playTimeLabel, size: DimensionManager.H3)
        DimensionManager.setTextSize1280x720(label: totalTimeLabel, size: DimensionManager.H3)
        
        rootView.frame = self.bounds
        do{
             let audioPath = Bundle.main.path(forResource: "song", ofType: "mp3")
            let url = URL(string: audioPath!)
       //     audioplayer?.delegate = self
            try audioplayer = AVAudioPlayer(contentsOf: url!)
            audioplayer?.play()
        }
        catch{
            //Error
        }
        
        
        
    }
    
    func startPlayer(notification:Notification) -> Void
    {
        
        guard let url123 = notification.userInfo!["dnld_url"] as? String else { return }
        self.getUrl = url123
        print("*************",url123)

    }
    
    func showVideoThumbnail() {
        if audioModel != nil {
            print("updateState : showAudioThumbnail")
            let imgurl = URL(string: audioModel.imagePath)
            audioImage.sd_setImage(with:imgurl, placeholderImage:#imageLiteral(resourceName: "profile") )
            audioImage.isHidden = false
        }
    }


    func makeDefaultVisibility()
    {
        hidePlayIcon()
        hideLoader()
        hideLockIcon()
    }
    
    func hidePlayIcon() {
        playIcon.isHidden = true
    }
    
    func showPlayIcon() {
        playIcon.layer.zPosition = 1
        playIcon.isHidden = false
    }
    
    func hidePauseIcon() {
        pauseIcon.isHidden = true
    }
    
    func showPauseIcon() {
        pauseIcon.layer.zPosition = 1
        pauseIcon.isHidden = false
    }
    
    func showLockIcon() {
        lockIcon.isHidden = false
    }
    
    func hideLockIcon() {
        lockIcon.isHidden = true
    }
    
    func hideLoader() {
        loader.isHidden = true
        loader.stopAnimating()
    }
    
    @IBAction func audioPlayPrev(_ sender: Any)
    {
        
    }
    
    @IBAction func audioPlayPause(_ sender: Any)
    {
        audioplayer?.play()
    }
    
    @IBAction func audioPlayNext(_ sender: Any)
    {
        audioplayer?.pause()
        
    }
    
//    func play() {
//        if avPlayer?.currentItem != nil {
//            avPlayer?.play()
//            print("play() func \(getCurrentItemStatus())")
//        } else {
//            if videoModel != nil {
//                replaceVideo(playerModel: videoModel)
//            }
//        }
//    }
//    
//    func pause() {
//        avPlayer?.pause()
//    }
}
