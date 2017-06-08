//
//  FreeTrialOtpVerificationParser.swift
//  APPYSTORE
//
//  Created by ios_dev on 04/05/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import Foundation
import SwiftyJSON

class OtpVerificationParser: BaseParser {
    static let METHOD_NAME = "verifyOtpSub"
    
    override func callback(_ status: String, _ code: String, _ data: AnyObject?,_ completion: @escaping (_ responseStatus: String, _ listOfData: AnyObject?) -> Void  ){
        
        if StringUtil.compareIgnoreCase(firstString: code, secondString: HttpConnection.RESPONSECODE_ERROR) {
            completion(BaseParser.USER_ALREADY_SUBSCRIBED, data)
        } else {
            completion(status, data)
        }
    }
    
    override func parseJSONData(responseData: JSON) -> AnyObject? {
        print("FreeTrialOtpVerificationParser \(responseData)")
        
        let model = OtpVerificatioResponsenModel()
        model.orderDetails = responseData["order_details"].string ?? ""
        model.usv = responseData["usv"].string!
        model.userType = responseData["Utype"].string!
        model.userId = responseData["UserId"].string!
        model.smmKey = responseData["smm_key"].string!
        model.msisdn = responseData["msisdn"].string!
        model.tInfo = responseData["tinfo"].string!
        
        return model as AnyObject?
    }
}
