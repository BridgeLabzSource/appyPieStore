//
//  RecommendedVideoViewController.swift
//  APPYSTORE
//
//  Created by ios_dev on 12/04/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit

class RecommendedVideoViewController: BaseListingViewController {

    override func viewDidLoad() {
        dataFetchFramework = DataFetchFramework(pageName: PageConstants.RECOMMENDED_VIDEO_LISTING_PAGE, pageUniqueId: "20087824", bundle: bundle)
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
