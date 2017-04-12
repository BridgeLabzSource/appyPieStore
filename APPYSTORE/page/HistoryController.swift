
import UIKit

class HistoryController: BaseListingViewController {
    
    override internal func getPageName() -> String {
        return PageConstants.HISTORY_PAGE
    }
    
    override func viewDidLoad() {
        dataFetchFramework = DataFetchFramework(pageName: getPageName(), pageUniqueId: "",  bundle: bundle)
        super.viewDidLoad()
    }
    
    override func getComponentProperties() -> ComponentProperties {
        let components = ComponentProperties()
        components.visibleIconsSet = [Item.IV_CHILD, Item.BTN_VIDEO, Item.BTN_AUDIO, Item.BTN_HISTORY , Item.BTN_SEARCH]
        
        return components
    }
}
