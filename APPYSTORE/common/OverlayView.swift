//
//  OverlayView.swift
//  APPYSTORE
//
//  Created by BridgeLabz on 28/02/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit

 @IBDesignable class OverlayView: UIView {
    
    //MARK: IBOutlets
    @IBOutlet weak var img: UIImageView!
    @IBOutlet var baseView: UIView!
    
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
        let nib = UINib(nibName: "OverlayView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }


}
