//
//  VideoController.swift
//  APPYSTORE
//
//  Created by BridgeLabz on 02/03/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit

class VideoController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    //MARK: IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: Declaration
    var pointOfPixels: CGFloat!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // getting value in point from pixels
        pointOfPixels = DimentionManager.convertPixelToPoint(pixel: 64.0)
        
        self.collectionView.register(UINib(nibName: "MyCustomView", bundle: nil), forCellWithReuseIdentifier: "MyCustomView")
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : MyCustomView = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCustomView", for: indexPath) as! MyCustomView
        
       //access your Cell's IBOutlets
        cell.mInfoBtn.layer.cornerRadius = self.pointOfPixels
        cell.mInfoBtn.clipsToBounds = true

        cell.mMainView.layer.cornerRadius = self.pointOfPixels
        cell.mMainView.clipsToBounds = true
        
        // setting shadow of view
        let plain = cell
        applyPlainShadow(view: plain)
        
        return cell
    }
    
    
    // function for Plain Shadow
    func applyPlainShadow(view: UIView)
    {
        let layer = view.layer
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 8, height: 8)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 1.0
        layer.masksToBounds = false
    }

}

