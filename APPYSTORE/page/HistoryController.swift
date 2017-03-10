
import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage

class HistoryController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource{
    
    @IBOutlet var collectionView: UICollectionView!
    
    var dataList = [VideoListingModel]()
    var setLimit = 20;
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let dataManager = DataManager()
        dataManager.getData(pageName: PageConstants.HISTORY_PAGE, returndata: { result in
            self.dataList = result as! [VideoListingModel]
            self.collectionView.reloadData()
        })
        
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.delegate = self
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "historycell", for: indexPath) as! HistoryVideoCell
        let image_path = dataList[indexPath.row].imagePath
        let imgurl = URL(string: image_path)
        cell2.mVideoImage.sd_setImage(with:imgurl, placeholderImage:#imageLiteral(resourceName: "profile") )
        cell2.mVideoDescription.text = dataList[indexPath.row].canonicalName
        return cell2
    }
    
    
    //function to get lastVisibleCell at particular indexPath
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if var lastVisibleCell = self.collectionView.indexPathsForVisibleItems.last
        {
            let lastVisibleCellCount = lastVisibleCell.row + 1
            print("lastVisibleCellCount:  \(lastVisibleCellCount)")
            
            if(lastVisibleCellCount == setLimit) {
                print("loading.......")
            }
        }
    }
}
