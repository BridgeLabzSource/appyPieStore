//
//  BottomBarOverlay.swift
//  APPYSTORE
//
//  Created by BridgeLabz on 08/03/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView

var songname = String()
var hideMusicEquilizer = true

@IBDesignable class BottomBarOverlay: UIView {
    
    @IBOutlet weak var playerButton: UIButton!
    
    @IBOutlet var rootView: UIView!
    
    @IBOutlet var playerView: UIView!
    
    @IBOutlet weak var imageIcon: UIImageView!
    
    @IBOutlet weak var songTitle: UILabel!
    
    var audioEqualizerView: NVActivityIndicatorView?
    
    func initialize()
    {
       
        UINib(nibName: "BottomBarOverlay", bundle: nil).instantiate(withOwner: self, options: nil)
        
        _ = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(self.updatePlayerView), userInfo: nil, repeats: true);
        
        self.playerView.updateFocusIfNeeded()
        self.playerView.updateConstraints()

        playerView.layer.cornerRadius = 25
        playerButton.layer.cornerRadius = 25
        playerView.clipsToBounds = true
        
        DimensionManager.setTextSize1280x720(label: songTitle, size: DimensionManager.H3)

        addSubview(rootView)
        rootView.frame = self.bounds
    }
    
    override init(frame: CGRect)
    {
        print("\n size:",frame)
        
        print("In override init")
        super.init(frame: frame)
        initialize()
        initAudioEqualizerProgress()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        print("In required init")

        super.init(coder: aDecoder)
        initialize()
        initAudioEqualizerProgress()
    }
    
    @IBAction func playButton(_ sender: UIButton) {

    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "NotificationIdentifier"), object: nil)
        
    }

    func setSongTitle(playerModel: AudioListingModel)
    {
        print("Song Name===========>",playerModel.title)
        songTitle.backgroundColor = UIColor.red
        songname = playerModel.title
        hideMusicEquilizer = false
    }
    
    private func initAudioEqualizerProgress(){
        let frame = CGRect(x: 170, y: 10, width: self.rootView.frame.width, height: self.rootView.frame.height * 0.3)
        
        print("\n size:",frame)

        audioEqualizerView = NVActivityIndicatorView(frame: frame, type: NVActivityIndicatorType.audioEqualizer, color: UIColor.green, padding: CGFloat(0))
    }

    func updatePlayerView() {
        if songname == ""
        {
            self.playerView.isHidden = true
        }else
        {
            self.playerView.isHidden = false
        }
        songTitle.text = songname
        if pauseIconActive == true
        {
            imageIcon.image = #imageLiteral(resourceName: "play")
            hideAudioEqualizer()
        }else
        {
            imageIcon.image = #imageLiteral(resourceName: "pause")
            
            if hideMusicEquilizer == false
            {
                showAudioEqualizer()
            }
        }
        self.playerView.updateFocusIfNeeded()
        self.playerView.updateConstraints()
    }
    
    func showAudioEqualizer(){
        audioEqualizerView?.startAnimating()
        rootView.addSubview(audioEqualizerView!)
        rootView.bringSubview(toFront: audioEqualizerView!)
    }
    
    func hideAudioEqualizer(){
        audioEqualizerView?.stopAnimating()
        rootView.addSubview(audioEqualizerView!)
    }
}
