
import UIKit

class MainController: UIViewController {
    
    @IBOutlet var topView: TopBarOverlay!
    @IBOutlet var middleView: UIView!
    @IBOutlet var bottomView: BottomBarOverlay!
    
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
