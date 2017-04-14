
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
    
    func getC1() -> ChildInfo {
        let c1 = ChildInfo()
        c1.age = "2"
        c1.avatarId = "1"
        c1.avatarImage = "http://m1.appystore.in/appy_app/images/Boy1_col.png"
        c1.dob = "2015-03-07"
        c1.id = "122966"
        c1.type = ""
        c1.name = "one"
        c1.month = "1"
        c1.isInValidData = false
        
        return c1
    }
    
    func getC2() -> ChildInfo {
        let c2 = ChildInfo()
        c2.age = "5"
        c2.avatarId = "5"
        c2.avatarImage = "http://m1.appystore.in/appy_app/images/girl1_col.png"
        c2.dob = "2012-04-07"
        c2.id = "122967"
        c2.type = ""
        c2.name = "two"
        c2.month = "0"
        c2.isInValidData = false
        
        return c2
    }
    
    func setUserInfo(){
        let user = UserInfo.getInstance()
        
        user.childList?.append(getC1())
        user.childList?.append(getC2())
        
        user.email = "neeluverma2020@gmail.com"
        user.id = "290903782"
        user.usv = ""
        user.type = "O"
        user.ttr = nil
        user.trialMsgPrice = "330"
        user.isLoggedIn = false
        user.tInfo = ""
        user.smmKey = ""
        user.sessionId = nil
        user.selectedChild = nil
        user.preChatFormField = nil
        user.numWorksheet = "75"
        user.numOfDaysTrial = "15"
        user.msisdn = ""
        user.isVersionUpgraded = false
        user.isUpgraded = false
        user.isUnsubscribed = false
        user.isTrialSubscribed = false
        user.isTrialExpired = false
        user.isSubscribed = false
        user.isPaidExpired = false
        user.isPaidExpired = false
        user.isNewUser = true
        user.isInvalidData = false
        user.isGuestUser = false
        user.isDeviceEligibleForTrialSubscription = false
        user.isAddressUpdated = false
        user.childCount = 2
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
        getCurrentViewController()?.viewWillAppear(false)
    }
    
    internal func setUIComponents(components: ComponentProperties) {
        uiDelegate?.setUIComponents(components: components)
    }
    
}
