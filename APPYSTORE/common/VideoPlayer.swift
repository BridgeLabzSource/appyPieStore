//
//  VideoPlayer.swift
//  APPYSTORE
//
//  Created by ios_dev on 04/04/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit
import AVFoundation
import SwiftyJSON
import Alamofire

enum PlayerState {
    case PLAY
    case PAUSE
    case BUFFERING_START
    case BUFFERING_END
    case STOP
    case LOCK
}

protocol VideoDelegate {
    func onContainerClick()
    func onVideoCompleted()
    func onTaskStarted()
    func onTaskCompleted()
    func onNext()
    func onPrevious()
}

@IBDesignable class VideoPlayer: UIView {
    
    @IBOutlet weak var rightSeek: UIImageView!
    @IBOutlet weak var totalTimeLabel: UILabel!
    @IBOutlet weak var playTimeLabel: UILabel!
    @IBOutlet weak var playIcon: UIImageView!
    @IBOutlet var rootView: UIView!
    @IBOutlet weak var pauseIcon: UIImageView!
    @IBOutlet weak var seekbar: UISlider!
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var leftSeek: UIImageView!
    @IBOutlet weak var containerView: UIView!
    
    var avPlayer: AVPlayer? = AVPlayer()
    var avPlayerLayer: AVPlayerLayer!
    var timeObserver: AnyObject!
    var playerRateBeforeSeek: Float = 0
    var isMinimize = false
    var delegate: VideoDelegate?
    var task: URLSessionDataTask!
    var session: URLSession!
    var videoModel: VideoListingModel!
    let operationQueue = OperationQueue()
    
    @IBOutlet weak var lockIcon: UIImageView!
    @IBOutlet weak var videoThumbnail: UIImageView!
    
    var currentState: PlayerState!
    var showControls = true
    var isParenting = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    func replaceVideo(playerModel: VideoListingModel) {
        videoModel = playerModel
        pause()
        self.unregisteredPlayerItemListener()
        resetPlayerItem()
        
        showVideoThumbnail()
        if playerModel.payType == "paid" {
            updateState(state: .LOCK)
            return
        }
        
        updateState(state: .BUFFERING_START)
        print("BUFFERING_START replaceVideo")
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
        
        //self.updateTotalDuration()
        
        Alamofire.request(url!, parameters: nil, headers: HttpRequestBuilder.getHeaders()).response{ response in
            // this code has to be removed as we are playing video directly using download url
            /*
            Prefs.getInstance()?.setHistoryPageToBeForceRefreshed(forceRefresh: true)
            print("VideoPlayer : url response: \(response)")
            print("VideoPlayer : response url \(response.response?.url)")
            
            self.delegate?.onTaskCompleted()
            self.hideVideoThumbnail()
            
            self.updateState(state: .BUFFERING_END)
            if response.response?.statusCode == 200 {
                print("replaceVideo = \(response.response?.url)")
                self.unregisteredPlayerItemListener()
                let url = response.response?.url
                let playerItem = AVPlayerItem(url: url! as URL)
                self.avPlayer?.replaceCurrentItem(with: playerItem)
                self.play()
                self.registerPlayerItemListener()
                self.updateTotalDuration()
            } else if response.error != nil {
                print("Api request error")
                self.showVideoThumbnail()
                self.updateState(state: .PAUSE)
            }
            */
        }
    }
    
    func replaceVideo1(playerModel: VideoListingModel) {
        videoModel = playerModel
        print("replaceVideo type = \(playerModel.payType)")
        
        print("VideoPlayer content change")
        pause()
        self.unregisteredPlayerItemListener()
        resetPlayerItem()
        
        if task != nil {
            task.cancel()
            var state = ""
            switch task.state {
            case .canceling:
                state = " canceling"
            case .completed:
                state = " completed"
            case .running:
                state = " running"
            case .suspended:
                state = " suspended"
            }
            print("Task State : \(state)")
        }
        
        
        showVideoThumbnail()
        if playerModel.payType == "paid" {
            updateState(state: .LOCK)
            return
        }
        
        updateState(state: .BUFFERING_START)
        print("BUFFERING_START replaceVideo")
        delegate?.onTaskStarted()
        
        var request = URLRequest(url: URL(string: playerModel.downloadUrl)!)
        
        print("Request url : \(request.url)")
        session = URLSession.shared
        request.httpMethod = "POST"
        request.timeoutInterval = 5
        task = session.dataTask(with: request, completionHandler: {
            data, response, error in
            
            DispatchQueue.main.async {
                self.delegate?.onTaskCompleted()
                self.hideVideoThumbnail()
                print("VideoPlayer content response")
                print("Task Error: \(error)")
                print("Response: \(response) ")
                self.updateState(state: .BUFFERING_END)
                if response != nil {
                    print("Api request success")
                    if let value = response {
                        print("Description = \(value.description)")
                    }
                    
                    print("cdn Url = \(response?.url)")
                    
                    self.unregisteredPlayerItemListener()
                    //let url = NSURL(string: stringUrl)
                    let url = response?.url
                    let playerItem = AVPlayerItem(url: url! as URL)
                    self.avPlayer?.replaceCurrentItem(with: playerItem)
                    self.play()
                    self.registerPlayerItemListener()
                    self.updateTotalDuration()
                } else if error != nil {
                    print("Api request error")
                    self.showVideoThumbnail()
                    self.updateState(state: .PAUSE)
                }
            }
            
        })
        
        task.resume()
    
    }
    
    func resetPlayerItem() {
        avPlayer?.replaceCurrentItem(with: nil)
        setTotalDuration(duration: 0)
        setPlayTime(timePlayed: 0)
        setSeekValue(seekValue: 0)
    }
    
    func registerPlayerItemListener() {
        NotificationCenter.default.addObserver(self, selector: #selector(VideoPlayer.playerDidFinish(note:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.avPlayer?.currentItem)
        
        self.avPlayer?.currentItem?.addObserver(self, forKeyPath: "playbackBufferEmpty", options: .new, context: nil)
        self.avPlayer?.currentItem?.addObserver(self, forKeyPath: "playbackLikelyToKeepUp", options: .new, context: nil)
        self.avPlayer?.currentItem?.addObserver(self, forKeyPath: "playbackBufferFull", options: .new, context: nil)
        
        self.avPlayer?.currentItem?.addObserver(self, forKeyPath: "status", options: .new, context: nil)
    }
    
    func unregisteredPlayerItemListener() {
        NotificationCenter.default.removeObserver(self)
        self.avPlayer?.currentItem?.removeObserver(self, forKeyPath: "playbackBufferEmpty")
        self.avPlayer?.currentItem?.removeObserver(self, forKeyPath: "playbackLikelyToKeepUp")
        self.avPlayer?.currentItem?.removeObserver(self, forKeyPath: "playbackBufferFull")
        self.avPlayer?.currentItem?.removeObserver(self, forKeyPath: "status")
    }
    
    func initialize() {
        UINib(nibName: "VideoPlayer", bundle: nil).instantiate(withOwner: self, options: nil)
        makeDefaultVisibility()
        avPlayerLayer = AVPlayerLayer(player: avPlayer)
        containerView.layer.insertSublayer(avPlayerLayer, at: 0)
        
        addSubview(rootView)
        
        DimensionManager.setTextSize1280x720(label: playTimeLabel, size: DimensionManager.H3)
        DimensionManager.setTextSize1280x720(label: totalTimeLabel, size: DimensionManager.H3)
        //rootView.bindFrameToSuperviewBounds()
        rootView.frame = self.bounds
        avPlayerLayer.frame = containerView.bounds
        
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
        
        let singleTapSeekbar = UITapGestureRecognizer(target: self, action: #selector(VideoPlayer.seekBarClicked))
        singleTapSeekbar.numberOfTapsRequired = 1 // you can change this value
        seekbar.addGestureRecognizer(singleTapSeekbar)
        
        let singleTapPlay = UITapGestureRecognizer(target: self, action: #selector(VideoPlayer.playIconClick))
        singleTapPlay.numberOfTapsRequired = 1 // you can change this value
        playIcon.isUserInteractionEnabled = true
        playIcon.addGestureRecognizer(singleTapPlay)
        
        let singleTapPause = UITapGestureRecognizer(target: self, action: #selector(VideoPlayer.pauseIconClick))
        singleTapPause.numberOfTapsRequired = 1 // you can change this value
        pauseIcon.isUserInteractionEnabled = true
        pauseIcon.addGestureRecognizer(singleTapPause)
        
        avPlayer?.addObserver(self, forKeyPath: "status", options: [.new], context: nil)
        avPlayer?.addObserver(self, forKeyPath: "rate", options: [.new], context: nil)
        
        let singleTapContainer = UITapGestureRecognizer(target: self, action: #selector(VideoPlayer.containerClick))
        singleTapContainer.numberOfTapsRequired = 1 // you can change this value
        containerView.isUserInteractionEnabled = true
        containerView.addGestureRecognizer(singleTapContainer)
        
        let singleTapBottom = UITapGestureRecognizer(target: self, action: #selector(VideoPlayer.bottomContainerClick))
        singleTapBottom.numberOfTapsRequired = 1 // you can change this value
        bottomView.isUserInteractionEnabled = true
        bottomView.addGestureRecognizer(singleTapBottom)
        
        let singleTapNext = UITapGestureRecognizer(target: self, action: #selector(VideoPlayer.nextIconClick))
        singleTapNext.numberOfTapsRequired = 1 // you can change this value
        rightSeek.isUserInteractionEnabled = true
        rightSeek.addGestureRecognizer(singleTapNext)
        
        let singleTapPrevious = UITapGestureRecognizer(target: self, action: #selector(VideoPlayer.previousIconClick))
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
        
        let videoDuration = CMTimeGetSeconds((avPlayer?.currentItem!.duration)!)
        let elapsedTime: Float64 = videoDuration * Float64(seekbar.value)
        updateTimeLabel(elapsedTime: elapsedTime, duration: videoDuration)
        
        avPlayer?.seek(to: CMTimeMakeWithSeconds(elapsedTime, 100)) { (completed: Bool) -> Void in
            if self.playerRateBeforeSeek > 0 {
                self.play()
            }
        }
    }
    
    func bottomContainerClick() {
        print("bottomContainerClick")
    }
    
    func containerClick() {
        print("containerClick")
        if isParenting {
            if currentState != PlayerState.BUFFERING_START {
                showControls = !showControls
                if showControls {
                    showParentingControls()
                } else {
                    hideParentingControls()
                }
            }
            
        } else {
            delegate?.onContainerClick()
        }
        
    }
    
    func makeDefaultVisibility() {
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
                showVideoThumbnail()
                updateState(state: .PAUSE)
                if videoModel != nil {
                    replaceVideo(playerModel: videoModel)
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
    
    func updateState(state: PlayerState) {
        showControls = true
        currentState = state
        switch state {
        case .PLAY:
            print("updateState: PLAY")
            //hideVideoThumbnail()
            showPauseIcon()
            hidePlayIcon()
            hideLoader()
            hideLockIcon()
        case .PAUSE:
            print("updateState: PAUSE")
            //hideVideoThumbnail()
            showPlayIcon()
            hidePauseIcon()
            hideLoader()
            hideLockIcon()
        case .BUFFERING_START:
            if isParenting {
                bottomView.isHidden = false
            }
            print("updateState: BUFFERING_START")
            showLoader()
            hidePlayIcon()
            hidePauseIcon()
            
        case .BUFFERING_END:
            print("updateState: BUFFERING_END")
            self.hideVideoThumbnail()
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
            showVideoThumbnail()
            //hideVideoThumbnail()
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
        print("Ganesh Video Finished")
        updateState(state: .STOP)
        delegate?.onVideoCompleted()
    }
    
    func play() {
        if avPlayer?.currentItem != nil {
            MusicHelper.sharedHelper.audioPlayer?.pause()
            avPlayer?.play()
            print("play() func \(getCurrentItemStatus())")
        } else {
            if videoModel != nil {
                replaceVideo(playerModel: videoModel)
            }
        }
    }
    
    func pause() {
        avPlayer?.pause()
    }
    
    func trackVideoSeekbar() {
        let videoDuration = CMTimeGetSeconds((avPlayer?.currentItem!.duration)!)
        
        let normalizedTime = Float(CMTimeGetSeconds((avPlayer?.currentItem!.currentTime())!) * 1.0 / videoDuration)
        setSeekValue(seekValue: normalizedTime)
    }
    
    private func setSeekValue(seekValue: Float) {
        print("VideoPlayer setSeekValue value: \(seekValue)")
        seekbar.value = seekValue
    }
    
    func playIconClick() {
        print("playIcon Clicked")
        //invisibleButtonTapped()
        play()
        
    }
    
    func pauseIconClick() {
        print("pauseIcon Clicked")
        //invisibleButtonTapped()
        avPlayer?.pause()
        MusicHelper.sharedHelper.audioPlayer?.play()
    }
    
    func nextIconClick() {
        delegate?.onNext()
    }
    
    func previousIconClick() {
        delegate?.onPrevious()
    }
    
    func invisibleButtonTapped() {
        let playerIsPlaying = (avPlayer?.rate)! > Float.init(integerLiteral: 0)
        if playerIsPlaying {
            avPlayer?.pause()
        } else {
            play()
        }
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
    
    func showVideoThumbnail() {
        if videoModel != nil {
            print("updateState : showVideoThumbnail")
            let imgurl = URL(string: videoModel.imagePath)
            videoThumbnail.sd_setImage(with:imgurl, placeholderImage:#imageLiteral(resourceName: "profile") )
            videoThumbnail.isHidden = false
        }
    }
    
    func hideVideoThumbnail() {
        print("updateState : hideVideoThumbnail")
        videoThumbnail.isHidden = true
    }
    
    func showLoader() {
        loader.layer.zPosition = 1
        loader.isHidden = false
        loader.startAnimating()
    }
    
    func hideLoader() {
        loader.isHidden = true
        loader.stopAnimating()
    }
    
    func sliderBeganTracking(slider: UISlider) {
        playerRateBeforeSeek = (avPlayer?.rate)!
        avPlayer?.pause()
    }
    
    func sliderEndedTracking(slider: UISlider) {
        let videoDuration = CMTimeGetSeconds((avPlayer?.currentItem!.duration)!)
        let elapsedTime: Float64 = videoDuration * Float64(seekbar.value)
        updateTimeLabel(elapsedTime: elapsedTime, duration: videoDuration)
        
        avPlayer?.seek(to: CMTimeMakeWithSeconds(elapsedTime, 100)) { (completed: Bool) -> Void in
            if self.playerRateBeforeSeek > 0 {
                self.play()
            }
        }
    }
    
    func sliderValueChanged(slider: UISlider) {
        let videoDuration = CMTimeGetSeconds((avPlayer?.currentItem!.duration)!)
        let elapsedTime: Float64 = videoDuration * Float64(seekbar.value)
        updateTimeLabel(elapsedTime: elapsedTime, duration: videoDuration)
    }
    
    private func observeTime(elapsedTime: CMTime) {
        if avPlayer?.currentItem != nil {
            let duration = CMTimeGetSeconds((avPlayer?.currentItem!.duration)!)
            let elapsedTime = CMTimeGetSeconds(elapsedTime)
            updateTimeLabel(elapsedTime: elapsedTime, duration: duration)
            trackVideoSeekbar()
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
            let duration = CMTimeGetSeconds((avPlayer?.currentItem!.asset.duration)!)
            setTotalDuration(duration: duration)
        }
    }
    
    private func setTotalDuration(duration: Double) {
        totalTimeLabel.text = String(format: "%02d:%02d", ((lround(duration) / 60) % 60), lround(duration) % 60)
        print("total*******time->",totalTimeLabel.text!)
    }
    
    func showParentingControls() {
        bottomView.isHidden = false
        updateState(state: currentState)
    }
    
    func hideParentingControls() {
        bottomView.isHidden = true
        hideLockIcon()
        hideLoader()
        hidePlayIcon()
        hidePauseIcon()
    }
    
    deinit {
        avPlayer?.removeTimeObserver(timeObserver)
        //avPlayer.removeObserver(self, forKeyPath: "currentItem.playbackLikelyToKeepUp")
    }
    
    /*
     let url = URL(string: playerModel.downloadUrl)
     let task = URLSession.shared.dataTask(with: url!) {
     (data, response, error ) in
     
     
     print("replaceVideo = \(response)")
     //print("replaceVideo Data \(data)")
     //print("replaceVideo Response \(response)")
     //print("replaceVideo Error \(error)")
     }
     
     task.resume()
     */
}
