//
//  BaseListingViewController.swift
//  APPYSTORE
//
//  Created by ios_dev on 03/04/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class BaseListingViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var collectionView: UICollectionView!
    var dataFetchFramework: DataFetchFramework?
    let CARD_HEIGHT: CGFloat = 384 - 32
    
    var collectionViewCentreX: CGFloat = 0.0
    var collectionViewCentreY: CGFloat = 0.0
    var progressView: NVActivityIndicatorView?
    var isRequestInProgress = false
    
    let paginationThreshold = 4
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(UINib(nibName: "VideoListingCard", bundle: nil), forCellWithReuseIdentifier: "VideoListingCard")
        collectionViewCentreX = self.collectionView.center.x
        collectionViewCentreY = self.collectionView.center.y

        self.collectionView.showsHorizontalScrollIndicator = false
        //self.collectionView.delegate = self
        
        self.collectionView.addSpacingBetweenCell()
        
        loadData()
    }
    
    func loadData() {
        isRequestInProgress = true
        let frame = CGRect(x: Int(collectionViewCentreX - 25), y: Int(collectionViewCentreY / 2), width: 30, height: 30)
        progressView = NVActivityIndicatorView(frame: frame, type: NVActivityIndicatorType.ballPulse, color: UIColor.orange, padding: CGFloat(0))
        progressView?.startAnimating()
        self.collectionView.addSubview(progressView!)
        
        dataFetchFramework?.onDataReceived = onDataReceived
        dataFetchFramework?.start(dataSource: DataSource.BOTH)
    }

    func onDataReceived( status: String, result: AnyObject) {
        isRequestInProgress = false
        progressView?.stopAnimating()
        progressView?.removeFromSuperview()
        if status == DataFetchFramework.REQUEST_SUCCESS {
            if let result = result as? [BaseModel] {
                //setLimit = result.count
                print("Ganesh Server Data : \(result)")
                //self.dataList = result as! [VideoListingModel]
                self.view.setNeedsDisplay()
                print("Data Found:",result.count)
                self.collectionView.reloadData()
            }
        } else if status == DataFetchFramework.END_OF_DATA {
            
        } else {
            print("Ganesh status : \(status) and response : \(result) ")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (dataFetchFramework?.contentList.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoListingCard", for: indexPath) as! VideoListingCard
        cell.fillCard(videoListingModel: dataFetchFramework?.contentList[indexPath.row] as! VideoListingModel)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = DimensionManager.getGeneralizedHeight1280x720(height: CARD_HEIGHT)
        let width = DimensionManager.getGeneralizedWidthIn4isto3Ratio(height: height)
        
        return CGSize(width: width, height: height);
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if var lastVisibleCell = self.collectionView.indexPathsForVisibleItems.last {
            let lastVisibleCellCount = lastVisibleCell.row + paginationThreshold
            
            if lastVisibleCellCount  >= (dataFetchFramework?.contentList.count)! && !isRequestInProgress{
                collectionViewCentreX = (scrollView.contentSize.width)
                collectionViewCentreY = (scrollView.contentSize.height)
                loadData()
            }
        }
    }


}