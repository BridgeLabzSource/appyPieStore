
import UIKit

class BaseController: UIViewController {
    
    @IBOutlet var topView: TopBarOverlay!
    @IBOutlet var middleView: UIView!
    @IBOutlet var bottomView: BottomBarOverlay!
    var fabButton: KCFloatingActionButton!
    
    weak var currentViewController: UIViewController!
    
    lazy var historycontroller: HistoryController = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "HistoryController") as! HistoryController
        
        self.addAsChildViewController(childView:viewController)
        
        return viewController
    }()
    
    
    lazy var videocontroller:VideoCategoryController = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "VideoCategoryController") as! VideoCategoryController
        
        self.addAsChildViewController(childView:viewController)
        
        return viewController
    }()
    
    override func viewDidLoad() {
        topView.translatesAutoresizingMaskIntoConstraints = false
        middleView.translatesAutoresizingMaskIntoConstraints = false
        
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        
        topView.videoButton.addTarget(self, action: #selector(video), for: .touchUpInside)
        topView.historyButton.addTarget(self, action: #selector(history), for: .touchUpInside)
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
    
    func video() {
        print("Video Page")
        removeFromParentViewController()
        historycontroller.view.alpha = 0
        videocontroller.view.alpha = 1
        videocontroller.view.isHidden = false
        self.view.bringSubview(toFront: historycontroller.view)
        
    }
    
    func history() {
        print("History Page")
        removeFromParentViewController()
        videocontroller.view.alpha = 0
        historycontroller.view.alpha = 1
        historycontroller.view.isHidden = false
        self.view.bringSubview(toFront: historycontroller.view)
    }
    
    private func addAsChildViewController(childView:UIViewController){
        addChildViewController(childView)
        view.addSubview(childView.view)
        childView.view.backgroundColor = UIColor.clear
        childView.view.frame = middleView.frame
        print(self.middleView.frame.origin.y)
        childView.didMove(toParentViewController: childView)
    }
    
}
