
import UIKit

class BaseController: UIViewController,KCFloatingActionButtonDelegate {
    
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
    
    func KCFABOpened(_ fab: KCFloatingActionButton) {
        //fab.layer.isHidden = true
        //fab.layer.opacity = 0
        //fab.frame.origin.y += DimensionManager.getGeneralizedHeight1280x720(height: 104) + DimensionManager.getGeneralizedHeight1280x720(height: 32)
    }
    
    func KCFABClosed(_ fab: KCFloatingActionButton) {
        //fab.layer.isHidden = false
        //fab.layer.opacity = 1
        //fab.frame.origin.y -= DimensionManager.getGeneralizedHeight1280x720(height: 104) + DimensionManager.getGeneralizedHeight1280x720(height: 32)
    }
    override func viewDidLoad() {
        topView.translatesAutoresizingMaskIntoConstraints = false
        middleView.translatesAutoresizingMaskIntoConstraints = false
        
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        
        topView.videoButton.addTarget(self, action: #selector(video), for: .touchUpInside)
        topView.historyButton.addTarget(self, action: #selector(history), for: .touchUpInside)
        super.viewDidLoad()
        
        fabButton = KCFloatingActionButton()
        fabButton.fabDelegate = self
        fabButton.buttonImage = UIImage(named: "fab_settings")
        fabButton.size = DimensionManager.getGeneralizedHeight1280x720(height: 104)
        fabButton.paddingX = DimensionManager.getGeneralizedWidth1280x720(width: 32)
        fabButton.paddingY = DimensionManager.getGeneralizedWidth1280x720(width: 32)
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
