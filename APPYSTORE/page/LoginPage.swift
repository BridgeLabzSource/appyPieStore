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
        //todo email id
        LoginParser().parse(params: HttpRequestBuilder.getLoginParameters(method: LoginParser.METHOD_NAME, msisdn: centerEditText.text!, pageId: "login", emailId: ""), completion: {
            statusType, result in
            if statusType == DataFetchFramework.REQUEST_SUCCESS {
                NavigationUtil.navigateAsPerChildSize(mainControllerCommunicator: self.mainControllerCommunicator!)
            } else if statusType == DataFetchFramework.REQUEST_FAILURE {
                NavigationManager.openLoginFailurePage(mainControllerCommunicator: self.mainControllerCommunicator!)
            } else if statusType == DataFetchFramework.CONNECTION_ERROR {
                
            }
        })

    }
}
