
import UIKit

class MainController: UIViewController {
    
    @IBOutlet var topView: TopBarOverlay!
    @IBOutlet var middleView: UIView!
    @IBOutlet var bottomView: BottomBarOverlay!
    var fabButton: KCFloatingActionButton!
    
    weak var currentViewController: UIViewController!
    
    lazy var historyController: HistoryController = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "HistoryController") as! HistoryController
        
        self.addAsChildViewController(childView: viewController)
        
        return viewController
    }()
    
    
    lazy var videoController: VideoCategoryController = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "VideoCategoryController") as! VideoCategoryController
        
        self.addAsChildViewController(childView: viewController)
        
        return viewController
    }()
    
    override func viewDidLoad() {
        topView.translatesAutoresizingMaskIntoConstraints = false
        middleView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        
        topView.videoButton.addTarget(self, action: #selector(showVideoCategoryPage), for: .touchUpInside)
        topView.historyButton.addTarget(self, action: #selector(showHistoryPage), for: .touchUpInside)
        super.viewDidLoad()
        
        fabButton = KCFloatingActionButton()
        fabButton.buttonImage = UIImage(named: "fab_settings")
        fabButton.size = DimensionManager.getGeneralizedWidth1280x720(width: 104)
        fabButton.paddingX = DimensionManager.getGeneralizedWidth1280x720(width: 32)
        fabButton.paddingY = DimensionManager.getGeneralizedWidth1280x720(width: 32)
        makeFab()
    }
    
    func makeFab() {
        fabButton.addItem("Parenting Videos", icon: UIImage(named: "video_type_2"))
        fabButton.addItem("Profile", icon: UIImage(named: "profile"))
        fabButton.addItem("Share App", icon: UIImage(named: "share"))
        fabButton.addItem("Write to us", icon: UIImage(named: "edit"))
        fabButton.addItem("Chat", icon: UIImage(named: "icon_chat"))
        fabButton.addItem("Request Callback", icon: UIImage(named: "icon_rcb"))
        
        view.addSubview(fabButton)
    }
    
    func showVideoCategoryPage() {
        removeFromParentViewController()
        historyController.view.alpha = 0
        videoController.view.alpha = 1
        videoController.view.isHidden = false
        self.view.bringSubview(toFront: historyController.view)
        
    }
    
    func showHistoryPage() {
        removeFromParentViewController()
        videoController.view.alpha = 0
        historyController.view.alpha = 1
        historyController.view.isHidden = false
        self.view.bringSubview(toFront: historyController.view)
    }
    
    private func addAsChildViewController(childView:UIViewController){
        addChildViewController(childView)
        view.addSubview(childView.view)
        childView.view.backgroundColor = UIColor.clear
        childView.view.frame = middleView.frame
        //print(self.middleView.frame.origin.y)
        childView.didMove(toParentViewController: childView)
    }
    
}
