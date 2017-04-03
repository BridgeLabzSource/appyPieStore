
import UIKit

class MainController: UIViewController, MainControllerCommunicator {
    
    @IBOutlet var topView: TopBarOverlay!
    @IBOutlet var middleView: UIView!
    @IBOutlet var bottomView: BottomBarOverlay!
    
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
