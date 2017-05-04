//
//  AudioPlayer.swift
//  APPYSTORE
//
//  Created by BridgeLabz Solutions LLP  on 5/3/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit

@IBDesignable class AudioPlayer: UIView {
    
    @IBOutlet var rootView: UIView!
    
    
    @IBOutlet weak var audioImage: UIImageView!
    
    @IBOutlet weak var audioTitle: UILabel!
    
    @IBOutlet weak var audioCategoryTitle: UILabel!
    
    @IBOutlet weak var seekbar: UISlider!
    
    @IBOutlet weak var playTimeLabel: UILabel!

    @IBOutlet weak var totalTimeLabel: UILabel!
    
    @IBOutlet weak var audioPlayButton: UIButton!
    
    @IBOutlet weak var audioPlayNextButton: UIButton!
    
    @IBOutlet weak var audioPlayPrevButton: UIButton!
    
    
    @IBOutlet weak var titleView: UIView!
    
    @IBOutlet weak var seekerView: UIView!
    
    @IBOutlet weak var playView: UIView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialise()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialise()
    }
    
    func initialise(){
        UINib(nibName: "AudioPlayer", bundle: nil).instantiate(withOwner: self, options: nil)
        
        addSubview(rootView)
        rootView.frame = self.bounds
    }

}
