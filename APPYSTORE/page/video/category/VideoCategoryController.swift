//
//  VideoController.swift
//  APPYSTORE
//
//  Created by BridgeLabz on 02/03/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
class VideoCategoryController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,UIScrollViewDelegate{
    
    //MARK: IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: Declaration
    var sw:CGFloat = 0.0
    var sh:CGFloat = 0.0
    var setLimit:Int = 20
    var setOffset:Int = 0
    let dataManager = DataManager.sharedInstance
    var dataList = [VideoCategoryModel]()
    let cardWidth: CGFloat = 512 - 40
    let cardHeight: CGFloat = 384 - 40
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.register(UINib(nibName: "VideoCategoryCard", bundle: nil), forCellWithReuseIdentifier: "VideoCategoryCard")
        
        //inital value for animator
        sw = self.collectionView.center.x
        sh = self.collectionView.center.y
        
        //
        self.loadData(offset: setOffset, limit: setLimit)
                
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.delegate = self
        
        
        let u = UserInfo.getInstance()
        u.id = "123"
        u.type = "same "
        let c = ChildInfo()
        c.name = "Ganesh"
        u.selectedChild = c
        u.childList = [c]
        
        Prefs.getInstance()?.setObject(key: "user", value: u)
        u.id = "456"
        u.type = "different"
        u.selectedChild?.name = "Rahul"
        u.childList?[0].name = "Mahesh"
        
        
        let u1 : UserInfo = Prefs.getInstance()?.getObject(key: "user") as! UserInfo
        
        print("Ganesh first value = \(u.id ) and the second value is \(u1.id ) ")
        print("Ganesh first value = \(u.type ) and the second value is \(u1.type ) ")
        print("Ganesh child value = \(u.selectedChild?.name ) and the child value is \(u1.selectedChild?.name ) ")
        
        print("Ganesh selected value = \(u.childList?[0].name ) and the selected value is \(u1.childList?[0].name ) ")
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : VideoCategoryCard = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCategoryCard", for: indexPath) as! VideoCategoryCard
        
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
    
    func loadData(offset:Int,limit:Int)
    {
        let frame = CGRect(x: Int(sw-25), y: Int(sh/2), width: 30, height: 30)
        let anim = NVActivityIndicatorView(frame: frame, type: NVActivityIndicatorType.ballPulse, color: UIColor.orange, padding: CGFloat(0))
        anim.startAnimating()
        self.collectionView.addSubview(anim)
        dataManager.getData(pageName: PageConstants.VIDEO_PAGE, offset: offset, limit: limit, returndata: { statusType,result in
            self.dataList = result as! [VideoCategoryModel]
            self.view.setNeedsDisplay()
            print("Data Found:",result.count)
            self.collectionView.reloadData()
            anim.stopAnimating()
            anim.removeFromSuperview()
            
        })
    }

    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)
    {
        if var lastVisibleCell = self.collectionView.indexPathsForVisibleItems.last
        {
            let lastVisibleCellCount = lastVisibleCell.row + 1
            if lastVisibleCellCount == setLimit && setLimit <= total_history_count!
            {
                setLimit = setLimit + 20
                sw = (scrollView.contentSize.width)
                sh = (scrollView.contentSize.height)
                loadData(offset: setOffset, limit: setLimit)
            }
            
        }

    }

}

