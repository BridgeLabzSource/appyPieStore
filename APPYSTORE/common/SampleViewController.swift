//
//  SampleViewController.swift
//  APPYSTORE
//
//  Created by ios_dev on 04/04/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit
import AVFoundation

class SampleViewController: UIViewController, VideoDelegate {
    
    @IBOutlet weak var miniFrame: UIView!
    @IBOutlet var rootView: UIView!
    
    @IBOutlet weak var videoPlayer: VideoPlayer!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let playerModel = PlayerModel()
        playerModel.url = "https://content.jwplatform.com/manifests/vM7nH0Kl.m3u8"
        videoPlayer.delegate = self
        videoPlayer.replaceVideo(playerModel: playerModel)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        videoPlayer.play()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onVideoMaximize() {
        videoPlayer.rootView.frame = rootView.frame
        videoPlayer.avPlayerLayer.frame = videoPlayer.rootView.bounds
        /*
        videoPlayer.rootView.frame.size = CGSize(width: AppDelegate.DEVICE_WIDTH, height: AppDelegate.DEVICE_HEIGHT)
        
        videoPlayer.avPlayerLayer.frame = videoPlayer.rootView.frame
        */
    }
    
    func onVideoMinimize() {
        videoPlayer.rootView.frame = miniFrame.frame
        videoPlayer.avPlayerLayer.frame = videoPlayer.rootView.bounds
        /*
        videoPlayer.rootView.frame.size = CGSize(width: AppDelegate.DEVICE_WIDTH*2/3, height: (AppDelegate.DEVICE_WIDTH*2/3)*3/4 )
        videoPlayer.avPlayerLayer.frame = videoPlayer.rootView.frame
        */
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
