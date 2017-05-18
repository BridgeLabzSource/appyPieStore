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
    var mobileNumber = ""
    let trialAlreadySubscribedMessage = "Dear User, you are already a subscriber."
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mobileNumber = bundle?[BundleConstants.MOBILE_NUMBER] as? String ?? ""
        showTitleLabel()
        showSubTitleLabel()
        showCenterEditText()
        showFirstButton()
        showSecondButton()
        setValues()
    }
    
    func setValues() {
        setTitleTextLabel("Start 15 day FREE Trial")
        setSubTitleTextLabel("Give your mobile number to unlock all videos")
        setFirstButtonTextLabel("No Thanks")
        setSecondButtonTextLabel("Start Trial")
        setCenterEditTextValue(mobileNumber)
        setCenterEditTextPlaceholder("Enter your mobile number")

    }
    
    override func crossButtonClick() {
        mainControllerCommunicator?.performBackButtonClick(self)
    }
    
    override func firstButtonClick() {
        mainControllerCommunicator?.performBackButtonClick(self)
    }
    
    //Start otp flow
    override func secondButtonClick() {
        let mobileNo = centerEditText.text!
        if mobileNo.characters.count != 10 {
            Toast(text: "Please enter valid mobile number").show()
            return
        }
        
        showProgress()
        
        AuthenticationUtil.startOtpFlow(mobileNo: mobileNo, mainControllerCommunicator: mainControllerCommunicator!, baseViewController: self, completion: onLoginAfterVerification)
    }
    
    func onLoginAfterVerification(status: String) {
        //todo nothing
        print(status)
    }
    
    override func showProgress() {
        super.showProgress()
        hideFirstButton()
        hideSecondButton()
    }
    
    override func hideProgress() {
        super.hideProgress()
        showFirstButton()
        showSecondButton()
    }
}
