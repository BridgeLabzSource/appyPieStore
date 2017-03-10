
import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage

class HistoryController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate{
    
    @IBOutlet var collectionView: UICollectionView!
    var setLimit:Int = 20
    var setOffset:Int = 0
    var dataList = [VideoListingModel]()
    let dataManager = DataManager()
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.loadData(offset: setOffset, limit: setLimit)
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.delegate = self
        
    }
    func loadData(offset:Int,limit:Int)
    {
        dataManager.getData(pageName: PageConstants.HISTORY_PAGE, offset: offset, limit: limit, returndata: { result in
            self.dataList = result as! [VideoListingModel]
            self.view.setNeedsDisplay()
            print("Data Found:",result.count)
            self.collectionView.reloadData()
            
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "historycell", for: indexPath) as! HistoryVideoCell
      
        let image_path = dataList[indexPath.row].imagePath
        let imgurl = URL(string: image_path)
        
       cell2.mVideoImage.sd_setImage(with:imgurl, placeholderImage:#imageLiteral(resourceName: "profile") )
       cell2.mVideoDescription.text = dataList[indexPath.row].title
      
        return cell2
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         let cell = collectionView.cellForItem(at: indexPath)
        UIView.animate(withDuration: 0.2, delay: 0.1, usingSpringWithDamping: 1, initialSpringVelocity: 0.1, options: [.allowAnimatedContent], animations: {
            cell?.transform = CGAffineTransform(scaleX: 1.03, y: 1.03)
        
        }, completion: { finish in
            UIView.animate(withDuration: 0.2, delay: 0.1, usingSpringWithDamping: 0.1, initialSpringVelocity: 0.1, options: [.transitionFlipFromRight], animations: {
                 cell?.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: { finish in
                
            
            })
        
        
        })
         
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if var lastVisibleCell = self.collectionView.indexPathsForVisibleItems.last
        {
            let lastVisibleCellCount = lastVisibleCell.row + 1
            if lastVisibleCellCount == setLimit
            {
                setLimit = setLimit + 20
                loadData(offset: setOffset, limit: setLimit)
                viewWillAppear(true)
            }
        }
    }
   }
