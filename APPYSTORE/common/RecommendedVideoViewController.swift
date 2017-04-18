//
//  RecommendedVideoViewController.swift
//  APPYSTORE
//
//  Created by ios_dev on 12/04/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit

protocol RecommendedVideoDelegate {
    func onContentChange(content: VideoListingModel)
}

class RecommendedVideoViewController: BaseListingViewController {
    var delegate: RecommendedVideoDelegate?
    var currentIndex = -1
    var isClickedEnable = true
    
    override func viewDidLoad() {
        dataFetchFramework = DataFetchFramework(pageName: PageConstants.RECOMMENDED_VIDEO_LISTING_PAGE, pageUniqueId: "20087824", bundle: bundle)
        super.viewDidLoad()
    }
    
    override func getPageName() -> String {
        return PageConstants.RECOMMENDED_VIDEO_LISTING_PAGE
    }
    
    override func getDataSource() -> DataSource {
        return DataSource.SERVER
    }
    
    override func getCell(indexPath: IndexPath) -> BaseCard {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendedVideoCard", for: indexPath) as! BaseCard
    }
    
    /*
     
     let singleTapPlay = UITapGestureRecognizer(target: self, action: #selector(RecommendedVideoViewController.imageClick))
     
     singleTapPlay.numberOfTapsRequired = 1
     videoCard.imgThumbnail.isUserInteractionEnabled = true
     videoCard.bringSubview(toFront: videoCard.imgThumbnail)
     videoCard.imgThumbnail.addGestureRecognizer(singleTapPlay)
     singleTapPlay.view?.tag = indexPath.row
    func imageClick(sender: UITapGestureRecognizer) {
        print("Recommended section + \(sender.view?.tag)")
    }
 */
    
    override func registerCard() {
        self.collectionView.register(UINib(nibName: "RecommendedVideoCard", bundle: nil), forCellWithReuseIdentifier: "RecommendedVideoCard")
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.size.height - DimensionManager.getGeneralizedHeight1280x720(height: 48)
        let width = DimensionManager.getGeneralizedWidthIn16isto9Ratio(height: height)
        
        return CGSize(width: width, height: height);
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isClickedEnable {
            let videoListingModel = dataFetchFramework?.contentList[indexPath.row] as! VideoListingModel
            (dataFetchFramework?.contentList[currentIndex] as! VideoListingModel).isSelected = false
            currentIndex = indexPath.row
            (dataFetchFramework?.contentList[currentIndex] as! VideoListingModel).isSelected = true
            delegate?.onContentChange(content: videoListingModel)
            collectionView.reloadData()
        }
        
    }
    
    override func onDataReceived(status: String, result: AnyObject) {
        super.onDataReceived(status: status, result: result)
        currentIndex = 0
        let model = dataFetchFramework?.contentList[0] as! VideoListingModel
        model.isSelected = true
        delegate?.onContentChange(content: model)
        collectionView.reloadData()
    }
    
    func nextVideo() {
        (dataFetchFramework?.contentList[currentIndex] as! VideoListingModel).isSelected = false
        
        if (dataFetchFramework?.contentList[currentIndex + 1] as! VideoListingModel).payType == "paid" {
            currentIndex = getPreferredIndex()
        } else {
            currentIndex += 1
        }
        print("nextVideo currentIndex = \(currentIndex)")
        (dataFetchFramework?.contentList[currentIndex] as! VideoListingModel).isSelected = true
        delegate?.onContentChange(content: dataFetchFramework?.contentList[currentIndex ] as! VideoListingModel)
        collectionView.reloadData()
    }
    
    func getPreferredIndex() -> Int {
        var index = currentIndex
        var valueIndex = -1
        print("getPreferredIndex start index \(index)")
        while index >= 0 {
            let model = (dataFetchFramework?.contentList[currentIndex] as! VideoListingModel);
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
