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
import NVActivityIndicatorView

class ChildProgressController: BaseListingViewController,ChildSelectionInChildProgressControllerDelegate{
    
    @IBOutlet weak var progressStatusLbl: UILabel!
    
    @IBOutlet weak var audioCategoryNameLbl: UILabel!
    
    @IBOutlet weak var audioImgForAudioCategory: UIImageView!
    
    @IBOutlet weak var audioCategoryBtn: UIButton!
    
    @IBOutlet weak var VideosCategoryNameLbl: UILabel!
    
    @IBOutlet weak var videoImgForVideoCategory: UIImageView!
    
    @IBOutlet weak var videoCategoryBtn: UIButton!
    
    
    @IBOutlet weak var topMainPageLbl: UILabel!
    
    @IBOutlet weak var bottomViewBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var ChildSelectionInChildProgressControllerContainer: UIView!
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var videoCategoryBtnView: UIView!

    @IBOutlet weak var audioCategorybtnView: UIView!
    
    @IBOutlet weak var collectionHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var contentview: UIView!
    
    @IBOutlet weak var childNameLbl: UILabel!
    
    @IBOutlet weak var bottomView: UIView!
    
   
    
    var whichCatagoryBtnIsEnabled = "video"
    var progressStatus:NVActivityIndicatorView?
    
    let AUDIO  = "audio"
    let VIDEO  = "video"
    let BOTH   = "both"
    let FORALL = "forAll"
    override func viewDidLoad() {
       initProgressBar()
       addAsChildViewController(childController: childSelectionInChildProgressController)
        
        dataFetchFramework = DataFetchFramework(pageName: getPageName(), pageUniqueId: "",  bundle: bundle)
       
        super.viewDidLoad()
        
        childSelectionInChildProgressController.delegate = self
        
        let size = DimensionManager.getGeneralizedHeight1280x720(height: 75)
        collectionHeightConstraint.constant = size
        

        
        
        setViews()
        backBtnAction()
        setSelectedChildNameForView()
        setAllLblSize()
        hideBtn(type: AUDIO, isHidden: true)
        hideBtn(type: VIDEO, isHidden: true)
    }
  /*  func setCornerRaduis(){
    setCornerRaduisForViews(forWhichView: FORALL)
    }*/
    
    override func viewDidAppear(_ animated: Bool) {
        setCornerRaduisForViews(forWhichView: FORALL)
        
        
    }
    private func initProgressBar() {
        let width = DimensionManager.getGeneralizedWidth1280x720(width: 210)
        let height = DimensionManager.getGeneralizedHeight1280x720(height: 70)
        let frame = CGRect(x: CGFloat(bottomView.frame.width/2 - width/2), y: 0, width: width, height: height)
        progressStatus = NVActivityIndicatorView(frame: frame, type: NVActivityIndicatorType.ballPulse, color: UIColor.orange, padding: CGFloat(0))
    }
    
    
    lazy var childSelectionInChildProgressController: ChildSelectionInChildProgressController = {
        print("child selection in child Controller lazyload")
        let storyboard = UIStoryboard(name: "ChildProgress", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ChildSelectionInChildProgressController") as! ChildSelectionInChildProgressController
        viewController.mainControllerCommunicator = self.mainControllerCommunicator
        self.addChildViewController(viewController)
        return viewController
    }()
    
    
    // for adding the childSelection view in childprogress contrlr
    func addAsChildViewController(childController: BaseViewController){
        print("ChildSelectionInChildProgressController addAsChildViewController")
        addChildViewController(childController)
        ChildSelectionInChildProgressControllerContainer.addSubview(childController.view)
        
        childController.view.frame = ChildSelectionInChildProgressControllerContainer.bounds
        childController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        childController.didMove(toParentViewController: self)
        
    }

    //Audio & video catagory btn Actions
    
    @IBAction func videoCategoryBtnAction(_ sender: Any) {
        // if audio catagory btn clicked then change the videoCatagoryView bkgrndclr to white
        videoCategoryBtnView.backgroundColor = UIColor.white
        audioCategorybtnView.backgroundColor = UIColor.lightGray
     
        //after clicked change status of whichCatagoryBtnIsEnabled
        if whichCatagoryBtnIsEnabled != VIDEO
        {
            whichCatagoryBtnIsEnabled = VIDEO
            collectionView.reloadData()
        }
    }
    
   
    @IBAction func audioCategoryBtnAction(_ sender: Any) {
        videoCategoryBtnView.backgroundColor = UIColor.lightGray
        audioCategorybtnView.backgroundColor = UIColor.white
    
        if whichCatagoryBtnIsEnabled != AUDIO
        {
            if videoCategoryBtn.isHidden == false
            { whichCatagoryBtnIsEnabled = AUDIO
                collectionView.reloadData()}
        }
    }
    
    
    
    
    
   
   
    override func getPageName() -> String {
        return PageConstants.SELECT_CHILD_PROGRESS_PAGE
    }
    
    override func getDataSource() -> DataSource{
       
        return DataSource.SERVER
    }
    
    override func getComponentProperties() -> ComponentProperties {
        let components = ComponentProperties()
        components.visibleIconsSet = [Item.BTN_BACK]
        
        return components
    }
    
   
    override func registerCard() {
        //NA
    }
    
    override func setScrollDirection() {
        self.collectionView.setScrollDirectionVertical()
    }
    
    override func getCell(indexPath: IndexPath) -> BaseCard {
        
        return collectionView.dequeueReusableCell(withReuseIdentifier: "ChildProgressCustomCell", for: indexPath) as! ChildProgressCustomCell
    }
    
    
    override func getModelToFillCard(index: IndexPath) -> BaseModel {
     let m = (dataFetchFramework?.contentList[0])! as! ContentListingApiResponseModel
     let c = m as! ChildProgressApiResponseModel
     let h = c.videoList
     return h[index.row]
    
    }
    
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
       return getNumberOfItemsInSection()
         
    }
    
    //here contentList array of datafetch framwork is having only 1 Obj
    //which Obj containing two array Audio & Video
    func getNumberOfItemsInSection()->Int {
   
        if (dataFetchFramework?.contentList.count)! >= 1
         {
            handleCatagoryBtnDisplayStatus()
            showDataFoundStatusMsg()
        
        switch whichCatagoryBtnIsEnabled {
           
            case AUDIO:
                return FilterContentListAndgetCount(type: AUDIO)
            
            case VIDEO:
                changeSelectedBtnColor()
                return FilterContentListAndgetCount(type: VIDEO)
            
            default:
                break
            }
        
        }
        let size = DimensionManager.getGeneralizedHeight1280x720(height: 75)
        collectionHeightConstraint.constant = size
        return 0
    }
    
    
    
    //return the count of Audio & Video from ContentList single Obj
    
    func FilterContentListAndgetCount(type : String)-> Int{
        
        let contentList = (dataFetchFramework?.contentList[0])! as! ContentListingApiResponseModel
        let childProgressContentList = contentList as! ChildProgressApiResponseModel
        if type == AUDIO
        {
            
            return childProgressContentList.audioList.count
        }
        
            return childProgressContentList.videoList.count
        
    }
  
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
       let size = DimensionManager.getGeneralizedHeight1280x720(height: 56)
        
       
        let cell = getCell(indexPath: indexPath)
        
        cell.fillCard(model: getModelToFillCard(index: indexPath))
        
        bottomViewBottomConstraint.constant = -size
        changeProgressCollectionViewHeight()
        setCornerRaduisForViews(forWhichView: FORALL)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
        
        
        let top = DimensionManager.getGeneralizedHeight1280x720(height: 48)
        let bottum = DimensionManager.getGeneralizedHeight1280x720(height: 48)
        
        return UIEdgeInsetsMake(top, 0, bottum, 0)
        
    }

 
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
  
        let height = DimensionManager.getGeneralizedHeight1280x720(height: 48)
        let width = self.collectionView.frame.width
        
        return CGSize(width: width, height: height);

    
    }
    
    // for loading the data of selected or changed child
    
    override func loadData() {
        isRequestInProgress = true
        
        showProgress()
        dataFetchFramework?.onDataReceived = onDataReceived
        dataFetchFramework?.start(dataSource: getDataSource())
    }
    
    //BaseListingVC method is overriden for changed child data loading..
    
    override func onDataReceived( status: String, result: AnyObject) {
        self.status = status
        isRequestInProgress = false
        hideProgress()
        
        if status == BaseParser.REQUEST_SUCCESS {
            if let result = result as? [BaseModel] {
                print("onDataReceived called", result.count)
                self.view.setNeedsDisplay()
                self.collectionView.reloadData()
                
            }
        } else if status == DataFetchFramework.END_OF_DATA {
            
        } else {
            if status == BaseParser.REQUEST_FAILURE {
                handleRequestFailure()
            } else if status == BaseParser.CONNECTION_ERROR{
                handleConnectionError()
            }
            print("Ganesh status : \(status) and response : \(result) ")
        }
    }
    
    override func handleRequestFailure() {
        //NA
        self.collectionView.reloadData()
        DimensionManager.setTextSize1280x720(label: progressStatusLbl, size: DimensionManager.H2)
        progressStatusLbl.text = "No Data found"
    }
    
    override func handleConnectionError() {
        //NA
    }
    
    // delegate method of ChildSelectionInChildProgessVC ehwn any other child selected data is loaded for selected child
    func changeChildOnSelect(indexPath : IndexPath) {
        progressStatusLbl.text = ""
        dataFetchFramework?.contentList.removeAll()
        collectionView.reloadData()
        loadData()
        setSelectedChildNameForView()
    }
    func backBtnAction()
    {
        self.view.bringSubview(toFront: backBtn)
        backBtn.addTarget(self, action: #selector(handleBackButtonClick), for: .touchUpInside)
    }
    //if Audio & Video count is != 0 then it will display both btn
    func handleCatagoryBtnDisplayStatus(){
        
        let audioCount = FilterContentListAndgetCount(type : AUDIO)
        let videoCount = FilterContentListAndgetCount(type : VIDEO)
        
        if audioCount == 0 && videoCount == 0
        {handleHideBtnStatus(type : BOTH)}
        else if(audioCount == 0 && videoCount > 0)
        {handleHideBtnStatus(type: AUDIO)}
        else if(videoCount == 0 && audioCount > 0)
        {   handleHideBtnStatus(type: VIDEO)
            whichCatagoryBtnIsEnabled = AUDIO}
    }
    
    //for handling hide Btn Status
    //called from handleCatagoryBtnDisplayStatus() method
    func handleHideBtnStatus(type : String){
        
        // Initailly show AUDIO button
        hideBtn(type: AUDIO , isHidden: false)
        
        // Initailly show VIDEO button
        hideBtn(type: VIDEO, isHidden: false)
        
        switch type {
            
        case AUDIO:
            //hide audio btn and assign the place of audio btn to video btn
            audioCategoryNameLbl.text = VideosCategoryNameLbl.text
            audioImgForAudioCategory.image = videoImgForVideoCategory.image
            
            hideBtn(type: VIDEO, isHidden: true)
        case VIDEO:
            
            hideBtn(type: VIDEO, isHidden: true)
        case BOTH:
            
            hideBtn(type: AUDIO, isHidden: true)
            hideBtn(type: VIDEO, isHidden: true)
        default:
            break
        }
        
    }
    
    //hide purticular Btn Of catagory Audio or Video
    //Called for handleHideBtnStatus() method
    func   hideBtn(type : String,isHidden : Bool){
        
        switch type {
        case AUDIO:
            
            audioCategoryNameLbl.isHidden = isHidden
            audioImgForAudioCategory.isHidden = isHidden
            audioCategorybtnView.isHidden = isHidden
            audioCategoryBtn.isHidden = isHidden
            
        case VIDEO:
            
            VideosCategoryNameLbl.isHidden = isHidden
            videoImgForVideoCategory.isHidden = isHidden
            videoCategoryBtnView.isHidden = isHidden
            videoCategoryBtn.isHidden = isHidden
        default:
            break
        }
        
        //for changeing color for Video catagory Btn when Initailly page loaded
        func changeSelectedBtnColor(){
            if videoCategoryBtnView.isHidden == false
            {
                videoCategoryBtnView.backgroundColor = UIColor.white
                audioCategorybtnView.backgroundColor = UIColor.lightGray
            }
        }
        
    }
    
    
    
    func handleBackButtonClick() {
        print("childProgressController handleBackButtonClick")
        mainControllerCommunicator?.performBackButtonClick(self)
        mainControllerCommunicator?.hideProgressBar()
    }
    
    //for settting scrollView & bottomView
    func setViews(){
        self.bottomView.layer.masksToBounds = true
        let size = DimensionManager.getGeneralizedHeight1280x720(height: 56)
        
        bottomViewBottomConstraint.constant = -size
        self.contentview.layer.cornerRadius = getRadius(view : contentview)
        self.contentview.layer.masksToBounds = true
        self.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: size, right: 0)
        contentview.backgroundColor = UIColor(red:1.0, green:1.0, blue:1.0, alpha:0.5)
        
    }
    
    //Imp method for Dynamically changing the collection view height as per the number of cell present
    func changeProgressCollectionViewHeight(){
        self.collectionHeightConstraint.constant = self.collectionView.collectionViewLayout.collectionViewContentSize.height
        
        self.bottomView.layer.masksToBounds = true
        self.collectionView.layer.masksToBounds = true
    }

   let size = DimensionManager.getGeneralizedHeight1280x720(height: 56)
    
  //showing the progressView for data loading
    func showProgress(){
        self.progressStatus?.startAnimating()
        self.progressStatusLbl.addSubview(self.progressStatus!)
    }
    func hideProgress(){
        self.progressStatus?.stopAnimating()
        self.progressStatus?.removeFromSuperview()
    }
   
    
    //if no record found for purticular child then yhis method will be called
    func showDataFoundStatusMsg(){
        
        DimensionManager.setTextSize1280x720(label: progressStatusLbl, size: DimensionManager.H2)
        
        switch whichCatagoryBtnIsEnabled{
                case AUDIO:
                            if FilterContentListAndgetCount(type: AUDIO) == 0
                                {
                                    progressStatusLbl.text = "No Data found"
                                    bottomView.backgroundColor = UIColor.clear
                                }else
                                {
                                    progressStatusLbl.text = ""
                                    bottomView.backgroundColor = UIColor.white
                                }
                
                case VIDEO:
                    if FilterContentListAndgetCount(type: VIDEO) == 0
                        { progressStatusLbl.text = "No Data found"
                            bottomView.backgroundColor = UIColor.clear

                        }else{
                        progressStatusLbl.text = ""
                        bottomView.backgroundColor = UIColor.white
                        }
                
                default:
                    break
                }
    }
 
    
    func setAllLblSize()
    {
        
        DimensionManager.setTextSize1280x720(label: topMainPageLbl, size: DimensionManager.H1)
        topMainPageLbl.text =  "Child Progress"
        DimensionManager.setTextSize1280x720(label: VideosCategoryNameLbl, size: DimensionManager.H3)
        DimensionManager.setTextSize1280x720(label: audioCategoryNameLbl, size: DimensionManager.H3)
    }
    
    
    func setSelectedChildNameForView()
    {
        DimensionManager.setTextSize1280x720(label: childNameLbl, size: DimensionManager.H3)
        let selectedchildName = UserInfo.getInstance().selectedChild?.name
        childNameLbl.text = selectedchildName! + "'s progress"
    }
   
    
    func setCornerRaduisForViews(forWhichView : String){
       let size = DimensionManager.getGeneralizedHeight1280x720(height: 56)
        if forWhichView == FORALL
        {
            let cornerRaduisWidth = videoCategoryBtnView.frame.height/4
            videoCategoryBtnView.roundCornersWithLayerMask(cornerRadii: cornerRaduisWidth,corners: [.topLeft,.topRight])
            audioCategorybtnView.roundCornersWithLayerMask(cornerRadii: cornerRaduisWidth,corners: [.topLeft,.topRight])
            bottomView.roundCornersWithLayerMask(cornerRadii: getRadius(view : bottomView),corners: [.topLeft,.bottomLeft,.bottomRight])
            bottomViewBottomConstraint.constant = -size
            
        }else
        {
            bottomViewBottomConstraint.constant = -size
            bottomView.roundCornersWithLayerMask(cornerRadii: getRadius(view : bottomView),corners: [.topLeft,.bottomLeft,.bottomRight])
            
        }
        self.bottomView.layer.masksToBounds = true
    }
  
    //get radius for setting the corner radius of views
    
    func getRadius(view : UIView)-> CGFloat{
       if view == bottomView
       {
            let radius = view.frame.size.width / 16.0
            return radius
        }
            let radius = min(view.frame.size.height, view.frame.size.width) / 8.0
            return radius
    }
    //for changeing color for Video catagory Btn when Initailly page loaded
    
    func changeSelectedBtnColor(){
        
        if videoCategoryBtnView.isHidden == false
            
        {
            
            videoCategoryBtnView.backgroundColor = UIColor.white
            
            audioCategorybtnView.backgroundColor = UIColor.lightGray
            
        }
        
    }
   
}


// for making the corner radius of purticular side as per the view requirment
extension UIView{
func roundCornersWithLayerMask(cornerRadii: CGFloat, corners: UIRectCorner) {
 
    let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: cornerRadii, height: cornerRadii))
    
    let maskLayer = CAShapeLayer()
    maskLayer.frame = self.bounds
    maskLayer.path = path.cgPath
    self.layer.mask = maskLayer
    
    }}







