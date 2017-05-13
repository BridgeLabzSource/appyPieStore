//
//  RecommendedAudioViewController.swift
//  APPYSTORE
//
//  Created by BridgeLabz on 10/05/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit


protocol RecommendedAudioDelegate {
    func onContentChange(content: AudioListingModel)
}

class RecommendedAudioViewController: BaseListingViewController {

    var delegate: RecommendedAudioDelegate?
    var currentIndex = -1
    var isClickedEnable = true
    var listingModel: AudioListingModel!
    
    override func viewDidLoad() {
        var bundle1 = [String: Any]()
        
        bundle1[BundleConstants.CATEGORY_ID] = listingModel.subCategoryId
        bundle1[BundleConstants.PARENT_CATEGORY_ID] = listingModel.parentCategoryId
        bundle1[BundleConstants.CONTENT_ID] = listingModel.contentId
        bundle1[BundleConstants.SEQUENCE_TYPE] = listingModel.sequenceType
        bundle1[BundleConstants.SEQUENCE_NUMBER] = listingModel.sequenceNumber
        bundle1[BundleConstants.LAST_CONTENT_ID] = ""
        
        
        dataFetchFramework = DataFetchFramework(pageName: PageConstants.RECOMMENDED_AUDIO_LISTING_PAGE, pageUniqueId: getPageNameUniqueIdentifier(), bundle: bundle1)
        
        super.viewDidLoad()
        
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
    
    override func getCell(indexPath: IndexPath) -> BaseCard {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendedAudioCard", for: indexPath) as! BaseCard
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
        self.collectionView.register(UINib(nibName: "RecommendedAudioCell", bundle: nil), forCellWithReuseIdentifier: "RecommendedAudioCard")
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.size.height - DimensionManager.getGeneralizedHeight1280x720(height: 48)
        let width = DimensionManager.getGeneralizedWidthIn16isto9Ratio(height: height)
        
        return CGSize(width: width, height: height);
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isClickedEnable {
            let audioListingModel = dataFetchFramework?.contentList[indexPath.row] as! AudioListingModel
            (dataFetchFramework?.contentList[currentIndex] as! AudioListingModel).isSelected = false
            currentIndex = indexPath.row
            (dataFetchFramework?.contentList[currentIndex] as! AudioListingModel).isSelected = true
            delegate?.onContentChange(content: audioListingModel)
            collectionView.reloadData()
        }
        
    }
    
    override func onDataReceived(status: String, result: AnyObject) {
        super.onDataReceived(status: status, result: result)
        currentIndex = 0
        let model = dataFetchFramework?.contentList[0] as! AudioListingModel
        model.isSelected = true
        //delegate?.onContentChange(content: model)
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
    
}
