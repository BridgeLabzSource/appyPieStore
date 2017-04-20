//
//  AvatarSelectionController.swift
//  APPYSTORE
//
//  Created by ios_dev on 19/04/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit

class AvatarSelectionController: BaseViewController {

    var pageName: String?
    
    internal override func getPageName() -> String {
        return pageName!
    }
    
    internal override func getPageNameUniqueIdentifier() -> String {
        return ""
    }
    
    override func viewDidLoad() {
        readBundle()
        super.viewDidLoad()

    }
    
    func readBundle() {
    
    }
}
