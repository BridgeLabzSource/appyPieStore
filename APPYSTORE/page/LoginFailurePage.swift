//
//  LoginFailurePage.swift
//  APPYSTORE
//
//  Created by ios_dev on 03/05/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit
import Toaster

class LoginFailurePage: BasePopUpController {
    
    var unRegisteredNumber: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showSubTitleLabel()
        showCenterEditText()
        showErrorImage()
        showErrorLabel()
        showFirstButton()
        showBottomTextView()
        
        setStringValues()
    }
    
    
    
    func setStringValues() {
        setSubTitleTextLabel("Please enter your registered mobile number")
        setImageError(UIImage(named: "error_ic")!)
        setErrorTextLabel("We are unable to recognize your number")
        setFirstButtonTextLabel("Try Again")
        self.centerEditText.text = unRegisteredNumber
        setRegisterWithText(mobileNo:  unRegisteredNumber)
    }
    
    func setRegisterWithText(mobileNo: String) {
        setBottomTextView("OR  ", "Register with " + mobileNo)
    }
    
    override func firstButtonClick() {
        let mobileNo = centerEditText.text!
        if mobileNo.characters.count != 10 {
            Toast(text: "ENTER_VALID_MOBILE_NUMBER".localized(lang: AppConstants.LANGUAGE)).show()
            return
        }
        
        self.mainControllerCommunicator?.showProgressBar()
        //todo email id
        LoginParser().parse(params: HttpRequestBuilder.getLoginParameters(method: LoginParser.METHOD_NAME, msisdn: centerEditText.text!, pageId: "login", emailId: ""), completion: {
            statusType, result in
            
            self.mainControllerCommunicator?.hideProgressBar()
            if statusType == BaseParser.REQUEST_SUCCESS {
                NavigationUtil.navigateAsPerChildSize(mainControllerCommunicator: self.mainControllerCommunicator!)
            } else if statusType == BaseParser.REQUEST_FAILURE {
                self.setRegisterWithText(mobileNo:  self.centerEditText.text!)
            } else if statusType == BaseParser.CONNECTION_ERROR {
                self.setRegisterWithText(mobileNo:  self.centerEditText.text!)
            }
        })
    }
    
    //login click
    override func onBottomTextClick() {
        AuthenticationUtil.startOtpFlow(mobileNo: self.centerEditText.text!, mainControllerCommunicator: mainControllerCommunicator!, baseViewController: self, completion: onLoginAfterVerification)
    }
    
    func onLoginAfterVerification(status: String) {
        print(status)
    }
}
