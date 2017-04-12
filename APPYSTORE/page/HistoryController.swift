
import UIKit

class HistoryController: BaseListingViewController {
    override func viewDidLoad() {
        dataFetchFramework = DataFetchFramework(pageName: PageConstants.HISTORY_PAGE, pageUniqueId: "",  bundle: nil)
        super.viewDidLoad()
    }
}
