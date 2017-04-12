//
//  BaseViewController.swift
//  APPYSTORE
//
//  Created by ios_dev on 29/03/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController, BaseViewControllerProtocol {

    internal func getPageName() -> String {
        assert(false, "This method must be overriden by the subclass")
    }
    
    internal func getPageNameUniqueIdentifier() -> String {
        assert(false, "This method must be overriden by the subclass")
    }

    var mainControllerCommunicator: MainControllerCommunicator?
    var bundle: AndroidBundle = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Called when the view is about to made visible. Default does nothing
    override open func viewWillAppear(_ animated: Bool) {
        mainControllerCommunicator?.setUIComponents(components: getComponentProperties()!)
        print("viewWillAppear called: " + getPageName())
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getComponentProperties() -> ComponentProperties?{
        return nil
    }
}
