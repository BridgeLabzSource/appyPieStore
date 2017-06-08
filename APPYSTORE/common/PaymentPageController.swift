//
//  PaymentPageController.swift
//  APPYSTORE
//
//  Created by ios_dev on 18/04/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit
import WebKit

class PaymentPageController: UIViewController, WKScriptMessageHandler {
    var webview: WKWebView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let url = URL(string: "http://www.appystore.in/paymentapp/web")
        
        let request = URLRequest(url: url!)
        let configuration = WKWebViewConfiguration()
        configuration.userContentController.add(self, name: "onRCBPopupClosed")
        webview = WKWebView(frame: self.view.frame, configuration: configuration)
        webview?.load(request)
        
        self.view.addSubview(webview!)
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print("Message name : \(message.name) \n")
        print("Message body : \(message.body) \n")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
