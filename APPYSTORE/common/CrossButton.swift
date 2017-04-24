//
//  RoundedButton.swift
//  APPYSTORE
//
//  Created by ios_dev on 18/04/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit

class CrossButton: UIView {

    @IBOutlet var rootView: UIView!
    @IBOutlet weak var containerView: UIView!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        nibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        nibSetup()
    }
    
    private func nibSetup() {
        let nibView: UIView = UINib(nibName: "CrossButton", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! UIView
        
        nibView.frame = bounds
        nibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        addSubview(rootView)
        
        self.layoutIfNeeded()
        //containerView.layer.backgroundColor = UIColor.red.cgColor
        //containerView.layer.cornerRadius = min(containerView.layer.frame.size.height, containerView.layer.frame.size.width) / 2.0
        nibView.layer.cornerRadius = nibView.frame.width/2
        containerView.layer.masksToBounds = true
        containerView.clipsToBounds = true
        
        containerView.layer.cornerRadius = containerView.frame.width/2
 
    }
    

}
