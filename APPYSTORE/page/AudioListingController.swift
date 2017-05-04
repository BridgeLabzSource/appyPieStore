//
//  AudioListingController.swift
//  APPYSTORE
//
//  Created by BridgeLabz Solutions LLP  on 5/4/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit

class AudioListingController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var array1 = [#imageLiteral(resourceName: "search"),#imageLiteral(resourceName: "cartoon"),#imageLiteral(resourceName: "cartoon"),#imageLiteral(resourceName: "cartoon")]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let nib = UINib(nibName: "AudioListingCard", bundle: nil)
        collectionView?.register(nib, forCellWithReuseIdentifier: "Cell1")
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array1.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell1", for: indexPath) as! AudioListingCard
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = (self.collectionView?.frame.height)! - 16
        let width = height * 0.733 //aspect ratio 264/360
        
        return CGSize(width: width, height: height)
    }


}
