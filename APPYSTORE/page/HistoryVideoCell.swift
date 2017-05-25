//
//  HistoryVideoCell.swift
//  APPYSTORE
//
//  Created by BridgeLabz Solution LLP on 25/02/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit

class HistoryVideoCell: UICollectionViewCell {

    @IBOutlet var mVideoImage: UIImageView!
    @IBOutlet var mPlayImage: UIImageView!
    @IBOutlet var mDownloadButton: UIButton!
    @IBOutlet var mVideoDescription: UILabel!
    
    override func awakeFromNib() {
        mVideoImage.layer.cornerRadius = 30.0
        mVideoImage.layer.masksToBounds = true
        layer.cornerRadius = 35.0
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 3.0
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 7, height:10)
        layer.shadowOpacity = 0.3;
        layer.shadowRadius = 1.0;
    }
}
