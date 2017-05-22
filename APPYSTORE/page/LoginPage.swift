//
//  LoginPage.swift
//  APPYSTORE
//
//  Created by ios_dev on 03/05/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit
import Toaster

class LoginPage: BasePopUpController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showSubTitleLabel()
        showCenterEditText()
        showFirstButton()
        
        setLabels()
    }

    func setLabels() {
        setSubTitleTextLabel("Please enter your registered mobile number")
        setFirstButtonTextLabel("Login")
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
                NavigationManager.openLoginFailurePage(mainControllerCommunicator: self.mainControllerCommunicator!, mobileNo: self.centerEditText.text!)
            } else if statusType == BaseParser.CONNECTION_ERROR {
                
            }
        })

    }
}
