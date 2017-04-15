//
//  SearchTagsModel.swift
//  APPYSTORE
//
//  Created by ios_dev on 13/04/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import Foundation

class SearchTagsModel: BaseModel, NSCoding {
    var searchName: String?
    var searchRank: String?
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(searchName, forKey: "searchName")
        aCoder.encode(searchRank, forKey: "searchRank")
    }
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        searchName = aDecoder.decodeObject(forKey: "searchName") as? String
        searchRank = aDecoder.decodeObject(forKey: "searchRank") as? String
        super.init()
    }
}
