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
        
        hideSubTitleStackView()
        hideCenterStackView()
        hideButtonStackView()
        hideBottomStackView()
        
        hideTitleImage()
        hideContentLabel()
        
        setValues()
        setSpacing()
        setFontSize()
    }
    
    func setValues() {
        setTitleTextLabel("Your 15 day FREE trial has started!")
    }
    
    func setSpacing() {
        setContentTopSpacing()
    }
    
    func setFontSize() {
        setTitleFont()
    }
}
