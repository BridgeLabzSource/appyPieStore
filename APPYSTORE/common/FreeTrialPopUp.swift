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
        
        showTitleLabel()
        showSubTitleLabel()
        showCenterEditText()
        showFirstButton()
        showSecondButton()
        showBottomLabelOne()
        
        setValues()
    }
    
    func setValues() {
        setTitleTextLabel("Start 15 day FREE Trial")
        setSubTitleTextLabel("Give your mobile number to unlock all videos")
        setFirstButtonTextLabel("No Thanks")
        setSecondButtonTextLabel("Start Trial")
        setBottomTextLabelOne("privacy statement: We don't share your mobile number with anyone")
    }
    
    override func crossButtonClick() {
        mainControllerCommunicator?.performBackButtonClick(self)
    }
    
    override func firstButtonClick() {
        mainControllerCommunicator?.performBackButtonClick(self)
    }
    
    override func secondButtonClick() {
        // show otp screen
        FreeTrialParser().parse(params: HttpRequestBuilder.getOtpRequestParameters(method: FreeTrialParser.METHOD_NAME, msisdn: centerEditText.text!, smmKey: "appyt-f", androidId: HttpRequestBuilder.ANDROID_ID_VALUE, imei: HttpRequestBuilder.IMEI_VALUE), completion: {
            statusType, result in
            
            print("FreeTrialPopUp \(result)")
            
            let model = result as! TrialResponseModel
            print("FreeTrialPopUp user_id  \(model.userId)")
            print("FreeTrialPopUp msisdn  \(model.userId)")
            print("FreeTrialPopUp otp  \(model.msisdn)")
        })
    }
    
}
