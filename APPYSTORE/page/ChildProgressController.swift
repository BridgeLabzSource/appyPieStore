//
//  ChildProgressController.swift
//  APPYSTORE
//
//  Created by BridgeLabz on 02/05/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit

class ChildProgressController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var videoCategoryBtnView: UIView!

    @IBOutlet weak var audioCategorybtnView: UIView!
    
    
    
    
    
    
    @IBOutlet weak var collectionHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var contentview: UIView!
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    @IBOutlet weak var bottumView: UIView!
    
    
    var viewHeight:CGFloat!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bottumView.layer.cornerRadius = 15
        self.bottumView.layer.masksToBounds = true
        self.contentview.layer.cornerRadius = 15
        self.contentview.layer.masksToBounds = true
        self.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 40, right: 0)
        collectionView.delegate = self
        collectionView.dataSource = self
        viewHeight = self.view.frame.height
        self.scrollView.layoutIfNeeded()
        self.scrollView.contentSize.height = self.contentview.bounds.size.height
        self.collectionHeightConstraint.constant = self.collectionView.collectionViewLayout.collectionViewContentSize.height
        
        print("collectionview hieght = ",self.collectionView.collectionViewLayout.collectionViewContentSize.height," constant = " ,self.collectionHeightConstraint.constant )
      let cornerRaduisWidth = videoCategoryBtnView.frame.height/4
        
        
        videoCategoryBtnView.roundCornersWithLayerMask(cornerRadii: cornerRaduisWidth,corners: [.topLeft,.topRight])
        audioCategorybtnView.roundCornersWithLayerMask(cornerRadii: cornerRaduisWidth,corners: [.topLeft,.topRight])
        contentview.backgroundColor = UIColor(red:1.0, green:1.0, blue:1.0, alpha:0.5)
       // bottumView.roundCornersWithLayerMask(cornerRadii: cornerRaduisWidth,corners: [.topLeft])

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
                self.collectionHeightConstraint.constant = self.collectionView.collectionViewLayout.collectionViewContentSize.height
        collectionView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
                self.collectionHeightConstraint.constant = self.collectionView.collectionViewLayout.collectionViewContentSize.height
        collectionView.reloadData()
    }
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
    return 10
        
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ChildProgressCell
//        let d = 720/viewHeight
//        let c = d * 48
        
        let c = viewHeight
        
      let   d = (c!*48)/720
      //  let h = c * 8
       print("d=", d ,"width= ", self.view.frame.width,"  height= ", viewHeight )
        
       // cell.frame.size.height = d
        cell.topPB.backgroundColor = UIColor.red
        let value = cell.buttomPB.frame.size.width/100
        
        cell.ChildProgressWidthConstraint.constant = value*50
        
        cell.buttomPB.layer.cornerRadius = (cell.buttomPB.frame.size.height / 2)
        cell.topPB.layer.cornerRadius = (cell.topPB.frame.size.height / 2) 
        cell.buttomPB.layer.borderWidth = 1
         //cell.topPB.layer.borderWidth = 3
        cell.buttomPB.layer.borderColor = UIColor.gray.cgColor
    //    cell.topPB.layer.borderColor = UIColor.clear.cgColor
        return cell
    }
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        let c = viewHeight
        
        let   d = (c!*48)/720
        return  d/4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        let c = viewHeight
        
        let   d = (c!*48)/720
        return  d/4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let c = viewHeight
        
        let   d = (c!*48)/720
        
        print("collectionview hieght = "," constant = " ,self.collectionHeightConstraint.constant )
        
        return CGSize(width: self.collectionView.frame.width, height: d)
    }
    
    
    
}

extension UIView{
func roundCornersWithLayerMask(cornerRadii: CGFloat, corners: UIRectCorner) {
    //       let path = UIBezierPath(roundedRect: self.bounds,
    //                                byRoundingCorners: corners,
    //                                cornerRadii: CGSize(width: cornerRadii, height: cornerRadii))
    let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: cornerRadii, height: cornerRadii))
    
    let maskLayer = CAShapeLayer()
    maskLayer.path = path.cgPath
    self.layer.mask = maskLayer
    }}
