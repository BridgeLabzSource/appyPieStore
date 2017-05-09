//
//  FreeTrialSuccessPopup.swift
//  APPYSTORE
//
//  Created by ios_dev on 25/04/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit

class FreeTrialSuccessPopup: BasePopUpController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showTitleLabel()
        showContentImage()
        
        setValues()
        setSpacing()
        setFontSize()
    }
    
    func setValues() {
        setTitleTextLabel("Your 15 day FREE trial has started!")
        setImageContent(UIImage(named: "trial_success")!)
    }
    
    func setSpacing() {
        setContentTopSpacing()
    }
    
    override func crossButtonClick() {
        mainControllerCommunicator?.performBackButtonClick(self)
    }
}
