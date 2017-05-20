//
//  FreeTrialOtpVerificationPopUp.swift
//  APPYSTORE
//
//  Created by ios_dev on 04/05/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import Foundation
import Toaster

class OtpVerificationPopUp: BasePopUpController {
    var mobileNumber = ""
    var otp = ""
    var trialResponseModel: OtpResponseModel!
    var timer: Timer!
    var second = 0
    
    var onLoginAfterVerification : (String) -> () = {_ in}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("OtpVerificationPopUp bundle : \(bundle)")
        mobileNumber = bundle?[BundleConstants.MOBILE_NUMBER] as! String
        //otp = bundle?[BundleConstants.OTP] as! String
        
        trialResponseModel = bundle?[BundleConstants.OTP_RESPONSE_MODEL] as! OtpResponseModel
        showTitleLabel()
        showCenterEditText()
        showSecondButton()
        showBottomTextView()
        setValues()
    }
    
    func setValues() {
        setTitleTextLabel("Enter the One Time Password sent to \(mobileNumber)")
        setCenterEditTextValue(trialResponseModel.otp)
        setCenterEditTextPlaceholder("Enter OTP")
        setSecondButtonTextLabel("Submit")
        setBottomTextView("","Resend OTP")
    }

    override func onBottomTextClick() {
        Toast(text: "Otp sent").show()
        requestOtp()
        tvBottom.isUserInteractionEnabled = false
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    func updateCounter() {
        second = second + 1
        print("updateCounter \(second)")
        if second >= 30 {
            second = 0
            tvBottom.isUserInteractionEnabled = true
            timer.invalidate()
            timer = nil
        }
    }
    
    func requestOtp() {
        OtpRequestParser().parse(params: HttpRequestBuilder.getOtpRequestParameters(method: OtpRequestParser.METHOD_NAME, msisdn: mobileNumber, smmKey: "appyt-f", androidId: HttpRequestBuilder.VENDOR_ID_VALUE, imei: HttpRequestBuilder.VENDOR_ID_VALUE), completion: {
            statusType, result in
        })
    }
    
    
    override func crossButtonClick() {
        mainControllerCommunicator?.performBackButtonClick(self)
        var bundle = [String: Any]()
        bundle[BundleConstants.MOBILE_NUMBER] = mobileNumber
        NavigationManager.openTrialPopUp(mainControllerCommunicator: mainControllerCommunicator!, bundle: bundle)
    }
    
    override func secondButtonClick() {
        let otp = centerEditText.text
        if otp != nil {
            showProgress()
            OtpVerificationParser().parse(params: HttpRequestBuilder.getOtpVerificationParameters(method: OtpVerificationParser.METHOD_NAME, userId: trialResponseModel.userId, msisdn: trialResponseModel.msisdn, otp: otp!, smmKey: trialResponseModel.smmKey, androidId: AppConstants.VENDOR_ID!, imei: HttpRequestBuilder.VENDOR_ID_VALUE), completion: {
                
                statusType, result in
                
                self.hideProgress()
                if statusType == BaseParser.REQUEST_SUCCESS {
                    
                    let model = result as! OtpVerificatioResponsenModel
                    
                    print("OtpVerificationPopUp user_id  \(model.userId)")
                    UserInfo.getInstance().id = model.userId
                    UserInfo.getInstance().tInfo = model.tInfo
                    
                    self.mainControllerCommunicator?.performBackButtonClick(self)
                    
                    AuthenticationUtil.callLoginFunction(mobileNo: self.mobileNumber,mainControllerCommunicator: self.mainControllerCommunicator!, completion: self.onLoginAfterVerification)
                } else if statusType == BaseParser.USER_ALREADY_SUBSCRIBED {
                    
                    self.mainControllerCommunicator?.performBackButtonClick(self)
                    
                    Toast(text: result as? String).show()
                    
                    AuthenticationUtil.callLoginFunction(mobileNo: self.mobileNumber, mainControllerCommunicator: self.mainControllerCommunicator!, completion: self.onLoginAfterVerification)
                    
                } else if statusType == BaseParser.REQUEST_FAILURE {
                    Toast(text: "Request Failure").show()
                } else if statusType == BaseParser.CONNECTION_ERROR  {
                    Toast(text: "Connection Error").show()
                }
            })
        } else {
            Toast(text: "Request Failure").show()
        }
    }
    
    override func showProgress() {
        super.showProgress()
        hideSecondButton()
    }
    
    override func hideProgress() {
        super.hideProgress()
        showSecondButton()
    }

}
