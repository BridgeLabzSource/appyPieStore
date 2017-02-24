//
//  ViewController.swift
//  APPYSTORE
//
//  Created by BridgeLabz on 21/02/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit
//import Foundation
//import AVFoundation

//private var playerViewControllerKVOContext = 0

class VideoCategoryController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: variables
    let image = ["ic_launcher", "ic_launcher", "ic_launcher", "ic_launcher", "ic_launcher", "ic_launcher"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return image.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as!  CustomImageCell
        
        cell.bgImage.layer.cornerRadius = 64
        cell.bgImage.clipsToBounds = true
        
        cell.logoBtn.layer.cornerRadius = 25
        cell.logoBtn.clipsToBounds = true
        
      //  cell.bgLabel.layer.cornerRadius = 64
      //  cell.bgLabel.clipsToBounds = true
        
        cell.mainView.layer.cornerRadius = 64
        cell.mainView.clipsToBounds = true
        
        cell.mainView.layer.shadowColor = UIColor.black.cgColor
        cell.mainView.layer.shadowOpacity = 1
        cell.mainView.layer.shadowOffset = CGSize.zero
        cell.mainView.layer.shadowRadius = 10
        
        cell.mainView.layer.shadowPath = UIBezierPath(rect: cell.mainView.bounds).cgPath
        cell.mainView.layer.shouldRasterize = true

            
        cell.bgImage.image = UIImage(named: image[indexPath.row])
        return cell
    }
    
    //width = 48
    // height= 32
   
 }

