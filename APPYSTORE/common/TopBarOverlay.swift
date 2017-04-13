//
//  TopBarOverlay.swift
//  APPYSTORE
//
//  Created by BridgeLabz on 08/03/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit

@IBDesignable class TopBarOverlay: UIView {
    
    @IBOutlet var rootView: UIView!
    
    @IBOutlet var btnBack : CustomButton!
    @IBOutlet var imgChild : UIImageView!
    @IBOutlet var btnVideo : CustomButton!
    @IBOutlet var btnHistory : CustomButton!
    @IBOutlet var btnAudio :CustomButton!
    @IBOutlet var btnSearch : CustomButton!
    @IBOutlet weak var tfSearch: UITextField!
    
    @IBOutlet weak var lblVideos: UILabel!
    @IBOutlet weak var lblSongs: UILabel!
    @IBOutlet weak var lblHistory: UILabel!
    
    func initialize()
    {
        UINib(nibName: "TopBarOverlay", bundle: nil).instantiate(withOwner: self, options: nil)
        
        addSubview(rootView)
        rootView.frame = self.bounds
        
        
        DimensionManager.setTextSize1280x720(label: lblVideos, size: DimensionManager.H3)
        DimensionManager.setTextSize1280x720(label: lblSongs, size: DimensionManager.H3)
        DimensionManager.setTextSize1280x720(label: lblHistory, size: DimensionManager.H3)
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        initialize()
    }

}

