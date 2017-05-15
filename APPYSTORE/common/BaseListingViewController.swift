//
//  BaseListingViewController.swift
//  APPYSTORE
//
//  Created by ios_dev on 03/04/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit

class BaseListingViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var collectionView: UICollectionView!
    
    var dataFetchFramework: DataFetchFramework?
    var status: String? = nil
    let CARD_HEIGHT: CGFloat = 384 - 32
    
    var collectionViewCentreX: CGFloat = 0.0
    var collectionViewCentreY: CGFloat = 0.0
    var isRequestInProgress = false
    
    let paginationThreshold = 4
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCard()
        collectionViewCentreX = self.collectionView.center.x
        collectionViewCentreY = self.collectionView.center.y

        self.collectionView.showsHorizontalScrollIndicator = false
        //self.collectionView.delegate = self
        
        self.collectionView.addSpacingBetweenCell()
        setScrollDirection()
        
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        if status != nil {
            switch status! {
            case BaseParser.REQUEST_SUCCESS:
                break
            case BaseParser.REQUEST_FAILURE:
                handleRequestFailure()
                break
            case BaseParser.CONNECTION_ERROR:
                handleConnectionError()
                break
            default:
                break
            }
        }
    }
    
    //to be overridden if required
    func setScrollDirection() {
        self.collectionView.setScrollDirectionHorizontal()
    }
    
    //to be overridden if required
    func registerCard() {
        self.collectionView.register(UINib(nibName: "VideoListingCard", bundle: nil), forCellWithReuseIdentifier: "VideoListingCard")
    }
    
    //to be overridden if required
    func getDataSource() -> DataSource{
        return DataSource.BOTH
    }
    
    func loadData() {
        isRequestInProgress = true
        mainControllerCommunicator?.showProgressBar()
        
        dataFetchFramework?.onDataReceived = onDataReceived
        dataFetchFramework?.start(dataSource: getDataSource())
    }

    func onDataReceived( status: String, result: AnyObject) {
        self.status = status
        isRequestInProgress = false
        mainControllerCommunicator?.hideProgressBar()
        
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
    
    func handleRequestFailure() {
        mainControllerCommunicator?.showCenterText(text: "OOPS_SOMETHING_WENT_WRONG_TRY_LATER".localized(lang: AppConstants.LANGUAGE))
    }
    
    func handleConnectionError() {
        mainControllerCommunicator?.showCenterText(text: "OOPS_SOMETHING_WENT_WRONG_TRY_LATER".localized(lang: AppConstants.LANGUAGE))
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (dataFetchFramework?.contentList.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = getCell(indexPath: indexPath)

        cell.fillCard(model: getModelToFillCard(index: indexPath))
        
        return cell
    }
    
    //to be overridden if required
    func getModelToFillCard(index: IndexPath) -> BaseModel {
        return (dataFetchFramework?.contentList[index.row])!
    }
    
    //to be overridden if required
    func getCell(indexPath: IndexPath) -> BaseCard {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "VideoListingCard", for: indexPath) as! BaseCard
    }
    
    //to be overridden if required
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
    
    override func resetPage() {
        print("resetPage \(getPageName())")
        dataFetchFramework?.reset()
        dataFetchFramework?.start(dataSource: getDataSource())
    }
}
