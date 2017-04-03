//
//  SearchController.swift
//  APPYSTORE
//
//  Created by BridgeLabz Solution LLP on 04/03/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit

class SearchController: BaseViewController {

    @IBOutlet var backButton: UIButton!
    
    @IBOutlet var searchButton: UIButton!
    
    @IBOutlet var searchTextfield: UITextField!
    
    @IBOutlet var customView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        setUIElementsLayout()
      
    }
    
    func setUIElementsLayout()
    {
        backButton.layer.cornerRadius = backButton.frame.width/2
        searchButton.layer.cornerRadius = searchButton.frame.width/2
        searchTextfield.layer.cornerRadius = 10
        view.layer.cornerRadius = 20.0
    }
    
    func goBack()
    {
        
    }

   

}
