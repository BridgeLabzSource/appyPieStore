//
//  AudioListingController.swift
//  APPYSTORE
//
//  Created by BridgeLabz Solutions LLP  on 5/4/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit

class AudioListingController: BaseListingViewController {
    
    var catId: String = ""
    var catName: String = ""
    var pCatId: String = ""
    
    override internal func getPageName() -> String {
        return PageConstants.AUDIO_LISTING_PAGE
    }
    
    override func viewDidLoad() {
        self.catId = bundle?[BundleConstants.CATEGORY_ID] as! String
        self.pCatId = bundle?[BundleConstants.PARENT_CATEGORY_ID] as! String
        self.catName = bundle?[BundleConstants.CATEGORY_NAME] as! String
        dataFetchFramework = DataFetchFramework(pageName: PageConstants.AUDIO_LISTING_PAGE, pageUniqueId: catName, bundle: bundle)
        super.viewDidLoad()
    }
    
    override func registerCard() {
        self.collectionView.register(UINib(nibName: "AudioListingCard", bundle: nil), forCellWithReuseIdentifier: "AudioListingCard")
    }
    
    override func getCell(indexPath: IndexPath) -> BaseCard {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "AudioListingCard", for: indexPath) as! BaseCard
    }

    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = (self.collectionView?.frame.height)! - 16
        let width = height * 0.733 //aspect ratio 264/360
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let audioListingModel = dataFetchFramework?.contentList[indexPath.row] as! AudioListingModel
        print("AudioListingController : select audio \(audioListingModel.title)")
        
        if audioListingModel.payType == "paid" {
            var bundle = [String: Any]()
            //NavigationManager.openTrialSuccess(mainControllerCommunicator: self.mainControllerCommunicator!)
            NavigationManager.openTrialPopUp(mainControllerCommunicator: mainControllerCommunicator!, bundle: bundle)
        } else {
            NavigationManager.openAudioPlayerPage(mainControllerCommunicator: mainControllerCommunicator!, model: audioListingModel)
        }

    }
    
    
    override func getComponentProperties() -> ComponentProperties {
        let components = ComponentProperties()
        components.visibleIconsSet = [Item.BTN_BACK, Item.BTN_VIDEO, Item.BTN_AUDIO, Item.BTN_HISTORY , Item.BTN_SEARCH]
        
        return components
    }

//    var array1 = [#imageLiteral(resourceName: "search"),#imageLiteral(resourceName: "cartoon"),#imageLiteral(resourceName: "cartoon"),#imageLiteral(resourceName: "cartoon")]
//    
//    override func viewDidLoad()
//    {
//        super.viewDidLoad()
//        let nib = UINib(nibName: "AudioListingCard", bundle: nil)
//        collectionView?.register(nib, forCellWithReuseIdentifier: "Cell1")
//    }
//    
//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//    
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return array1.count
//    }
//    
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell1", for: indexPath) as! AudioListingCard
//        
//        return cell
//    }
//    


}
