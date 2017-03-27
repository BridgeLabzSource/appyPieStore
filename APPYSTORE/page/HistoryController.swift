
import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage
import NVActivityIndicatorView
class HistoryController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate {
    
    @IBOutlet var collectionView: UICollectionView!
    
    var sw: CGFloat = 0.0
    var sh: CGFloat = 0.0
    var setLimit: Int = 20
    var dataList = [VideoListingModel]()
    var anim: NVActivityIndicatorView?
    var isRequestInProgress = false
    let dataFetchFramework = DataFetchFramework(pageName: PageConstants.HISTORY_PAGE)
    let paginationThreshold = 4
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //inital value for animator
        sw = self.collectionView.center.x
        sh = self.collectionView.center.y
        
        self.loadData()
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.delegate = self
        
    }
    
    func loadData() {
        isRequestInProgress = true
        let frame = CGRect(x: Int(sw-25), y: Int(sh/2), width: 30, height: 30)
        anim = NVActivityIndicatorView(frame: frame, type: NVActivityIndicatorType.ballPulse, color: UIColor.orange, padding: CGFloat(0))
        anim?.startAnimating()
        self.collectionView.addSubview(anim!)
        
        dataFetchFramework.onDataReceived = onDataReceived
        dataFetchFramework.start(dataSource: DataSource.BOTH)
    }
    
    func onDataReceived( status: String, result: AnyObject) {
        isRequestInProgress = false
        anim?.stopAnimating()
        anim?.removeFromSuperview()
        if status == DataFetchFramework.REQUEST_SUCCESS {
            if let result = result as? [BaseModel] {
                setLimit = result.count
                print("Ganesh Server Data : \(result)")
                self.dataList = result as! [VideoListingModel]
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
        return dataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "historycell", for: indexPath) as! HistoryVideoCell
        
        let image_path = dataList[indexPath.row].imagePath
        let imgurl = URL(string: image_path)
        
        cell2.mVideoImage.sd_setImage(with: imgurl, placeholderImage: #imageLiteral(resourceName: "profile") )
        cell2.mVideoDescription.text = dataList[indexPath.row].title
        
        return cell2
    }
    
    //function to get lastVisibleCell at particular indexPath
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index: Int = (self.collectionView.indexPath(for: self.collectionView.visibleCells.last!)?.row)!
        print("Ganesh : Last element = \(index)")
        
        if var lastVisibleCell = self.collectionView.indexPathsForVisibleItems.last {
            let lastVisibleCellCount = lastVisibleCell.row + paginationThreshold
            print("Ganesh : lastVisibleCellCount = \(lastVisibleCellCount) and setLimit = \(setLimit)")
            
            if lastVisibleCellCount  >= setLimit && !isRequestInProgress{
                
                sw = (scrollView.contentSize.width)
                sh = (scrollView.contentSize.height)
                loadData()
            }
            
        }
    }
    
}
