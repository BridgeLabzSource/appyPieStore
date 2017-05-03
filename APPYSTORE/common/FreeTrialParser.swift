//
//  FreeTrialParser.swift
//  APPYSTORE
//
//  Created by ios_dev on 27/04/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import Foundation
import SwiftyJSON

class FreeTrialParser: BaseParser {
    static let METHOD_NAME = "sendOtp"
    override func parseJSONData(responseData: JSON) -> AnyObject? {
        print("FreeTrialParser \(responseData)")
        
        let model = TrialResponseModel()
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
