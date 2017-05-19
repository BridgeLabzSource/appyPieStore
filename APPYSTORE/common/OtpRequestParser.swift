//
//  OtpRequestParser.swift
//  APPYSTORE
//
//  Created by ios_dev on 27/04/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import Foundation
import SwiftyJSON

class OtpRequestParser: BaseParser {
    static let METHOD_NAME = "sendOtp"
    
    override func callback(_ status: String, _ code: String, _ data: AnyObject?,_ completion: @escaping (_ responseStatus: String, _ listOfData: AnyObject?) -> Void  ){
        
        if StringUtil.compareIgnoreCase(firstString: code, secondString: HttpConnection.RESPONSECODE_ERROR) {
            completion(BaseParser.USER_ALREADY_SUBSCRIBED, data)
        } else {
            completion(status, data)
        }
    }
    
    override func parseJSONData(responseData: JSON) -> AnyObject? {
        print("OtpRequestParser \(responseData)")
        
        let model = OtpResponseModel()
        model.companyId = String(responseData["company_id"].int!)
        model.msisdn = responseData["msisdn"].string!
        model.circleId = responseData["circle_id"].string!
        model.otp = responseData["m3_api_response_arr"]["otp"].string!
        model.userId = responseData["UserId"].string!
        model.telcoCompanyId = responseData["telco_company_id"].string!
        model.smmKey = responseData["smm_key"].string!
        
        return model as AnyObject?
    }
}
