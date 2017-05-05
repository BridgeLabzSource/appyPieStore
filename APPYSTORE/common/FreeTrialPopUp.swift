//
//  FreeTrialPopUp.swift
//  APPYSTORE
//
//  Created by ios_dev on 26/04/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit
import Toaster

class FreeTrialPopUp: BasePopUpController {
    let trialAlreadySubscribedMessage = "Dear User, you are already a subscriber."
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showTitleLabel()
        showSubTitleLabel()
        showCenterEditText()
        showFirstButton()
        showSecondButton()
        //showBottomLabelOne()
        showBottomTextView()
        setValues()
    }
    
    func setValues() {
        setTitleTextLabel("Start 15 day FREE Trial")
        setSubTitleTextLabel("Give your mobile number to unlock all videos")
        setFirstButtonTextLabel("No Thanks")
        setSecondButtonTextLabel("Start Trial")
        setBottomTextView("privacy statement: We don't share your mobile number with anyone", "")

    }
    
    override func crossButtonClick() {
        mainControllerCommunicator?.performBackButtonClick(self)
    }
    
    override func firstButtonClick() {
        mainControllerCommunicator?.performBackButtonClick(self)
    }
    
    override func secondButtonClick() {
        // show otp screen
        let mobileNo = centerEditText.text!
        FreeTrialParser().parse(params: HttpRequestBuilder.getOtpRequestParameters(method: FreeTrialParser.METHOD_NAME, msisdn: mobileNo, smmKey: "appyt-f", androidId: HttpRequestBuilder.ANDROID_ID_VALUE, imei: HttpRequestBuilder.IMEI_VALUE), completion: {
            statusType, result in
            
            print("FreeTrialPopUp \(result)")
            
            let model = result as! TrialResponseModel
            print("FreeTrialPopUp user_id  \(model.userId)")
            print("FreeTrialPopUp msisdn  \(model.msisdn)")
            print("FreeTrialPopUp otp  \(model.otp)")
            if statusType == BaseParser.REQUEST_SUCCESS {
                // open the otp dialog
                
                var bundle = [String: Any]()
                bundle[BundleConstants.MOBILE_NUMBER] = mobileNo
                bundle[BundleConstants.OTP] = model.otp
                NavigationManager.openOtpPopUp(mainControllerCommunicator: self.mainControllerCommunicator, bundle: bundle)
                Toast(text: "Success").show()
            } else if statusType == BaseParser.USER_ALREADY_SUBSCRIBED {
                self.mainControllerCommunicator?.performBackButtonClick(self)
                // call login api
                Toast(text: self.trialAlreadySubscribedMessage).show()
            } else if statusType == BaseParser.REQUEST_FAILURE {
                Toast(text: "Request Failure").show()
            } else if statusType == BaseParser.CONNECTION_ERROR  {
                Toast(text: "Connection Error").show()
            }
        })
    }
    
}
