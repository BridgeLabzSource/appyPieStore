//
//  VideoController.swift
//  APPYSTORE
//
//  Created by BridgeLabz on 02/03/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit

class VideoController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //MARK: IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: Declaration
    var setLimit:Int = 0
    var setOffset:Int = 0
    var dataList = [VideoCategoryModel]()
    let cardWidth: CGFloat = 512 - 40
    let cardHeight: CGFloat = 384 - 40
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.register(UINib(nibName: "MyCustomView", bundle: nil), forCellWithReuseIdentifier: "MyCustomView")
        
        let dataManager = DataManager()
        dataManager.getData(pageName: PageConstants.VIDEO_PAGE, offset: setOffset, limit: setLimit, returndata: {
        result in
            self.dataList = result as! [VideoCategoryModel]
            self.collectionView.reloadData()
        })
                
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.delegate = self
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : MyCustomView = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCustomView", for: indexPath) as! MyCustomView
        
        print(dataList[indexPath.row].imagePath)
        let image_path = dataList[indexPath.row].imagePath
        let imgurl = URL(string: image_path)
        cell.mBgImg.sd_setImage(with:imgurl, placeholderImage:#imageLiteral(resourceName: "profile") )
        
        cell.mCountLabel.text = dataList[indexPath.row].contentCount
        
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
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: DimentionManager.getGeneralizedWidth1280x720(width: cardWidth), height: DimentionManager.getGeneralizedHeight1280x720(height: cardHeight));
    }

}

