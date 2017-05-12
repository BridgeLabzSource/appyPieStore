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
        //showBottomTextView()
        setValues()
    }
    
    func setValues() {
        setTitleTextLabel("Start 15 day FREE Trial")
        setSubTitleTextLabel("Give your mobile number to unlock all videos")
        setFirstButtonTextLabel("No Thanks")
        setSecondButtonTextLabel("Start Trial")
        //setBottomTextView("privacy statement: We don't share your mobile number with anyone", "")
        setCenterEditTextValue(mobileNumber)
        setCenterEditTextPlaceholder("Enter your mobile number")

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
        
        if mobileNo.characters.count != 10 {
            Toast(text: "Please enter valid mobile number").show()
            return
        }
        showProgress()
        FreeTrialParser().parse(params: HttpRequestBuilder.getOtpRequestParameters(method: FreeTrialParser.METHOD_NAME, msisdn: mobileNo, smmKey: "appyt-f", androidId: AppConstants.VENDOR_ID!, imei: HttpRequestBuilder.IMEI_VALUE), completion: {

            statusType, result in
            
            print("FreeTrialPopUp \(result)")
            self.hideProgress()
            if statusType == BaseParser.REQUEST_SUCCESS {
                let model = result as! TrialResponseModel
                print("FreeTrialPopUp user_id  \(model.userId)")
                print("FreeTrialPopUp msisdn  \(model.msisdn)")
                print("FreeTrialPopUp otp  \(model.otp)")
                // open the otp dialog
                
                var bundle = [String: Any]()
                bundle[BundleConstants.MOBILE_NUMBER] = mobileNo
                //bundle[BundleConstants.OTP] = model.otp
                bundle[BundleConstants.TRIAL_RESPONSE_MODEL] = model
                self.mainControllerCommunicator?.performBackButtonClick(self)
                NavigationManager.openOtpPopUp(mainControllerCommunicator: self.mainControllerCommunicator, bundle: bundle)
                Toast(text: "Success").show()
            } else if statusType == BaseParser.USER_ALREADY_SUBSCRIBED {
                self.mainControllerCommunicator?.performBackButtonClick(self)
                // call login api
                NavigationManager.openTrialSuccess(mainControllerCommunicator: self.mainControllerCommunicator!)
                self.callLoginFunction(mobileNo: mobileNo)
                Toast(text: result as? String).show()
            } else if statusType == BaseParser.REQUEST_FAILURE {
                Toast(text: "Request Failure").show()
            } else if statusType == BaseParser.CONNECTION_ERROR  {
                Toast(text: "Connection Error").show()
            }
        })
    }
    
    func callLoginFunction(mobileNo: String) {
        LoginParser().parse(params: HttpRequestBuilder.getLoginParameters(method: LoginParser.METHOD_NAME, msisdn: mobileNo, pageId: "login", emailId: ""), completion: {
            statusType, result in
            
            print("callLoginFunction \(result)")
            if statusType == BaseParser.REQUEST_SUCCESS {
                var childList = UserInfo.getInstance().childList
                let selectedChild = UserInfo.getInstance().selectedChild
                
                if childList == nil || (childList.isEmpty) {
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
                    
                    //self.mainControllerCommunicator?.performBackButtonClick(self)
                    Toast(text: "Show success Popup").show()
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
        hideFirstButton()
        hideSecondButton()
    }
    
    override func hideProgress() {
        super.hideProgress()
        showFirstButton()
        showSecondButton()
    }
}
