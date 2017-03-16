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
    
    @IBOutlet var videoButton : CustomButton!
    @IBOutlet var historyButton : CustomButton!
    @IBOutlet var songButton :CustomButton!
    @IBOutlet var searchButton : CustomButton!
    @IBOutlet var userButton : CustomButton!
    
    
    func initialize()
    {
        UINib(nibName: "TopBarOverlay", bundle: nil).instantiate(withOwner: self, options: nil)
        
        addSubview(rootView)
        //rootView.bindFrameToSuperviewBounds()
        rootView.frame = self.bounds

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
