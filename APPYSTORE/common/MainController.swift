
import UIKit

class MainController: UIViewController, MainControllerCommunicator {

    @IBOutlet var topView: TopBarOverlay!
    @IBOutlet var middleView: UIView!
    @IBOutlet var bottomView: BottomBarOverlay!
    @IBOutlet weak var imgFullBgView: UIImageView!
    
    var uiDelegate: MainControllerUIDelegate? = nil
    
    var childControllersList: [BaseViewController]? = []
    
    func getCurrentViewController() -> BaseViewController? {
        if childControllersList != nil && (childControllersList?.count)! > 0 {
            return (childControllersList?[(childControllersList?.count)! - 1])!
        }
        return nil
    }
    
    func getContext() -> MainController {
        return self
    }
    
    func addChild(controller: BaseViewController, area: Area?) {
        uiDelegate?.addChild(controller: controller, area: area)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("MainController viewDidLoad called")
        print("MainController vendor id : \(UIDevice.current.identifierForVendor?.uuidString)")
        AppConfigurationHandler().start()
        uiDelegate = MainControllerUIDelegate(mainController: self)
        AppNavigationHandler(mainControllerCommunicator: self).NavigateAtAppOpen()
        uiDelegate?.viewDidLoad()
    }
    
    // Called when the view is about to made visible. Default does nothing
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("MainController viewWillAppear called")
    }
    
    // Called when the view has been fully transitioned onto the screen. Default does nothing
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("MainController viewDidAppear called")
    }
    
    // Called just before the view controller's view's layoutSubviews method is invoked. Subclasses can implement as necessary. The default is a nop.
    override open func viewWillLayoutSubviews(){
        print("MainController viewWillLayoutSubviews called")
    }
    
    // Called just after the view controller's view's layoutSubviews method is invoked. Subclasses can implement as necessary. The default is a nop.
    override open func viewDidLayoutSubviews() {
        print("MainController viewDidLayoutSubviews called")
    }
    
    override func beginAppearanceTransition(_ isAppearing: Bool, animated: Bool) {
        print("MainController beginAppearanceTransition called")
    }
    
    func onBackPressed() {
        getCurrentViewController()?.view.isHidden = false
        getCurrentViewController()?.viewWillAppear(false)
    }
    
    func performBackButtonClick(_ controller: BaseViewController) {
        uiDelegate?.handleBackButtonClick(controller)
    }
    
    internal func setUIComponents(components: ComponentProperties?) {
        uiDelegate?.setUIComponents(components: components)
    }
    
    func showProgressBar() {
        uiDelegate?.showProgressBar()
    }
    
    func hideProgressBar() {
        uiDelegate?.hideProgressBar()
    }
    
    func refreshAllPages() {
        for childController in childControllersList! {
            childController.resetPage()
        }
    }
}
