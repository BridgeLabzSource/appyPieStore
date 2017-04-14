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

enum PlayerState {
    case PLAY
    case PAUSE
    case BUFFERING_START
    case BUFFERING_END
    case STOP
}

protocol VideoDelegate {
    func onVideoMinimize()
    func onVideoMaximize()
    func onVideoCompleted()
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
    
    let avPlayer = AVPlayer()
    var avPlayerLayer: AVPlayerLayer!
    var timeObserver: AnyObject!
    var playerRateBeforeSeek: Float = 0
    var isMinimize = false
    var delegate: VideoDelegate?
    var task: URLSessionDataTask!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    func replaceVideo(playerModel: VideoListingModel) {
        if task != nil {
            task.cancel()
        }
    
        print("VideoPlayer content change")
        pause()
        self.unregisteredPlayerItemListener()
        resetPlayerItem()
        
        updateState(state: .BUFFERING_START)
    
        if playerModel.downloadUrl.isEmpty {
            playerModel.downloadUrl = "http://www.appystore.in/Be-Dead-To-The-World--Idiom/dw/G1171Z191E193T9C20087824S1/20087824"
        }
        
        var request = URLRequest(url: URL(string: playerModel.downloadUrl)!)
        
        print("Request url : \(request.url)")
        let session = URLSession.shared
        request.httpMethod = "GET"
        task = session.dataTask(with: request, completionHandler: {
            data, response, error in
            
            print("VideoPlayer content response")
            print("Error: \(error)")
            print("Response: \(response) ")
            self.updateState(state: .BUFFERING_END)
            if response != nil {
                if let value = response {
                    print("Description = \(value.description)")
                }
                
                print("replaceVideo = \(response?.url)")
                
                self.unregisteredPlayerItemListener()
                //let url = NSURL(string: stringUrl)
                let url = response?.url
                let playerItem = AVPlayerItem(url: url! as URL)
                self.avPlayer.replaceCurrentItem(with: playerItem)
                self.avPlayer.play()
                self.registerPlayerItemListener()
            }
            
        })
        
        task.resume()
        print("cdn url = \(playerModel.downloadUrl)")
    
    }
    
    func resetPlayerItem() {
        avPlayer.replaceCurrentItem(with: nil)
        setTotalDuration(duration: 0)
        setPlayTime(timePlayed: 0)
        setSeekValue(seekValue: 0)
    }
    
    func registerPlayerItemListener() {
        NotificationCenter.default.addObserver(self, selector: #selector(VideoPlayer.playerDidFinish(note:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.avPlayer.currentItem)
        
        self.avPlayer.currentItem?.addObserver(self, forKeyPath: "playbackBufferEmpty", options: .new, context: nil)
        self.avPlayer.currentItem?.addObserver(self, forKeyPath: "playbackLikelyToKeepUp", options: .new, context: nil)
        self.avPlayer.currentItem?.addObserver(self, forKeyPath: "playbackBufferFull", options: .new, context: nil)
    }
    
    func unregisteredPlayerItemListener() {
        NotificationCenter.default.removeObserver(self)
        self.avPlayer.currentItem?.removeObserver(self, forKeyPath: "playbackBufferEmpty")
        self.avPlayer.currentItem?.removeObserver(self, forKeyPath: "playbackLikelyToKeepUp")
        self.avPlayer.currentItem?.removeObserver(self, forKeyPath: "playbackBufferFull")
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
        timeObserver = avPlayer.addPeriodicTimeObserver(forInterval: timeInterval, queue: DispatchQueue.main) {
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
        
        let singleTapPlay = UITapGestureRecognizer(target: self, action: #selector(VideoPlayer.playIconClick))
        singleTapPlay.numberOfTapsRequired = 1 // you can change this value
        playIcon.isUserInteractionEnabled = true
        playIcon.addGestureRecognizer(singleTapPlay)
        
        let singleTapPause = UITapGestureRecognizer(target: self, action: #selector(VideoPlayer.pauseIconClick))
        singleTapPause.numberOfTapsRequired = 1 // you can change this value
        pauseIcon.isUserInteractionEnabled = true
        pauseIcon.addGestureRecognizer(singleTapPause)
        
        avPlayer.addObserver(self, forKeyPath: "status", options: [.new], context: nil)
        avPlayer.addObserver(self, forKeyPath: "rate", options: [.new], context: nil)
        
        let singleTapContainer = UITapGestureRecognizer(target: self, action: #selector(VideoPlayer.containerClick))
        singleTapContainer.numberOfTapsRequired = 1 // you can change this value
        containerView.isUserInteractionEnabled = true
        containerView.addGestureRecognizer(singleTapContainer)
        
        let singleTapBottom = UITapGestureRecognizer(target: self, action: #selector(VideoPlayer.bottomContainerClick))
        singleTapBottom.numberOfTapsRequired = 1 // you can change this value
        bottomView.isUserInteractionEnabled = true
        bottomView.addGestureRecognizer(singleTapBottom)
        
        updateState(state: .BUFFERING_START)
        
    }
    
    func bottomContainerClick() {
        print("bottomContainerClick")
    }
    
    func containerClick() {
        print("containerClick")
        
        if isMinimize {
            delegate?.onVideoMaximize()
        } else {
            delegate?.onVideoMinimize()
        }
        
        isMinimize = !isMinimize
    }
    
    func makeDefaultVisibility() {
        hideLoader()
        hidePlayIcon()
        hidePauseIcon()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "status" {
            if avPlayer.status == .readyToPlay {
                print("Ganesh status readyToPlay")
            } else if avPlayer.status == .failed {
                print("Ganesh status failed")
            } else if avPlayer.status == .unknown {
                print("Ganesh status unknown")
            }
        }
        
        if keyPath == "rate" {
            
            if avPlayer.rate == 0.0 {
                print("XXXXX Ganesh state is paused rate = \(avPlayer.rate)")
                updateState(state: .PAUSE)
            } else {
                print("XXXXX Ganesh state is play rate = \(avPlayer.rate)")
                updateState(state: .PLAY)
            }
        
        }
        
        if object is AVPlayerItem {
            switch keyPath! {
            case "playbackBufferEmpty":
                print("XXXXX Ganesh show loader playbackBufferEmpty")
                updateState(state: .BUFFERING_START)
            case "playbackLikelyToKeepUp":
                print("XXXXX Ganesh hide loader playbackLikelyToKeepUp = \(avPlayer.currentItem?.isPlaybackLikelyToKeepUp)")
                updateState(state: .BUFFERING_END)
            case "playbackBufferFull":
                print("XXXXX Ganesh hide loader playbackBufferFull")
                updateState(state: .BUFFERING_END)
            default:
                break
            }
        }
        print("Ganesh timestatus = \(avPlayer.timeControlStatus.rawValue)\n")
        
        print("Change at keyPath = \(keyPath) for \(object)")
    }
    
    func updateState(state: PlayerState) {
        switch state {
        case .PLAY:
            showPauseIcon()
            hidePlayIcon()
            hideLoader()
        case .PAUSE:
            showPlayIcon()
            hidePauseIcon()
            hideLoader()
        case .BUFFERING_START:
            showLoader()
            hidePlayIcon()
            hidePauseIcon()
        case .BUFFERING_END:
            if avPlayer.rate == 0 {
                updateState(state: .PAUSE)
            } else {
                updateState(state: .PLAY)
            }
        case .STOP:
            showPlayIcon()
            hidePauseIcon()
            hideLoader()
            break
        }
    }
    
    func playerDidFinish(note: NSNotification) {
        print("Ganesh Video Finished")
        delegate?.onVideoCompleted()
    }
    
    func play() {
        avPlayer.play()
    }
    
    func pause() {
        avPlayer.pause()
    }
    
    func trackVideoSeekbar() {
        let videoDuration = CMTimeGetSeconds(avPlayer.currentItem!.duration)
        
        let normalizedTime = Float(CMTimeGetSeconds(avPlayer.currentItem!.currentTime()) * 1.0 / videoDuration)
        setSeekValue(seekValue: normalizedTime)
    }
    
    private func setSeekValue(seekValue: Float) {
        seekbar.value = seekValue
    }
    func playIconClick() {
        print("playIcon Clicked")
        //invisibleButtonTapped()
        avPlayer.play()
    }
    
    func pauseIconClick() {
        print("pauseIcon Clicked")
        //invisibleButtonTapped()
        avPlayer.pause()
    }
    
    func invisibleButtonTapped() {
        let playerIsPlaying = avPlayer.rate > 0
        if playerIsPlaying {
            avPlayer.pause()
        } else {
            avPlayer.play()
        }
    }
    
    func hidePlayIcon() {
        playIcon.isHidden = true
    }
    
    func showPlayIcon() {
        playIcon.isHidden = false
    }
    
    func hidePauseIcon() {
        pauseIcon.isHidden = true
    }
    
    func showPauseIcon() {
        pauseIcon.isHidden = false
    }
    
    func showLoader() {
        loader.isHidden = false
        loader.startAnimating()
    }
    
    func hideLoader() {
        loader.isHidden = true
        loader.stopAnimating()
    }
    
    func sliderBeganTracking(slider: UISlider) {
        playerRateBeforeSeek = avPlayer.rate
        avPlayer.pause()
    }
    
    func sliderEndedTracking(slider: UISlider) {
        let videoDuration = CMTimeGetSeconds(avPlayer.currentItem!.duration)
        let elapsedTime: Float64 = videoDuration * Float64(seekbar.value)
        updateTimeLabel(elapsedTime: elapsedTime, duration: videoDuration)
        
        avPlayer.seek(to: CMTimeMakeWithSeconds(elapsedTime, 100)) { (completed: Bool) -> Void in
            if self.playerRateBeforeSeek > 0 {
                self.avPlayer.play()
            }
        }
    }
    
    func sliderValueChanged(slider: UISlider) {
        let videoDuration = CMTimeGetSeconds(avPlayer.currentItem!.duration)
        let elapsedTime: Float64 = videoDuration * Float64(seekbar.value)
        updateTimeLabel(elapsedTime: elapsedTime, duration: videoDuration)
    }
    
    private func observeTime(elapsedTime: CMTime) {
        if avPlayer.currentItem != nil {
            let duration = CMTimeGetSeconds(avPlayer.currentItem!.duration)
            let elapsedTime = CMTimeGetSeconds(elapsedTime)
            updateTimeLabel(elapsedTime: elapsedTime, duration: duration)
            trackVideoSeekbar()
        }
    }
    
    private func updateTimeLabel(elapsedTime: Float64, duration: Float64) {
        let timePlayed: Float64 = elapsedTime
        
        setPlayTime(timePlayed: timePlayed)
        updateTotalDuration()
    }
    
    private func setPlayTime(timePlayed: Double) {
        playTimeLabel.text = String(format: "%02d:%02d", ((lround(timePlayed) / 60) % 60), lround(timePlayed) % 60)
    }
    
    private func updateTotalDuration() {
        let duration = CMTimeGetSeconds(avPlayer.currentItem!.duration)
        setTotalDuration(duration: duration)
    }
    
    private func setTotalDuration(duration: Double) {
        totalTimeLabel.text = String(format: "%02d:%02d", ((lround(duration) / 60) % 60), lround(duration) % 60)
    }
    
    deinit {
        avPlayer.removeTimeObserver(timeObserver)
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
