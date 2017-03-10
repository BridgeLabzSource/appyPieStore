
import UIKit
import KCFloatingActionButton
class BaseViewController: UIViewController{
    //MARK:IBOutlet
    @IBOutlet var switchcontrol: UISegmentedControl!
    
    @IBOutlet var userButton: UIButton!
    
    @IBOutlet var videoButton: UIButton!
    
    @IBOutlet var songButton: UIButton!
    
    @IBOutlet var historyButton: UIButton!
    
    @IBOutlet var searchButton: UIButton!
    
    @IBOutlet var purchaseButton: UIButton!
    
    @IBOutlet var fabButton: UIButton!
    
    //MARK:variable declaration
    
    lazy var historycontroller:HistoryController = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "HistoryController") as! HistoryController
        
        self.addAsChildViewController(childView:viewController)
        
        return viewController
    }()
    
    lazy var searchcontroller:SearchController = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "SearchController") as! SearchController
        self.addAsChildSearchViewController(childView: viewController)
        
        return viewController
    }()
    
    //MARK: view did load
    override func viewDidLoad() {
        super.viewDidLoad()
        let fab = KCFloatingActionButton()
        fab.sticky = true
        fab.addItem(title: "Request call back")
        fab.addItem(title: "Chat")
        fab.addItem(title: "Share app")
        fab.addItem(title: "Parenting Videos")
        fab.addItem(title: "Profile")
        fab.openAnimationType = .slideLeft
        fabButton.addSubview(fab)
        self.view.bringSubview(toFront: fab)
        
        
        
        buttonsLayout()
        setupView()
    }
    
    func buttonsLayout()
    {
        userButton.layer.cornerRadius = userButton.bounds.width/2
        
        videoButton.layer.cornerRadius = videoButton.bounds.width/2
        songButton.layer.cornerRadius = songButton.bounds.width/2
        historyButton.layer.cornerRadius = historyButton.bounds.width/2
        searchButton.layer.cornerRadius = searchButton.bounds.width/2
        purchaseButton.layer.cornerRadius = purchaseButton.bounds.width/2
        fabButton.layer.cornerRadius = fabButton.bounds.width/2
        
    }
    
    func pressedFab()
    {
        
    }
    private func setupView(){
        segmentSetup()
        updateView()
    }
    
    private func updateView()
    {
        if switchcontrol.selectedSegmentIndex == 0
        {
            removeFromParentViewController()
            historycontroller.view.isHidden = true
        }
        else if switchcontrol.selectedSegmentIndex == 1
        {
          
            
            print("History")
            removeFromParentViewController()
            historycontroller.view.isHidden = false
            self.view.bringSubview(toFront: historycontroller.view)
        }
    }
    private func segmentSetup()
    {
        switchcontrol.addTarget(self, action: #selector(selectionDidChanged(sender:)), for: .valueChanged)
        
    }
    
    func selectionDidChanged(sender:UISegmentedControl)
    {
        updateView()
    }
    
    private func addAsChildViewController(childView:UIViewController){
        addChildViewController(childView)
        view.addSubview(childView.view)
        childView.view.backgroundColor = UIColor.clear
        childView.view.frame = CGRect(x: 0, y:self.view.frame.height/4, width: self.view.frame.width, height: 210)
        print(self.view.frame.height)
        childView.didMove(toParentViewController: childView)
    }
    
    private func addAsChildSearchViewController(childView:UIViewController)
    {
        addChildViewController(childView)
        view.addSubview(childView.view)
        childView.view.frame = self.view.frame
        childView.view.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        childView.didMove(toParentViewController: childView)
    }
    
    @IBAction func searchButtonAction(_ sender: Any)
    {
        removeFromParentViewController()
        historycontroller.view.isHidden = true
        searchcontroller.modalPresentationStyle = UIModalPresentationStyle.popover
        searchcontroller.popoverPresentationController?.sourceView = self.view
        self.view.bringSubview(toFront: searchcontroller.view)
        
    }
    
}
