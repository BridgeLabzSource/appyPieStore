//
//  HistoryVideoCell.swift
//  APPYSTORE
//
//  Created by BridgeLabz Solution LLP on 25/02/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit

class HistoryVideoCell: UICollectionViewCell {
    //MARK:IBOutlet
    @IBOutlet var mVideoImage: UIImageView!
    
    @IBOutlet var mPlayImage: UIImageView!
    
    @IBOutlet var mDownloadButton: UIButton!
    
    @IBOutlet var mVideoDescription: UILabel!
    //MARK:IBAction
    
    override func awakeFromNib() {
        mVideoImage.layer.cornerRadius = 30.0
        mVideoImage.layer.masksToBounds = true
        
    }
}
