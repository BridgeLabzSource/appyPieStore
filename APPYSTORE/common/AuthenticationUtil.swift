//
//  AuthenticationUtil.swift
//  APPYSTORE
//
//  Created by ios_dev on 03/05/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import Foundation
import Toaster

class AuthenticationUtil {
    
    static func isSubscribedUser() -> Bool {
        return UserInfo.USER_TYPE_CLOSED == UserInfo.getInstance().type
    }
    
    static func clearDataAfterSubscription() {
        
    }

    static func startOtpFlow(mobileNo: String, mainControllerCommunicator: MainControllerCommunicator, baseViewController: BaseViewController, completion: @escaping (String) -> Void ) {
        
        OtpRequestParser().parse(params: HttpRequestBuilder.getOtpRequestParameters(method: OtpRequestParser.METHOD_NAME, msisdn: mobileNo, smmKey: AuthenticationUtil.getSmmKey(), androidId: AppConstants.VENDOR_ID!, imei: HttpRequestBuilder.VENDOR_ID_VALUE), completion: {
            
            statusType, result in
            //todo
            //self.hideProgress()
            if statusType == BaseParser.REQUEST_SUCCESS {
                let model = result as! OtpResponseModel
                
                // open the otp dialog
                var bundle = [String: Any]()
                bundle[BundleConstants.MOBILE_NUMBER] = mobileNo
                bundle[BundleConstants.OTP_RESPONSE_MODEL] = model
                mainControllerCommunicator.performBackButtonClick(baseViewController)
                NavigationManager.openOtpPopUp(mainControllerCommunicator:mainControllerCommunicator, bundle: bundle, completion: completion)
                Toast(text: "Success").show()
            } else if statusType == BaseParser.USER_ALREADY_SUBSCRIBED {
                mainControllerCommunicator.performBackButtonClick(baseViewController)
                AuthenticationUtil.callLoginFunction(mobileNo: mobileNo, mainControllerCommunicator: mainControllerCommunicator, completion: completion)
                Toast(text: result as? String).show()
            } else if statusType == BaseParser.REQUEST_FAILURE {
                Toast(text: "Request Failure").show()
            } else if statusType == BaseParser.CONNECTION_ERROR  {
                Toast(text: "Connection Error").show()
            }
        })
    }
    
    static func callLoginFunction(mobileNo: String, mainControllerCommunicator: MainControllerCommunicator, completion: @escaping (String) -> Void) {
        LoginParser().parse(params: HttpRequestBuilder.getLoginParameters(method: LoginParser.METHOD_NAME, msisdn: mobileNo, pageId: "login", emailId: ""), completion: {
            statusType, result in
            
            completion(statusType)
            
            if statusType == BaseParser.REQUEST_SUCCESS {
                NavigationUtil.handleLoginSuccessAfterOtpVerification(mainControllerCommunicator: mainControllerCommunicator)
            } else if statusType == BaseParser.REQUEST_FAILURE {
                Toast(text: "Login Failure").show()
            } else if statusType == BaseParser.CONNECTION_ERROR {
                Toast(text: "Connection Error").show()
            }
        })
    }
    
    static func getSmmKey() -> String {
    //TODO remove dependency! can we use userinfo.getSmm
        if (AuthenticationUtil.getIsExistingUser()) {
            return AppConstants.SMM_KEY_TRIAL_EXISTING_USER;
        } else {
            return AppConstants.SMM_KEY_TRIAL_NEW_USER;
        }
    }
    
    static func getIsExistingUser() -> Bool {
        var isExisting: Bool = false
        if (UserInfo.getInstance().isUpgraded) {
            isExisting = true;
        } else if (UserInfo.getInstance().isNewUser) {
            isExisting = false;
        }
        return isExisting;
    }
}
