
import UIKit

class BaseController: UIViewController {

    
    @IBOutlet var topView: TopBarOverlay!
    
    @IBOutlet var middleView: UIView!
    
    @IBOutlet var bottomView: BottomBarOverlay!
   
    
    
    weak var currentViewController:UIViewController!

    lazy var historycontroller:HistoryController = {
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
    
        
    }
     func video()
     {
        print("Video Page")
       removeFromParentViewController()
       historycontroller.view.alpha = 0
       videocontroller.view.alpha = 1
       videocontroller.view.isHidden = false
        self.view.bringSubview(toFront: historycontroller.view)

     }
    func history()
     {
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
