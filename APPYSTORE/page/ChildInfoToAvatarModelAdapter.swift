//
//  ChildInfoToAvatarModelAdapter.swift
//  APPYSTORE
//
//  Created by ios_dev on 02/05/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

class ChildInfoToAvatarModelAdapter: AvatarModel {
    
    
    init(childInfo: ChildInfo) {
        super.init()
        
        self.id = childInfo.id!
        self.imagePath = childInfo.avatarImage!
        self.name = childInfo.name!
        //isSelected = childInfo.chi
        
        
    }
    
}
