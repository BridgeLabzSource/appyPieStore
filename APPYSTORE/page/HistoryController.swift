
import UIKit

class HistoryController: BaseListingViewController {
    
    override internal func getPageName() -> String {
        return PageConstants.HISTORY_PAGE
    }
    
    override func viewDidLoad() {
        let bundle1 = [String: Any]()
        print("HistoryController viewDidLoad")
        dataFetchFramework = DataFetchFramework(pageName: getPageName(), pageUniqueId: "",  bundle: bundle1)
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("HistoryController viewWillAppear")
        super.viewWillAppear(false)
        
        if (Prefs.getInstance()?.isHistoryPageToBeForceRefreshed())! && Utils.isInternetAvailable() {
            Prefs.getInstance()?.setHistoryPageToBeForceRefreshed(forceRefresh: false)
            resetPage()
        }
    }
    
    override func resetPage() {
        super.resetPage()
        dataFetchFramework?.reset()
        dataFetchFramework?.start(dataSource: getDataSource())
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("HistoryController viewDidAppear")
        super.viewDidAppear(animated)
    }
    
    override func getComponentProperties() -> ComponentProperties {
        let components = ComponentProperties()
        components.visibleIconsSet = [Item.IV_CHILD, Item.BTN_VIDEO, Item.BTN_AUDIO, Item.BTN_HISTORY , Item.BTN_SEARCH]
        
        return components
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let videoListingModel = dataFetchFramework?.contentList[indexPath.row] as! VideoListingModel
        print("HistoryController : select video \(videoListingModel.title)")
        
        if !AuthenticationUtil.isSubscribedUser() && videoListingModel.payType == "paid" {
            if UserInfo.getInstance().isDeviceEligibleForTrialSubscription {
                NavigationManager.openTrialPopUp(mainControllerCommunicator: mainControllerCommunicator!)
            }
            
        } else {
            NavigationManager.openVideoPlayerPage(mainControllerCommunicator: mainControllerCommunicator!, model: videoListingModel)
        }
    }
}
