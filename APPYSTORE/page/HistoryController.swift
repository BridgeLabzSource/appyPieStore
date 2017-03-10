
import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage

class HistoryController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource{
    
    @IBOutlet var collectionView: UICollectionView!
    
    var dataList = [VideoListingModel]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let dataManager = DataManager()
        
        dataManager.getData(pageName: PageConstants.HISTORY_PAGE, returndata: { result in
            self.dataList = result as! [VideoListingModel]
            print("Ganesh result : \(result.count)")
            print("Ganesh datalist : \(self.dataList.count)")
            self.collectionView.reloadData()
        })
 
        
        
        let dataM = DataManager()
        dataM.getData(pageName: PageConstants.LOGIN_PAGE, returndata: { result in
        
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
}
