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

enum AudioPlayerState {
    case PLAY
    case PAUSE
    case BUFFERING_START
    case BUFFERING_END
    case STOP
    case LOCK
}

protocol AudioDelegate {
    func onAudioCompleted()
    func onTaskStarted()
    func onTaskCompleted()
    func onNext()
    func onPrevious()
}

@IBDesignable class AudioPlayer: UIView{
    
    @IBOutlet var rootView: UIView!
    
    @IBOutlet weak var view: UIView!
   
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
    
    @IBOutlet weak var leftSeek: UIImageView!
   
    @IBOutlet weak var rightSeek: UIImageView!
   
    @IBOutlet weak var titleView: UIView!
    
    @IBOutlet weak var seekerView: UIView!
    
    @IBOutlet weak var playView: UIView!
    
    var avPlayer: AVPlayer? = AVPlayer()
    var avPlayerLayer: AVPlayerLayer!
    var timeObserver: AnyObject!
    var playerRateBeforeSeek: Float = 0
    var isMinimize = false
    var delegate: AudioDelegate?
    var task: URLSessionDataTask!
    var session: URLSession!
    var audioModel: AudioListingModel!
    let operationQueue = OperationQueue()
    
    var currentState: AudioPlayerState!
    var showControls = true
    var isParenting = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialise()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialise()
    }
    
    func replaceAudio(playerModel: AudioListingModel) {
        audioModel = playerModel
     //   pause()
        self.unregisteredPlayerItemListener()
        self.resetPlayerItem()
        
        showAudioThumbnail()
        showAudioTitle()
        showAudioCategoryTitle()
        
        if playerModel.payType == "paid" {
            updateState(state: .LOCK)
            return
        }
        
        updateState(state: .BUFFERING_START)
        print("BUFFERING_START replaceAudio")
        delegate?.onTaskStarted()
        
        let url = URL(string: playerModel.downloadUrl)

        // done now
        DispatchQueue.global(qos: .background).async {
            
            self.unregisteredPlayerItemListener()
            let playerItem = AVPlayerItem(url: url! as URL)
            self.avPlayer?.replaceCurrentItem(with: playerItem)
            self.play()
            self.registerPlayerItemListener()
        }
    }
    
    func resetPlayerItem() {
        avPlayer?.replaceCurrentItem(with: nil)
        setTotalDuration(duration: 0)
        setPlayTime(timePlayed: 0)
        setSeekValue(seekValue: 0)
    }
    
    func unregisteredPlayerItemListener() {
        NotificationCenter.default.removeObserver(self)
        self.avPlayer?.currentItem?.removeObserver(self, forKeyPath: "playbackBufferEmpty")
        self.avPlayer?.currentItem?.removeObserver(self, forKeyPath: "playbackLikelyToKeepUp")
        self.avPlayer?.currentItem?.removeObserver(self, forKeyPath: "playbackBufferFull")
        self.avPlayer?.currentItem?.removeObserver(self, forKeyPath: "status")
    }
    
    func registerPlayerItemListener() {
        NotificationCenter.default.addObserver(self, selector: #selector(AudioPlayer.playerDidFinish(note:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.avPlayer?.currentItem)
        
        self.avPlayer?.currentItem?.addObserver(self, forKeyPath: "playbackBufferEmpty", options: .new, context: nil)
        self.avPlayer?.currentItem?.addObserver(self, forKeyPath: "playbackLikelyToKeepUp", options: .new, context: nil)
        self.avPlayer?.currentItem?.addObserver(self, forKeyPath: "playbackBufferFull", options: .new, context: nil)
        
        self.avPlayer?.currentItem?.addObserver(self, forKeyPath: "status", options: .new, context: nil)
    }

    func initialise(){
        UINib(nibName: "AudioPlayer", bundle: nil).instantiate(withOwner: self, options: nil)
        makeDefaultVisibility()
        
   //   avPlayerLayer = AVPlayerLayer(player: avPlayer)
   //   view.layer.insertSublayer(avPlayerLayer, at: 0)
        
        let radius = DimensionManager.convertPixelToPoint(pixel: DimensionManager.getGeneralizedHeight1280x720(height: 64))
        
        view.layer.cornerRadius = radius
        view.clipsToBounds = true
        
        audioImage.layer.cornerRadius = radius
        audioImage.clipsToBounds = true
        
        DimensionManager.setTextSize1280x720(label: audioTitle, size: DimensionManager.H3)
        
        DimensionManager.setTextSize1280x720(label: audioCategoryTitle, size: DimensionManager.H3)
    
  //    avPlayerLayer.frame = view.bounds

        showShadowRightBottom()
     
        addSubview(rootView)
        
        DimensionManager.setTextSize1280x720(label: playTimeLabel, size: DimensionManager.H3)
        DimensionManager.setTextSize1280x720(label: totalTimeLabel, size: DimensionManager.H3)
        
        rootView.frame = self.bounds
        
        let timeInterval: CMTime = CMTimeMakeWithSeconds(1.0, 10)
        timeObserver = avPlayer?.addPeriodicTimeObserver(forInterval: timeInterval, queue: DispatchQueue.main) {
            (elapsedTime: CMTime) -> Void in
            
        print("elapsedTime now:", CMTimeGetSeconds(elapsedTime))
            self.observeTime(elapsedTime: elapsedTime)
            } as AnyObject!
        
        seekbar.addTarget(self, action: #selector(sliderBeganTracking),
                          for: .touchDown)
        seekbar.addTarget(self, action: #selector(sliderEndedTracking),
                          for: [.touchUpInside, .touchUpOutside])
        seekbar.addTarget(self, action: #selector(sliderValueChanged),
                          for: .valueChanged)
        
        let singleTapSeekbar = UITapGestureRecognizer(target: self, action: #selector(AudioPlayer.seekBarClicked))
        singleTapSeekbar.numberOfTapsRequired = 1 // you can change this value
        seekbar.addGestureRecognizer(singleTapSeekbar)

        let singleTapPlay = UITapGestureRecognizer(target: self, action: #selector(AudioPlayer.playIconClick))
        singleTapPlay.numberOfTapsRequired = 1 // you can change this value
        playIcon.isUserInteractionEnabled = true
        playIcon.addGestureRecognizer(singleTapPlay)
        
        let singleTapPause = UITapGestureRecognizer(target: self, action: #selector(AudioPlayer.pauseIconClick))
        singleTapPause.numberOfTapsRequired = 1 // you can change this value
        pauseIcon.isUserInteractionEnabled = true
        pauseIcon.addGestureRecognizer(singleTapPause)

        avPlayer?.addObserver(self, forKeyPath: "status", options: [.new], context: nil)
        avPlayer?.addObserver(self, forKeyPath: "rate", options: [.new], context: nil)
    
        let singleTapNext = UITapGestureRecognizer(target: self, action: #selector(AudioPlayer.nextIconClick))
        singleTapNext.numberOfTapsRequired = 1 // you can change this value
        rightSeek.isUserInteractionEnabled = true
        rightSeek.addGestureRecognizer(singleTapNext)
        
        let singleTapPrevious = UITapGestureRecognizer(target: self, action: #selector(AudioPlayer.previousIconClick))
        singleTapPrevious.numberOfTapsRequired = 1 // you can change this value
        leftSeek.isUserInteractionEnabled = true
        leftSeek.addGestureRecognizer(singleTapPrevious)

        avPlayer?.automaticallyWaitsToMinimizeStalling = false
        hideLockIcon()
        updateState(state: .BUFFERING_START)
        print("BUFFERING_START initialize")
    }
    
    func seekBarClicked(gesture: UITapGestureRecognizer) {
        print("seekBarClicked called")
        playerRateBeforeSeek = (avPlayer?.rate)!
        avPlayer?.pause()
        let pointTapped = gesture.location(in: self.rootView)
        let positionOfSlider = seekbar.frame.origin
        let sliderWidth = seekbar.frame.size.width
        let newValue = (pointTapped.x - positionOfSlider.x) * CGFloat(seekbar.maximumValue)/sliderWidth
        seekbar.setValue(Float(newValue), animated: true)
        
        let audioDuration = CMTimeGetSeconds((avPlayer?.currentItem!.duration)!)
        let elapsedTime: Float64 = audioDuration * Float64(seekbar.value)
        updateTimeLabel(elapsedTime: elapsedTime, duration: audioDuration)
        
        avPlayer?.seek(to: CMTimeMakeWithSeconds(elapsedTime, 100)) { (completed: Bool) -> Void in
            if self.playerRateBeforeSeek > 0 {
                self.play()
            }
        }
    }

    func makeDefaultVisibility()
    {
        hideLoader()
        hidePlayIcon()
        hidePauseIcon()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "status" && object is AVPlayer {
            if avPlayer?.status == .readyToPlay {
                print("Ganesh status observer readyToPlay")
            } else if avPlayer?.status == .failed {
                print("Ganesh status observer failed")
            } else if avPlayer?.status == .unknown {
                print("Ganesh status observer unknown")
            }
        }
        
        if keyPath == "status" && object is AVPlayerItem {
            if avPlayer?.currentItem?.status == .readyToPlay {
                print("Ganesh status currentItem observer readyToPlay")
                
            } else if avPlayer?.currentItem?.status == .failed {
                print("Ganesh status currentItem observer failed")
                updateState(state: .PAUSE)
                if audioModel != nil {
                    replaceAudio(playerModel: audioModel)
                }
            } else if avPlayer?.currentItem?.status == .unknown {
                print("Ganesh status currentItem observer unknown")
            }
        }
        
        if keyPath == "rate" {
            if avPlayer?.rate == 0.0 {
                print("XXXXX Ganesh state is paused rate = \(avPlayer?.rate)")
                updateState(state: .PAUSE)
            } else {
                print("XXXXX Ganesh state is play rate = \(avPlayer?.rate)")
                updateState(state: .PLAY)
            }
        }
        
        if object is AVPlayerItem {
            switch keyPath! {
            case "playbackBufferEmpty":
                print("XXXXX Ganesh show loader playbackBufferEmpty")
                if avPlayer?.currentItem?.status != AVPlayerItemStatus.readyToPlay {
                    updateState(state: .PAUSE)
                } else {
                    updateState(state: .BUFFERING_START)
                    print("BUFFERING_START observeValue ")
                }
                print("XXXXX Ganesh show loader \(getCurrentItemStatus())")
                
            case "playbackLikelyToKeepUp":
                print("XXXXX Ganesh hide loader playbackLikelyToKeepUp = \(avPlayer?.currentItem?.isPlaybackLikelyToKeepUp)")
                updateState(state: .BUFFERING_END)
            case "playbackBufferFull":
                print("XXXXX Ganesh hide loader playbackBufferFull")
                updateState(state: .BUFFERING_END)
            default:
                break
            }
        }
        print("Ganesh timestatus = \(avPlayer?.timeControlStatus.rawValue)\n")
        
        print("Change at keyPath = \(keyPath) for \(object)")
    }

    func updateState(state: AudioPlayerState) {
        showControls = true
        currentState = state
        switch state {
        case .PLAY:
            print("updateState: PLAY")
            showPauseIcon()
            hidePlayIcon()
            hideLoader()
            hideLockIcon()
        case .PAUSE:
            print("updateState: PAUSE")
            showPlayIcon()
            hidePauseIcon()
            hideLoader()
            hideLockIcon()
        case .BUFFERING_START:
            print("updateState: BUFFERING_START")
            showLoader()
            hidePlayIcon()
            hidePauseIcon()
            
        case .BUFFERING_END:
            print("updateState: BUFFERING_END")
            self.delegate?.onTaskCompleted()
            self.updateTotalDuration()
            if avPlayer?.rate == 0 {
                updateState(state: .PAUSE)
            } else {
                updateState(state: .PLAY)
            }
        case .STOP:
            print("updateState: STOP")
            showPlayIcon()
            hidePauseIcon()
            hideLoader()
            hideLockIcon()
            self.unregisteredPlayerItemListener()
            resetPlayerItem()
            break
        case .LOCK:
            print("updateState: LOCK")
            showLockIcon()
            hideLoader()
            hidePlayIcon()
            hidePauseIcon()
            break
        }
        
        if avPlayer?.status == .readyToPlay {
            print("Ganesh status readyToPlay")
        } else if avPlayer?.status == .failed {
            print("Ganesh status failed")
        } else if avPlayer?.status == .unknown {
            print("Ganesh status unknown")
        }
        
        if avPlayer?.currentItem?.status == .readyToPlay {
            print("Ganesh status currentItem readyToPlay")
        } else if avPlayer?.currentItem?.status == .failed {
            print("Ganesh status currentItem failed")
        } else if avPlayer?.currentItem?.status == .unknown {
            print("Ganesh status currentItem unknown")
        }
        
        print("Ganesh status player rate \(avPlayer?.rate)")
        print("Ganesh status error \(avPlayer?.error)")
        print("Ganesh status timeControlStatus \(getTimeStatus())")
    }
    
    func getCurrentItemStatus() -> String {
        var s = ""
        if avPlayer?.currentItem?.status == .readyToPlay {
            s = "readyToPlay"
        } else if avPlayer?.currentItem?.status == .failed {
            s = "failed"
        } else if avPlayer?.currentItem?.status == .unknown {
            s = "unknown"
        }
        
        return s
    }

    func getTimeStatus() -> String {
        var s = ""
        if let status = avPlayer?.timeControlStatus {
            switch status {
            case .paused:
                s = "paused"
            case .playing:
                s = "playing"
            case .waitingToPlayAtSpecifiedRate:
                s = "waitingToPlayAtSpecifiedRate"
            }
        }
        return s
    }

    func playerDidFinish(note: NSNotification) {
        print("Ganesh Audio Finished")
        updateState(state: .STOP)
        delegate?.onAudioCompleted()
    }

    func play() {
        if avPlayer?.currentItem != nil {
            MusicHelper.sharedHelper.audioPlayer?.pause()

            avPlayer?.play()
            print("play() func \(getCurrentItemStatus())")
        } else {
            if audioModel != nil {
                replaceAudio(playerModel: audioModel)
            }
        }
    }

    func pause() {
        avPlayer?.pause()
        MusicHelper.sharedHelper.audioPlayer?.play()
    }
    
//    func stop(){
//        avPlayer?.replaceCurrentItem(with: nil)
//   //     MusicHelper.sharedHelper.audioPlayer?.play()
//    }
    
    func trackAudioSeekbar() {
        let audioDuration = CMTimeGetSeconds((avPlayer?.currentItem!.duration)!)
        
        let normalizedTime = Float(CMTimeGetSeconds((avPlayer?.currentItem!.currentTime())!) * 1.0 / audioDuration)
        setSeekValue(seekValue: normalizedTime)
    }

    private func setSeekValue(seekValue: Float) {
        print("AudioPlayer setSeekValue value: \(seekValue)")
        seekbar.value = seekValue
    }
    
    func playIconClick() {
        print("playIcon Clicked")
        play()
        
    }
    
    func pauseIconClick() {
        print("pauseIcon Clicked")
        avPlayer?.pause()
        MusicHelper.sharedHelper.audioPlayer?.play()
    }

    func nextIconClick() {
        delegate?.onNext()
    }
    
    func previousIconClick() {
        delegate?.onPrevious()
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

    func showAudioThumbnail() {
        if audioModel != nil {
            print("updateState : showAudioThumbnail")
            let imgurl = URL(string: audioModel.imagePath)
            audioImage.sd_setImage(with:imgurl, placeholderImage:#imageLiteral(resourceName: "profile") )
            audioImage.isHidden = false
        }
    }

    func showAudioTitle()
    {
        if audioModel != nil {
            print("updateState : showAudioTitle")
            audioTitle.text = audioModel.title
        }
    }
    
    func showAudioCategoryTitle()
    {
        if audioModel != nil {
            print("updateState : showAudioCategoryTitle")
            audioCategoryTitle.text = audioModel.subCategoryTitle
        }
    }
    
    func hideLoader() {
        loader.isHidden = true
        loader.stopAnimating()
    }
    
    func showLoader() {
        loader.layer.zPosition = 1
        loader.isHidden = false
        loader.startAnimating()
    }
    
    func sliderBeganTracking(slider: UISlider) {
        playerRateBeforeSeek = (avPlayer?.rate)!
        avPlayer?.pause()
    }

    func sliderEndedTracking(slider: UISlider) {
        let audioDuration = CMTimeGetSeconds((avPlayer?.currentItem!.duration)!)
        let elapsedTime: Float64 = audioDuration * Float64(seekbar.value)
        updateTimeLabel(elapsedTime: elapsedTime, duration: audioDuration)
        
        avPlayer?.seek(to: CMTimeMakeWithSeconds(elapsedTime, 100)) { (completed: Bool) -> Void in
            if self.playerRateBeforeSeek > 0 {
                self.play()
            }
        }
    }

    func sliderValueChanged(slider: UISlider) {
        let audioDuration = CMTimeGetSeconds((avPlayer?.currentItem!.duration)!)
        let elapsedTime: Float64 = audioDuration * Float64(seekbar.value)
        updateTimeLabel(elapsedTime: elapsedTime, duration: audioDuration)
    }

    private func observeTime(elapsedTime: CMTime) {
        if avPlayer?.currentItem != nil {
            let duration = CMTimeGetSeconds((avPlayer?.currentItem!.duration)!)
            let elapsedTime = CMTimeGetSeconds(elapsedTime)
            updateTimeLabel(elapsedTime: elapsedTime, duration: duration)
            trackAudioSeekbar()
        }
    }
    
    private func updateTimeLabel(elapsedTime: Float64, duration: Float64) {
        let timePlayed: Float64 = elapsedTime
        
        setPlayTime(timePlayed: timePlayed)
        //updateTotalDuration()
    }
    
    private func setPlayTime(timePlayed: Double) {
        playTimeLabel.text = String(format: "%02d:%02d", ((lround(timePlayed) / 60) % 60), lround(timePlayed) % 60)
    }
    
    private func updateTotalDuration() {
        if avPlayer != nil{
            
            print("Current time in duration:",((avPlayer?.currentItem?.currentTime().seconds)! as Double))
            print("Total time in duration:",(avPlayer?.currentItem?.duration.seconds)! as Double)
            let duration = CMTimeGetSeconds((avPlayer?.currentItem!.asset.duration)!)
            print("************",(avPlayer?.currentItem)!)
            setTotalDuration(duration: duration)
        }
    }

    private func setTotalDuration(duration: Double) {
        totalTimeLabel.text = String(format: "%02d:%02d", ((lround(duration) / 60) % 60), lround(duration) % 60)
        print("total*******time->",totalTimeLabel.text!)
    }
    
    deinit {
        avPlayer?.removeTimeObserver(timeObserver)
        //avPlayer.removeObserver(self, forKeyPath: "currentItem.playbackLikelyToKeepUp")
    }
}
