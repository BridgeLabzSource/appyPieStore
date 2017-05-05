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
        showBottomTextView()
        
        setStringValues()
    }
    
    
    
    func setStringValues() {
        setSubTitleTextLabel("Please enter your registered mobile number")
        setImageError(UIImage(named: "error_ic")!)
        setErrorTextLabel("We are unable to recognize your number")
        setFirstButtonTextLabel("Try Again")
        setBottomTextView("OR  ", "Register with xxxxxxxxx")
    }
    
    override func firstButtonClick() {
        self.mainControllerCommunicator?.showProgressBar()
        //todo email id
        LoginParser().parse(params: HttpRequestBuilder.getLoginParameters(method: LoginParser.METHOD_NAME, msisdn: centerEditText.text!, pageId: "login", emailId: ""), completion: {
            statusType, result in
            
            self.mainControllerCommunicator?.hideProgressBar()
            if statusType == BaseParser.REQUEST_SUCCESS {
                NavigationUtil.navigateAsPerChildSize(mainControllerCommunicator: self.mainControllerCommunicator!)
            } else if statusType == BaseParser.REQUEST_FAILURE {
                
            } else if statusType == BaseParser.CONNECTION_ERROR {
                
            }
        })
    }
    
    override func onBottomTextClick() {
        print("BottomLabelTwo clicked")
    }
}
