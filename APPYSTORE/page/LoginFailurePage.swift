//
//  LoginFailurePage.swift
//  APPYSTORE
//
//  Created by ios_dev on 03/05/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit

class LoginFailurePage: BasePopUpController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showSubTitleLabel()
        showCenterEditText()
        showErrorImage()
        showErrorLabel()
        showFirstButton()
        showBottomLabelOne()
        showBottomLabelTwo()
        
        setLabels()
    }
    
    func setLabels() {
        setSubTitleTextLabel("Please enter your registered mobile number")
        setImageError(UIImage(named: "cart")!)
        setErrorTextLabel("We are unable to recognize your number")
        setFirstButtonTextLabel("Try Again")
        setBottomTextLabelOne("OR")
        setBottomTextLabelTwo("Register with xxxxxxxxx")
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
