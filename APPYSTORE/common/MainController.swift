
import UIKit

class MainController: UIViewController, MainControllerCommunicator {
    
    @IBOutlet var topView: TopBarOverlay!
    @IBOutlet var middleView: UIView!
    @IBOutlet var bottomView: BottomBarOverlay!
    var fabButton: KCFloatingActionButton!
    
    weak var currentViewController: UIViewController!
    
    func addChild(controller: BaseViewController) {
        removeChildController(childController: currentViewController)
        addAsChildViewController(childController: controller)
        currentViewController = controller
    }
    
    lazy var historyController: HistoryController = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "HistoryController") as! HistoryController
        
        self.addAsChildViewController(childController: viewController)
        return viewController
    }()
    
    lazy var videoCategoryController: VideoCategoryController = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "VideoCategoryController") as! VideoCategoryController
        
        self.addAsChildViewController(childController: viewController)
        return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topView.translatesAutoresizingMaskIntoConstraints = false
        middleView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        
        topView.videoButton.addTarget(self, action: #selector(showVideoCategoryPage), for: .touchUpInside)
        topView.historyButton.addTarget(self, action: #selector(showHistoryPage), for: .touchUpInside)

        super.viewDidLoad()
        
        fabButton = KCFloatingActionButton()
        fabButton.buttonImage = UIImage(named: "fab_settings")
        fabButton.size = DimensionManager.getGeneralizedHeight1280x720(height: 104)
        fabButton.paddingX = DimensionManager.getGeneralizedWidth1280x720(width: 32)
        fabButton.paddingY = DimensionManager.getGeneralizedHeight1280x720(height: 32)
        makeFab()
    }
    
    func makeFab() {
        let f1 = fabButton.addItem("Parenting Videos", icon: UIImage(named: "video_type_2"))
        f1.size = DimensionManager.getGeneralizedWidth1280x720(width: 104)
        f1.layerColor = .RED
        
        let f2 = fabButton.addItem("Profile", icon: UIImage(named: "profile"))
        f2.layerColor = .BLUE
        f2.size = DimensionManager.getGeneralizedWidth1280x720(width: 104)
        
        let f3 = fabButton.addItem("Share App", icon: UIImage(named: "share"))
        f3.layerColor = .GREEN
        f3.size = DimensionManager.getGeneralizedWidth1280x720(width: 104)
        
        let f4 = fabButton.addItem("Write to us", icon: UIImage(named: "edit"))
        f4.layerColor = .VIOLET
        f4.size = DimensionManager.getGeneralizedWidth1280x720(width: 104)
        
        let f5 = fabButton.addItem("Chat", icon: UIImage(named: "icon_chat"))
        f5.layerColor = .PURPLE
        f5.size = DimensionManager.getGeneralizedWidth1280x720(width: 104)
        
        /*
         let f6 = fabButton.addItem("Request Callback", icon: UIImage(named: "icon_rcb"))
         f6.layerColor = .ORANGE
         f6.size = DimensionManager.getGeneralizedWidth1280x720(width: 104)
         */
        view.addSubview(fabButton)
    }
    
    func showVideoCategoryPage() {
        removeChildController(childController: currentViewController)
        videoCategoryController.view.isHidden = false
        currentViewController = videoCategoryController
    }
    
    func showHistoryPage() {
        removeChildController(childController: currentViewController)
        historyController.view.isHidden = false
        currentViewController = historyController
    }
    
    private func addAsChildViewController(childController: BaseViewController){
        self.addChildViewController(childController)
        self.view.addSubview(childController.view)
        childController.view.frame = middleView.frame
        //childController.view.backgroundColor = UIColor.clear
        //self.view.bringSubview(toFront: childController.view)
        childController.didMove(toParentViewController: childController)
        
        childController.mainControllerCommunicator = self
    }
    
    func removeChildController(childController: UIViewController?) {
        if  childController != nil {
            if childController is VideoCategoryController || childController is HistoryController{
                childController?.view.isHidden = true
            } else {
                childController?.willMove(toParentViewController: nil)
                childController?.view.removeFromSuperview()
                childController?.removeFromParentViewController()
            }
        }
    }
    
}
