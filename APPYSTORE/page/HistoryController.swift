
import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage
import NVActivityIndicatorView
class HistoryController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate{
    
    @IBOutlet var collectionView: UICollectionView!
 
    var sw:CGFloat = 0.0
    var sh:CGFloat = 0.0
    var setLimit:Int = 20
    var setOffset:Int = 0
    var dataList = [VideoListingModel]()
    let dataManager = DataManager()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.collectionView.register(UINib(nibName: "VideoListingCard", bundle: nil), forCellWithReuseIdentifier: "VideoListingCard")
        //inital value for animator
        sw = self.collectionView.center.x
        sh = self.collectionView.center.y
     
        //
        self.loadData(offset: setOffset, limit: setLimit)
        
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.delegate = self
        
    }
   
    
        func loadData(offset:Int,limit:Int)
    {
        let frame = CGRect(x: Int(sw-25), y: Int(sh/2), width: 30, height: 30)
        let anim = NVActivityIndicatorView(frame: frame, type: NVActivityIndicatorType.ballPulse, color: UIColor.orange, padding: CGFloat(0))
        anim.startAnimating()
        self.collectionView.addSubview(anim)
        dataManager.getData(pageName: PageConstants.HISTORY_PAGE, offset: offset, limit: limit, returndata: { result in
            self.dataList = result as! [VideoListingModel]
            self.view.setNeedsDisplay()
            print("Data Found:",result.count)
            self.collectionView.reloadData()
            anim.stopAnimating()
            anim.removeFromSuperview()
           
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoListingCard", for: indexPath) as! VideoListingCard
      
        let image_path = dataList[indexPath.row].imagePath
        let imgurl = URL(string: image_path)
        
       cell2.imgThumbnail.sd_setImage(with:imgurl, placeholderImage:#imageLiteral(resourceName: "profile") )
       cell2.lblTitle.text = dataList[indexPath.row].title
      
        return cell2
    }
    
    //function to get lastVisibleCell at particular indexPath
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)
    {
        
      
        if var lastVisibleCell = self.collectionView.indexPathsForVisibleItems.last
        {
            let lastVisibleCellCount = lastVisibleCell.row + 1
            if lastVisibleCellCount == setLimit && setLimit <= total_history_count!
            {
                setLimit = setLimit + 20
                sw = (scrollView.contentSize.width)
                sh = (scrollView.contentSize.height)
                loadData(offset: setOffset, limit: setLimit)
            }
        
        }
    

    }
}
