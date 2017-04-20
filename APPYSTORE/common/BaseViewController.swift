//
//  BaseViewController.swift
//  APPYSTORE
//
//  Created by ios_dev on 29/03/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController, BaseViewControllerProtocol {
    private var pageName: String?
    private var pageNameUniqueIdentifier: String?
    
    internal func getPageName() -> String {
        assert(false, "This method must be overriden by the subclass")
    }
    
    internal func getPageNameUniqueIdentifier() -> String {
        assert(false, "This method must be overriden by the subclass")
    }

    var mainControllerCommunicator: MainControllerCommunicator?
    var bundle: AndroidBundle = nil
    
    override func viewDidLoad() {
        print("BaseViewController viewDidLoad called: " + getPageName())
        super.viewDidLoad()
    }
    
    // Called when the view is about to made visible. Default does nothing
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainControllerCommunicator?.setUIComponents(components: getComponentProperties())
        print("BaseViewController viewWillAppear called: " + getPageName())
    }
    
    // Called when the view has been fully transitioned onto the screen. Default does nothing
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear called")
        print("BaseViewController  viewDidAppear called: " + getPageName())
    }
    
    // Called just before the view controller's view's layoutSubviews method is invoked. Subclasses can implement as necessary. The default is a nop.
    override open func viewWillLayoutSubviews(){
        print("BaseViewController  viewWillLayoutSubviews called " + getPageName())
    }
    
    // Called just after the view controller's view's layoutSubviews method is invoked. Subclasses can implement as necessary. The default is a nop.
    override open func viewDidLayoutSubviews() {
        print("BaseViewController  viewDidLayoutSubviews called " + getPageName())
    }
    
    override func beginAppearanceTransition(_ isAppearing: Bool, animated: Bool) {
        print("BaseViewController  beginAppearanceTransition called " + getPageName())
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getComponentProperties() -> ComponentProperties?{
        return nil
    }
}
