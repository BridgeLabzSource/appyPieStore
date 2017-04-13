//
//  RecommendedVideoViewController.swift
//  APPYSTORE
//
//  Created by ios_dev on 12/04/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit

class RecommendedVideoViewController: BaseListingViewController {
    
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
        let videoCard = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendedVideoCard", for: indexPath) as! RecommendedVideoCard
        
        return videoCard as BaseCard
    }
    
    
    
    override func registerCard() {
        self.collectionView.register(UINib(nibName: "RecommendedVideoCard", bundle: nil), forCellWithReuseIdentifier: "RecommendedVideoCard")
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.size.height - DimensionManager.getGeneralizedHeight1280x720(height: 48)
        let width = DimensionManager.getGeneralizedWidthIn16isto9Ratio(height: height)
        
        return CGSize(width: width, height: height);
    }
}
