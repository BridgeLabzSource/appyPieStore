//
//  LoginPage.swift
//  APPYSTORE
//
//  Created by ios_dev on 03/05/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit

class LoginPage: BasePopUpController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSubTitle()
    }

    func setSubTitle() {
        //setTitleTextLabel("Start 15 day FREE Trial")
        setSubTitleTextLabel("Please enter your registered mobile number")
        //setFirstButtonTextLabel("No Thanks")
        //setSecondButtonTextLabel("Start Trial")
        //setBottomTextLabel("privacy statement: We don't share your mobile number with anyone")
    }
}
