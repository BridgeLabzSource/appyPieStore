//
//  FreeTrialOtpVerificationPopUp.swift
//  APPYSTORE
//
//  Created by ios_dev on 04/05/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import Foundation
import Toaster

class FreeTrialOtpVerificationPopUp: BasePopUpController {
    var mobileNumber = ""
    var otp = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("FreeTrialOtpVerificationPopUp bundle : \(bundle)")
        mobileNumber = bundle?[BundleConstants.MOBILE_NUMBER] as! String
        otp = bundle?[BundleConstants.OTP] as! String
        showTitleLabel()
        showCenterEditText()
        showSecondButton()
        showBottomTextView()
        setValues()
    }
    
    func setValues() {
        setTitleTextLabel("Enter the One Time Password sent to \(mobileNumber)")
        setCenterEditTextValue(otp)
        setSecondButtonTextLabel("Submit")
        setBottomTextView("Resend OTP", nil)
    }

    
    override func crossButtonClick() {
        mainControllerCommunicator?.performBackButtonClick(self)
    }
    
    override func secondButtonClick() {
        let otp = centerEditText.text
        if otp != nil {
            
        } else {
            Toast(text: "Request Failure").show()
        }
    }

}
