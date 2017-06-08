//
//  RecommendedAudioViewController.swift
//  APPYSTORE
//
//  Created by BridgeLabz on 10/05/17.
//  Copyright  2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit

protocol RecommendedAudioDelegate {
    func onContentChange(content: AudioListingModel)
}

class RecommendedAudioViewController: BaseListingViewController {
    var test : Bool = true
    var delegate: RecommendedAudioDelegate?
    var currentIndex = -1
    var isClickedEnable = true
    var listingModel: AudioListingModel!
    var `as` = NSIndexPath()
    var currentIndexPath = IndexPath()
    override func viewDidLoad() {
        var bundle1 = [String: Any]()
        
        bundle1[BundleConstants.CATEGORY_ID] = listingModel.subCategoryId
        bundle1[BundleConstants.PARENT_CATEGORY_ID] = listingModel.parentCategoryId
        bundle1[BundleConstants.CONTENT_ID] = listingModel.contentId
        bundle1[BundleConstants.SEQUENCE_TYPE] = listingModel.sequenceType
        bundle1[BundleConstants.SEQUENCE_NUMBER] = listingModel.sequenceNumber
        bundle1[BundleConstants.LAST_CONTENT_ID] = ""
        
        
        dataFetchFramework = DataFetchFramework(pageName: PageConstants.RECOMMENDED_AUDIO_LISTING_PAGE, pageUniqueId: getPageNameUniqueIdentifier(), bundle: bundle1)
        registerCard()
        super.viewDidLoad()
      
    }
    override func viewDidAppear(_ animated: Bool) {
        
        
    }
    
    
    override internal func getPageNameUniqueIdentifier() -> String {
        return ""
    }
    
    override func getPageName() -> String {
        return PageConstants.RECOMMENDED_AUDIO_LISTING_PAGE
    }
    
    override func getDataSource() -> DataSource {
        return DataSource.SERVER
    }
    
    override func getCell(indexPath: IndexPath) -> RecommendedAudioCard {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendedAudioCard", for: indexPath) as! RecommendedAudioCard
    }
    
    override func loadData() {
        let count = dataFetchFramework?.contentList.count ?? -1
        
        if count > 0 {
            if let model = dataFetchFramework?.contentList[count - 1] as? AudioListingModel {
                dataFetchFramework?.updateBundle(keys: [BundleConstants.LAST_CONTENT_ID], values: [model.contentId])
            }
        } else {
            dataFetchFramework?.updateBundle(keys: [BundleConstants.LAST_CONTENT_ID], values: [listingModel.contentId])
        }
        super.loadData()
        
    }
    
    /*
     
     let singleTapPlay = UITapGestureRecognizer(target: self, action: #selector(RecommendedAudioViewController.imageClick))
     
     singleTapPlay.numberOfTapsRequired = 1
     AudioCard.imgThumbnail.isUserInteractionEnabled = true
     AudioCard.bringSubview(toFront: audioCard.imgThumbnail)
     AudioCard.imgThumbnail.addGestureRecognizer(singleTapPlay)
     singleTapPlay.view?.tag = indexPath.row
     func imageClick(sender: UITapGestureRecognizer) {
     print("Recommended section + \(sender.view?.tag)")
     }
     */
    
    override func registerCard() {
        self.collectionView.register(UINib(nibName: "RecommendedAudioCard", bundle: nil), forCellWithReuseIdentifier: "RecommendedAudioCard")
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = getCell(indexPath: indexPath)
        
    
        cell.fillCard(model: getModelToFillCard(index: indexPath))
           
        return cell
    }

    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let   height = 0.144*(collectionView.frame.size.height)
        let  width = 0.884*collectionView.frame.size.width
        
        return CGSize(width: width, height: height);
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      if isClickedEnable
      {
            let audioListingModel = dataFetchFramework?.contentList[indexPath.row] as! AudioListingModel
        if !audioListingModel.isSelected{
            (dataFetchFramework?.contentList[currentIndex] as! AudioListingModel).isSelected = false
            currentIndex = indexPath.row
            (dataFetchFramework?.contentList[currentIndex] as! AudioListingModel).isSelected = true
            delegate?.onContentChange(content: audioListingModel)
            
            collectionView.reloadData()
            
        }
        
        
         
    }

    }
    
    override func onDataReceived(status: String, result: AnyObject) {
        super.onDataReceived(status: status, result: result)
        currentIndex = 0
        let model = dataFetchFramework?.contentList[0] as! AudioListingModel
        model.isSelected = true
        
       // delegate?.onContentChange(content: model)
        collectionView.reloadData()
    }
    
    func nextAudio() {
        (dataFetchFramework?.contentList[currentIndex] as! AudioListingModel).isSelected = false
        
        if (dataFetchFramework?.contentList[currentIndex + 1] as! AudioListingModel).payType == "paid" {
            currentIndex = getPreferredIndex()
        } else {
            currentIndex += 1
        }
        print("nextAudio currentIndex = \(currentIndex)")
        (dataFetchFramework?.contentList[currentIndex] as! AudioListingModel).isSelected = true
        delegate?.onContentChange(content: dataFetchFramework?.contentList[currentIndex ] as! AudioListingModel)
        collectionView.reloadData()
    }
    
    func previousAudio() {
        if (currentIndex - 1) >= 0 {
            (dataFetchFramework?.contentList[currentIndex] as! AudioListingModel).isSelected = false
            
            if (dataFetchFramework?.contentList[currentIndex - 1] as! AudioListingModel).payType == "paid" {
                currentIndex = getPreferredIndex()
            } else {
                currentIndex -= 1
            }
            print("previouspreviousAudio currentIndex = \(currentIndex)")
            (dataFetchFramework?.contentList[currentIndex] as! AudioListingModel).isSelected = true
            delegate?.onContentChange(content: dataFetchFramework?.contentList[currentIndex ] as! AudioListingModel)
            collectionView.reloadData()
        }
    }
    
    func getPreferredIndex() -> Int {
        var index = currentIndex
        var valueIndex = -1
        print("getPreferredIndex start index \(index)")
        while index >= 0 {
            let model = (dataFetchFramework?.contentList[currentIndex] as! AudioListingModel);
            if model.payType == "paid" {
                print("getPreferredIndex index = \(index) pay type = \(model.payType)")
                break
            } else {
                valueIndex = index
            }
            index -= 1
        }
        print("getPreferredIndex end index \(index)")
        
        return valueIndex
    }
    
    override func setScrollDirection() {
        self.collectionView.setScrollDirectionVertical()
    }
    func  hideAudioEquilizerAnimation(){
       let count = dataFetchFramework?.contentList.count
        for  i in 0 ..< count!
        {
            if (dataFetchFramework?.contentList[i] as! AudioListingModel).isSelected == true
            {let index = IndexPath(row:i,section:0)
               if let cell = collectionView.cellForItem(at: index) as? RecommendedAudioCard
               {  cell.hideAudioEqualizer()
                cell.playImg.image = #imageLiteral(resourceName: "pauseAudioEquilizer")}
            }
        }
 
    }
    func showAudioEquilizerAnimation(){
    let count = dataFetchFramework?.contentList.count
        for  i in 0 ..< count!
        {   let index = IndexPath(row:i,section:0)
            if (dataFetchFramework?.contentList[i] as! AudioListingModel).isSelected == true
            {
           if let cell = collectionView.cellForItem(at: index) as? RecommendedAudioCard
           {
                cell.playImg.image = nil
                cell.showAudioEqualizer()
          
           }
            }else{
                if let cell = collectionView.cellForItem(at: index) as? RecommendedAudioCard{
                cell.hideAudioEqualizer()
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
        let size = DimensionManager.getGeneralizedHeight1280x720(height: 24)
    return UIEdgeInsetsMake(size,size,size,size)
        
    }
   
    
}


