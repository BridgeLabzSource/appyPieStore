
import UIKit

class MainController: UIViewController, MainControllerCommunicator {
    
    @IBOutlet var topView: TopBarOverlay!
    @IBOutlet var middleView: UIView!
    @IBOutlet var bottomView: BottomBarOverlay!
    
    var uiDelegate: MainControllerUIDelegate? = nil
    
    var childControllersList: [BaseViewController]? = []
    
    func getCurrentViewController() -> BaseViewController? {
        if childControllersList != nil && (childControllersList?.count)! > 0 {
            return (childControllersList?[(childControllersList?.count)! - 1])!
        }
        return nil
    }
    
    func addChild(controller: BaseViewController) {
        uiDelegate?.addChild(controller: controller)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiDelegate = MainControllerUIDelegate(mainController: self)
        uiDelegate?.viewDidLoad()
    }
    
    // Called when the view is about to made visible. Default does nothing
    override open func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear called")
    }
    
    // Called when the view has been fully transitioned onto the screen. Default does nothing
    override open func viewDidAppear(_ animated: Bool) {
        print("viewDidAppear called")
    }
    
    // Called just before the view controller's view's layoutSubviews method is invoked. Subclasses can implement as necessary. The default is a nop.
    override open func viewWillLayoutSubviews(){
        print("viewWillLayoutSubviews called")
    }
    
    // Called just after the view controller's view's layoutSubviews method is invoked. Subclasses can implement as necessary. The default is a nop.
    override open func viewDidLayoutSubviews() {
        print("viewDidLayoutSubviews called")
    }
    
    override func beginAppearanceTransition(_ isAppearing: Bool, animated: Bool) {
        print("beginAppearanceTransition called")
    }
    
    func onBackPressed() {
        getCurrentViewController()?.view.isHidden = false
        getCurrentViewController()?.viewWillAppear(false)
    }
    
    internal func setUIComponents(components: ComponentProperties?) {
        uiDelegate?.setUIComponents(components: components)
    }
    
}
