//
//  AvatarSelectionController.swift
//  APPYSTORE
//
//  Created by ios_dev on 19/04/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit

class AvatarSelectionController: BaseListingViewController {

    @IBOutlet weak var lblTitle: UILabel!
    var pageName: String?
    
    internal override func getPageName() -> String {
        return pageName!
    }
    
    internal override func getPageNameUniqueIdentifier() -> String {
        return ""
    }
    
    override func viewDidLoad() {
        readBundle()
        initializeView()
        dataFetchFramework = DataFetchFramework(pageName: getPageName(), pageUniqueId: "",  bundle: bundle)
        super.viewDidLoad()

    }
    
    func readBundle() {
        //todo
        pageName = PageConstants.SELECT_AVATAR_PAGE_NEW
    }
    
    func initializeView() {
        DimensionManager.setTextSize1280x720(label: lblTitle, size: DimensionManager.H1)
    }
    
    override func registerCard() {
        self.collectionView.register(UINib(nibName: "ChildCard", bundle: nil), forCellWithReuseIdentifier: "ChildCard")
    }
    
    override func getCell(indexPath: IndexPath) -> BaseCard {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "ChildCard", for: indexPath) as! BaseCard
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.bounds.size.height
        let width = height
        
        return CGSize(width: width, height: height);
    }
}
