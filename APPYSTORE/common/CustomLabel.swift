//
//  CustomLabel.swift
//  APPYSTORE
//
//  Created by ios_dev on 30/03/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import Foundation
import UIKit

class CustomLabel: UILabel {
    override func drawText(in rect: CGRect) {
        super.drawText(in: UIEdgeInsetsInsetRect( rect, UIEdgeInsetsMake(5, 5, 5, 5)) )
        //super.drawText(in: rect)
    }
}
