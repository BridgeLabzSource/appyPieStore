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
    var trialResponseModel: TrialResponseModel!
    var timer: Timer!
    var second = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("FreeTrialOtpVerificationPopUp bundle : \(bundle)")
        mobileNumber = bundle?[BundleConstants.MOBILE_NUMBER] as! String
        //otp = bundle?[BundleConstants.OTP] as! String
        
        trialResponseModel = bundle?[BundleConstants.TRIAL_RESPONSE_MODEL] as! TrialResponseModel
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
        FreeTrialParser().parse(params: HttpRequestBuilder.getOtpRequestParameters(method: FreeTrialParser.METHOD_NAME, msisdn: mobileNumber, smmKey: "appyt-f", androidId: HttpRequestBuilder.ANDROID_ID_VALUE, imei: HttpRequestBuilder.IMEI_VALUE), completion: {
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
            FreeTrialOtpVerificationParser().parse(params: HttpRequestBuilder.getOtpVerificationParameters(method: FreeTrialOtpVerificationParser.METHOD_NAME, userId: trialResponseModel.userId, msisdn: trialResponseModel.msisdn, otp: otp!, smmKey: trialResponseModel.smmKey, androidId: AppConstants.VENDOR_ID!, imei: HttpRequestBuilder.IMEI_VALUE), completion: {

                    statusType, result in
                
                self.hideProgress()
                if statusType == BaseParser.REQUEST_SUCCESS {
                    let model = result as! TrialOtpVerificatioResponsenModel
                    print("FreeTrialOtpVerificationPopUp user_id  \(model.userId)")
                    UserInfo.getInstance().id = model.userId
                    UserInfo.getInstance().tInfo = model.tInfo
                    //Toast(text: "Success").show()
                    self.mainControllerCommunicator?.performBackButtonClick(self)
                    // call login api
                    
                    self.callLoginFunction(mobileNo: self.mobileNumber)
                } else if statusType == BaseParser.USER_ALREADY_SUBSCRIBED {
                    self.mainControllerCommunicator?.performBackButtonClick(self)
                    Toast(text: result as? String).show()
                    // call login api
                    self.callLoginFunction(mobileNo: self.mobileNumber)
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
    
    func callLoginFunction(mobileNo: String) {
        LoginParser().parse(params: HttpRequestBuilder.getLoginParameters(method: LoginParser.METHOD_NAME, msisdn: mobileNo, pageId: "login", emailId: ""), completion: {
            statusType, result in
            
            if statusType == BaseParser.REQUEST_SUCCESS {
                var childList = UserInfo.getInstance().childList
                let selectedChild = UserInfo.getInstance().selectedChild
                
                if childList.isEmpty {
                    print("FreeTrialPopUp child count 0")
                } else if selectedChild == nil {
                    print("FreeTrialPopUp no selected child")
                } else {
                    var portedSelectedChild: ChildInfo? = nil
                    
                    for child in childList {
                        if child.name == selectedChild?.name {
                            portedSelectedChild = child
                            break
                        }
                    }
                    
                    if portedSelectedChild == nil {
                        print("FreeTrialPopUp no selected child, 0th selected")
                        portedSelectedChild = childList[0]
                        UserInfo.getInstance().selectedChild = portedSelectedChild
                        print("FreeTrialPopUp ported child selected \(portedSelectedChild?.id)  \(portedSelectedChild?.name)")
                        
                        NavigationUtil.clearChildSpecificData()
                        self.mainControllerCommunicator?.refreshAllPages()
                        // reset all data
                    } else {
                        print("FreeTrialPopUp child selected")
                        
                        UserInfo.getInstance().selectedChild = portedSelectedChild
                        NavigationUtil.clearChildSpecificData()
                        self.mainControllerCommunicator?.refreshAllPages()
                    }
                    NavigationManager.openTrialSuccess(mainControllerCommunicator: self.mainControllerCommunicator!)
                    //self.mainControllerCommunicator?.performBackButtonClick(self)
                    //Toast(text: "Show success Popup").show()
                }
                
            } else if statusType == BaseParser.REQUEST_FAILURE {
                Toast(text: "Login Failure").show()
            } else if statusType == BaseParser.CONNECTION_ERROR {
                Toast(text: "Connection Error").show()
            }
        })
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
