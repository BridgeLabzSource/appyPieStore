//
//  BottomBarOverlay.swift
//  APPYSTORE
//
//  Created by BridgeLabz on 08/03/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit

@IBDesignable class BottomBarOverlay: UIView {

    @IBOutlet var rootView: UIView!
    
//    func initialize()
//    {
//        UINib(nibName: "BottomBarOverlay", bundle: nil).instantiate(withOwner: self, options: nil)
//        
//        addSubview(rootView)
//        //rootView.bindFrameToSuperviewBounds()
//        rootView.frame = self.bounds
//        
//    }
//    
//    override init(frame: CGRect)
//    {
//        super.init(frame: frame)
//        initialize()
//    }
//    
//    required init?(coder aDecoder: NSCoder)
//    {
//        super.init(coder: aDecoder)
//        initialize()
//    }
    
    
    //MARK: Declarations
    var view: UIView!
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup()
    {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = UIViewAutoresizing.flexibleWidth;
        view.autoresizingMask = UIViewAutoresizing.flexibleHeight
        addSubview(view)
        
    }
    
    func loadViewFromNib() -> UIView
    {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "BottomBarOverlay", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }


}
