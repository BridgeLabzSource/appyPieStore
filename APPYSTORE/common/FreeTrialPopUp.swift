//
//  FreeTrialPopUp.swift
//  APPYSTORE
//
//  Created by ios_dev on 26/04/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit

class FreeTrialPopUp: BasePopUpController {

    override func viewDidLoad() {
        super.viewDidLoad()
        hideTitleImage()
        hideContentStackView()
        
        setValues()
        setSpacing()
        setFontSize()
    }
    
    func setValues() {
        setTitleTextLabel("Start 15 day FREE Trial")
        setSubTitleTextLabel("Give your mobile number to unlock all videos")
        setFirstButtonTextLabel("No Thanks")
        setSecondButtonTextLabel("Start Trial")
        setBottomTextLabel("privacy statement: We don't share your mobile number with anyone")
    }
    
    func setSpacing() {
        setSubTitleTopSpacing()
        setCenterTopSpacing()
        setButtonTopSpacing()
        setBottomTopSpacing()
    }
    
    func setFontSize() {
        setSubTitleFont()
        setBottomTitleFont()
        setFirstButtonSize()
        setSecondButtonSize()
        setCenterTextSize()
    }
    
    override func crossButtonClick() {
        mainControllerCommunicator?.performBackButtonClick()
    }
    
    override func firstButtonClick() {
        mainControllerCommunicator?.performBackButtonClick()
    }
    
    override func secondButtonClick() {
        FreeTrialParser().parse(params: HttpRequestBuilder.getOtpRequestParameters(method: FreeTrialParser.METHOD_NAME, msisdn: centerEditText.text!, smmKey: "appyt-f", androidId: "a5b9d7b7fe1425ea", imei: "865980023857656"), completion: {
            statusType, result in
            
            print("FreeTrialPopUp \(result)")
        })
    }
    
}