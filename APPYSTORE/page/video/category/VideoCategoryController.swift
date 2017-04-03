//
//  VideoController.swift
//  APPYSTORE
//
//  Created by BridgeLabz on 02/03/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class VideoCategoryController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    
    //MARK: IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: Declaration
    var sw:CGFloat = 0.0
    var sh:CGFloat = 0.0
    var dataList = [VideoCategoryModel]()
    let CARD_HEIGHT: CGFloat = 384 - 32
    let dataFetchFramework = DataFetchFramework(pageName: PageConstants.VIDEO_PAGE)
    var anim: NVActivityIndicatorView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.register(UINib(nibName: "VideoCategoryCard", bundle: nil), forCellWithReuseIdentifier: "VideoCategoryCard")
        
        //inital value for animator
        sw = self.collectionView.center.x
        sh = self.collectionView.center.y
        
        self.loadData()
                
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.delegate = self
        

        self.collectionView.addSpacingBetweenCell()

    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : VideoCategoryCard = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCategoryCard", for: indexPath) as! VideoCategoryCard
        
        print(dataList[indexPath.row].imagePath)
        let image_path = dataList[indexPath.row].imagePath
        let imgurl = URL(string: image_path)
        cell.imgBg.sd_setImage(with:imgurl, placeholderImage:#imageLiteral(resourceName: "profile") )
        
        cell.lblCount.text = dataList[indexPath.row].contentCount
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = DimensionManager.getGeneralizedHeight1280x720(height: CARD_HEIGHT)
        let width = DimensionManager.getGeneralizedWidthIn4isto3Ratio(height: height)
        return CGSize(width: width, height: height);
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        NavigationManager.openVideoListingPage(mainControllerCommunicator: mainControllerCommunicator)
    }
    
    func loadData() {
        let frame = CGRect(x: Int(sw-25), y: Int(sh/2), width: 30, height: 30)
        anim = NVActivityIndicatorView(frame: frame, type: NVActivityIndicatorType.ballPulse, color: UIColor.orange, padding: CGFloat(0))
        anim?.startAnimating()
        self.collectionView.addSubview(anim!)
        dataFetchFramework.onDataReceived = onDataReceived
        dataFetchFramework.start(dataSource: DataSource.BOTH)
    }
    
    func onDataReceived( status: String, result: AnyObject) {
        anim?.stopAnimating()
        anim?.removeFromSuperview()
        if status == DataFetchFramework.REQUEST_SUCCESS {
            if let result = result as? [BaseModel] {
                print("Ganesh Server Data : \(result)")
                self.dataList = result as! [VideoCategoryModel]
                self.view.setNeedsDisplay()
                print("Data Found:",result.count)
                self.collectionView.reloadData()
            }
        } else if status == DataFetchFramework.END_OF_DATA {
            
        } else {
            print("Ganesh status : \(status) and response : \(result) ")
        }
    }

    func dummy(){
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

}

