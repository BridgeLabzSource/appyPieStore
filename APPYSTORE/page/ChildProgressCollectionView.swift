//
//  ChildProgressCollectionView.swift
//  APPYSTORE
//
//  Created by BridgeLabz on 05/05/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit

class ChildProgressCollectionView: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
   
    @IBOutlet weak var collectionView: UICollectionView!
    var width:CGFloat!
    var height:CGFloat!
    override func viewDidLoad() {
        super.viewDidLoad()
         width = (176/1280) * self.view.frame.width
        
         height = (240/720) * self.view.frame.height
        collectionView.register(UINib(nibName: "ChildProgress", bundle: nil), forCellWithReuseIdentifier: "ChildProgress")
    
    
    
    collectionView.delegate = self
    collectionView.dataSource = self
}

public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
{return 15
    
}
func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
    
}


// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:

public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
{
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChildProgress", for: indexPath) as UIView
  ///  let width = (176/1280) * self.view.frame.width
  //  let height = (240/720) * self.view.frame.height
 //   self.view.frame.width = width
   // self.view.frame.height = height
    return cell as! UICollectionViewCell
}
  func collectionView(_ collectionView: UICollectionView,
 layout collectionViewLayout: UICollectionViewLayout,
 sizeForItemAt indexPath: IndexPath) -> CGSize{
    
    
     print("frame width = ",self.view.frame.width,"  size = " , self.view.frame.size.width)
    print("collectio view width = ",width,"  height = ",height)
 return CGSize(width  : width , height : height)
 }
 
 



}
