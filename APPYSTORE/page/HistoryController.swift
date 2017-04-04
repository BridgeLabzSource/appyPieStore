
import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage
import NVActivityIndicatorView

class HistoryController: BaseListingViewController {
    override func viewDidLoad() {
        dataFetchFramework = DataFetchFramework(pageName: PageConstants.HISTORY_PAGE)
        super.viewDidLoad()
    }
}
