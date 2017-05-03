//
//  BuySubscriptionPopUp.swift
//  APPYSTORE
//
//  Created by ios_dev on 26/04/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit

class BuySubscriptionPopUp: BasePopUpController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showTitleStackView()
        showTitleLabel()
        showContentStackView()
        showContentImage()
        showContentLabel()
        showButtonStackView()
        showFirstButton()
        showSecondButton()
        
        
        setValues()
        setFontSize()
    }
    
    func setValues() {
        setTitleTextLabel("Get AppyStore 2 month offer pack for just Rs 599/-")
        setContentTextLabel("Unlimited videos & 25+ Free Worksheets")
        setFirstButtonTextLabel("Request call back")
        setSecondButtonTextLabel("Buy Now")
        
        setImageContent(UIImage(named: "subscription_open_user")!)
    }
    
    override func crossButtonClick() {
        print("BuySubscriptionPopUp crossButtonClick")
        mainControllerCommunicator?.performBackButtonClick()
    }
    
    override func firstButtonClick() {
        print("BuySubscriptionPopUp firstButtonClick")
    }
    
    override func secondButtonClick() {
        print("BuySubscriptionPopUp secondButtonClick")
    }
}
