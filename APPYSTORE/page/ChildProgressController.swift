//
//  ChildProgressController.swift
//  APPYSTORE
//
//  Created by BridgeLabz on 02/05/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ChildProgressController: BaseListingViewController{
    
    
    
    
    @IBOutlet weak var ChildSelectionInChildProgressControllerContainer: UIView!
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var videoCategoryBtnView: UIView!

    @IBOutlet weak var audioCategorybtnView: UIView!
    
    @IBOutlet weak var collectionHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var contentview: UIView!
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var bottumView: UIView!
    
    
    var ab:Int = 0
    
    var viewHeight:CGFloat!
    
    override func viewDidLoad() {
       
       
        addAsChildViewController(childController: childSelectionInChildProgressController)
        //childSelectionInChildProgressController.delegate = self
        dataFetchFramework = DataFetchFramework(pageName: getPageName(), pageUniqueId: "",  bundle: bundle)
        super.viewDidLoad()
        
        self.bottumView.layer.cornerRadius = 15
        self.bottumView.layer.masksToBounds = true
        self.contentview.layer.cornerRadius = 15
        self.contentview.layer.masksToBounds = true
        self.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 40, right: 0)
       
        viewHeight = self.view.frame.height
        
        
        
        print("collectionview hieght = ",self.collectionView.collectionViewLayout.collectionViewContentSize.height," constant = " ,self.collectionHeightConstraint.constant )
             contentview.backgroundColor = UIColor(red:1.0, green:1.0, blue:1.0, alpha:0.5)
        let cornerRaduisWidth = videoCategoryBtnView.frame.height/4
        
        
        videoCategoryBtnView.roundCornersWithLayerMask(cornerRadii: cornerRaduisWidth,corners: [.topLeft,.topRight])
        audioCategorybtnView.roundCornersWithLayerMask(cornerRadii: cornerRaduisWidth,corners: [.topLeft,.topRight])
        
        
        self.view.bringSubview(toFront: backBtn)
        backBtn.addTarget(self, action: #selector(handleBackButtonClick), for: .touchUpInside)
        DimensionManager.setTextSize1280x720(label: label, size: DimensionManager.H3)
    }
    
    lazy var childSelectionInChildProgressController: ChildSelectionInChildProgressController = {
        print("child selection in child Controller lazyload")
        let storyboard = UIStoryboard(name: "ChildProgress", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ChildSelectionInChildProgressController") as! ChildSelectionInChildProgressController
        self.addChildViewController(viewController)
        return viewController
    }()
    
    
  
 func addAsChildViewController(childController: BaseViewController){
        print("ChildSelectionInChildProgressController addAsChildViewController")
        addChildViewController(childController)
        ChildSelectionInChildProgressControllerContainer.addSubview(childController.view)
        
        childController.view.frame = ChildSelectionInChildProgressControllerContainer.bounds
        childController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
       childController.didMove(toParentViewController: self)
        
    }

    func handleBackButtonClick() {
        print("childProgressController handleBackButtonClick")
        mainControllerCommunicator?.performBackButtonClick(self)
        mainControllerCommunicator?.hideProgressBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
              //  collectionView.reloadData()
    }
    
    override func getPageName() -> String {
        return PageConstants.SELECT_CHILD_PROGRESS_PAGE
    }
    
    override func getDataSource() -> DataSource{
       
        return DataSource.SERVER
    }

    //to be overridden if required
    override func getModelToFillCard(index: IndexPath) -> BaseModel {
     let m = (dataFetchFramework?.contentList[0])! as! ContentListingApiResponseModel
     let c = m as! ChildProgressApiResponseModel
     let h = c.videoList
     return h[index.row]
    
    }
    
    override func getComponentProperties() -> ComponentProperties {
        let components = ComponentProperties()
        components.visibleIconsSet = [Item.BTN_BACK]
        
        return components
    }

 
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if (dataFetchFramework?.contentList.count)! == 1
    {
         let m = (dataFetchFramework?.contentList[0])! as! ContentListingApiResponseModel
         let c = m as! ChildProgressApiResponseModel
         // let h = c.videoList
         return c.videoList.count }
        else
    {
        
        return 0 }
         
     
    }
 
    override func getCell(indexPath: IndexPath) -> BaseCard {
       
        return collectionView.dequeueReusableCell(withReuseIdentifier: "ChildProgressCustomCell", for: indexPath) as! ChildProgressCustomCell
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
       
   // let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChildProgressCustomCell", for: indexPath) as! ChildProgressCustomCell
       // getModelToFillCard(index:indexPath)
     /*   cell.topPB.backgroundColor = UIColor.red
        
        let value = cell.buttomPB.frame.size.width/100
        
        cell.ChildProgressWidthConstraint.constant = value*50
        
        cell.buttomPB.layer.cornerRadius = (cell.buttomPB.frame.size.height / 2)
        cell.topPB.layer.cornerRadius = (cell.topPB.frame.size.height / 2)
        cell.buttomPB.layer.borderWidth = 1
        //cell.topPB.layer.borderWidth = 3
        cell.buttomPB.layer.borderColor = UIColor.gray.cgColor
     */
        
        let cell = getCell(indexPath: indexPath)
        
        cell.fillCard(model: getModelToFillCard(index: indexPath))

        changeCVHeight()
        return cell
    }
 
 
 /*  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        let c = viewHeight
        
        let   d = (c!*48)/720
        return  d/4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        let c = viewHeight
        
        let   d = (c!*48)/720
        return  d/4
    }
 */
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let c = viewHeight
        
        let   d = (c!*48)/720
        
        print("collectionview hieght = "," constant = " ,self.collectionHeightConstraint.constant )
        
        return CGSize(width: self.collectionView.frame.width, height: d)
    }
 
 
    override func setScrollDirection() {
        self.collectionView.setScrollDirectionVertical()
    }
    override func registerCard() {
        //NA
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("---------->child//in//in///Controller viewDidAppear")
    /*
        childSelectionInChildProgressController.view.frame = self.ChildSelectionInChildProgressControllerContainer.frame
        childSelectionInChildProgressController.view.bounds = self.ChildSelectionInChildProgressControllerContainer.bounds
     */   
        
        
    }
    func changeCVHeight(){
        self.collectionHeightConstraint.constant = self.collectionView.collectionViewLayout.collectionViewContentSize.height
    }
    
}

extension UIView{
func roundCornersWithLayerMask(cornerRadii: CGFloat, corners: UIRectCorner) {
 
    let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: cornerRadii, height: cornerRadii))
    
    let maskLayer = CAShapeLayer()
    maskLayer.frame = self.bounds
    maskLayer.path = path.cgPath
    self.layer.mask = maskLayer
    
    }}



