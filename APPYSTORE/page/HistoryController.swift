//
//  HistoryController.swift
//  APPYSTORE
//
//  Created by BridgeLabz Solution LLP on 25/02/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class HistoryController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    //MARK:IBOutlet
    
    @IBOutlet var collectionView: UICollectionView!
    //MARK:declaration
    let photo = [#imageLiteral(resourceName: "cartton2"),#imageLiteral(resourceName: "cartton2"),#imageLiteral(resourceName: "cartton2"),#imageLiteral(resourceName: "cartton2"),#imageLiteral(resourceName: "cartton2"),#imageLiteral(resourceName: "cartton2")]
    let name = ["Funny Videos","Litle Champs videos","Funny Videos","Litle Champs videos","Funny Videos","Litle Champs videos"]
    var cellSize = CGSize()
    //======
    let X_APPY_IMEI = "X_APPY_IMEI"
    let X_APPY_PCP_ID = "X_APPY_PCP_ID"
    let X_APPY_CAMPAIGN_ID = "X_APPY_CAMPAIGN_ID"
    let X_APPY_UserAgent = "X_APPY_UserAgent"
    let X_APPY_USERID = "X_APPY_USERID"
    let X_APPY_UTYPE = "X_APPY_UTYPE"
    let X_APPY_DEVICE_WIDTH = "X_APPY_DEVICE_WIDTH"
    let X_APPY_DEVICE_HEIGHT = "X_APPY_DEVICE_HEIGHT"
    let X_APPY_ANDROID_ID = "X_APPY_ANDROID_ID"
    let X_APPY_API_KEY = "X_APPY_API_KEY"
    let X_APPY_CHILD_ID = "X_APPY_CHILD_ID"
    let ACCEPT = "Accept"
    let ACCEPT_ENCODING = "Accept-Encoding"
    let ACCEPT_LANGUAGE = "Accept-Language"
    let X_APPY_CONN_TYPE = "X_APPY_CONN_TYPE"
    let X_APPY_TINFO = "X_APPY_TINFO"
    let X_APPY_VISITOR_ID = "X_APPY_VISITOR_ID"
    let X_APPY_OST = "X_APPY_OST"
    let X_APPY_USV = "X_APPY_USV"
    let X_APPY_REG_KEY = "X_APPY_REG_KEY"
    let X_APPY_VERSION = "X_APPY_VERSION"
    let X_APPY_VERSION_NAME = "X_APPY_VERSION_NAME"
    let X_APPY_TTR = "X_APPY_TTR"
    let X_APPY_SESSION_ID = "X_APPY_SESSION_ID"
    let X_APPY_APP_TYPE = "X_APPY_APP_TYPE"
    let APPY_LITE = "lite"
    let X_APPY_IS_NEW_USER = "X_APPY_IS_NEW_USER"
    let X_APPY_MSISDN = "X_APPY_MSISDN"
    let X_APPY_SUB_KEY = "X_APPY_SUB_KEY"
    let X_APPY_OS = "X_APPY_OS"
    let X_APPY_OS_VERSION = "X_APPY_OS_VERSION"
    let X_APPY_GOOGLE_CAMPAIGN_ID = "X_APPY_GOOGLE_CAMPAIGN_ID"
    let X_APPY_IS_UPGRADED = "X_APPY_IS_UPGRADED"
    let X_APPY_IS_VERSION_UPGRADE = "X_APPY_IS_VERSION_UPGRADE"
    let X_APPY_IS_GOOGLE_BOT = "X_APPY_IS_GOOGLE_BOT"
    let X_APPY_UTM_SOURCE = "X_APPY_UTM_SOURCE"
    let X_APPY_UTM_MEDIUM = "X_APPY_UTM_MEDIUM"
    let X_APPY_SCREEN_NAME = "X_APPY_SCREEN_NAME"
    
    let X_APPY_LAST_PAGE_NAME = "X_APPY_LAST_PAGE_NAME"
    let X_APPY_INLINE_PLAY = "X_APPY_INLINE_PLAY"
    
    
    
    let url4 = "https://api.spotify.com/v1/search?q=tania%20bowra&type=artist"
    let url2 = "http://api.androidhive.info/contacts/"
    let url3 = "https://github.com/rahulmandalkar431/Mandalkar/blob/master/myipl.json"
    let url = "https://api.spotify.com/v1/tracks/3n3Ppam7vgaVa1iaRUc9Lp"
    
    let urlstr = "http://www.appystore.in/appy_app/appyApi_handler.php?method=getAllHistory&child_id=29518&page_id=History&offset=0&limit=20"
    let url123 = "http://www.appystore.in/appy_app/appyApi_handler.php?"
  
    
    //parameter dictionary

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.collectionView.delegate = self
        getHistoryData()
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return name.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "historycell", for: indexPath) as! HistoryVideoCell
//        cell.layer.bounds.size.height = 200
//        cell.layer.bounds.size.width = 200
//        
//        
//        cell.layer.bounds.size.width = 200
//        
//        cell.layer.bounds.size.height = 200
//        cell.layer.bounds.size.width = 200
        
        cell.layer.cornerRadius = 35.0
        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.borderWidth = 15.0
        cell.layer.masksToBounds = false
        
        //---net
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 7, height:10)
        cell.layer.shadowOpacity = 0.3;
        cell.layer.shadowRadius = 1.0;
                //set data to cells
        cell.mVideoImage.image = photo[indexPath.row]
        cell.mVideoDescription.text = name[indexPath.row]
      
        return cell
    }
    // get data from server
    func getHistoryData()
    {
        Alamofire.request(url123, parameters:getParameter(),headers:getHeader()).responseJSON{ (response) in
            do
            {
             let json = JSON(response.result.value as! NSDictionary)
             print("\(json["Responsedetails"])")
            
               

            }
            
        }
        
    }
    //parameter
    func getParameter() -> Parameters
    {
        let param1 = ["method":"getAllHistory",
                      "child_id":"29518",
                      "page_id":"History",
                      "offset":"0",
                      "limit":"20"]
        return param1
    }
    //header
    func getHeader() -> HTTPHeaders
    {
        let headers:HTTPHeaders = ["Content-Type":"application/x-www-from-urlencoded",
                                   X_APPY_IMEI:"862188036890804",
                                   X_APPY_PCP_ID:"999",
                                   X_APPY_CAMPAIGN_ID:"8700441600",
                                   X_APPY_USERID:"107105246",
                                   X_APPY_UTYPE:"O",
                                   X_APPY_UserAgent:"Mozilla/5.0 (Linux; Android 5.0.2; Panasonic ELUGA Switch Build/LRX22G; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/56.0.2924.87 Mobile Safari/537.36",
                                   X_APPY_DEVICE_WIDTH:"1080",
                                   X_APPY_DEVICE_HEIGHT:"1920",
                                   X_APPY_ANDROID_ID:"13cfcb08de0d2e84",
                                   X_APPY_API_KEY:"gh610rt23eqwpll",
                                   X_APPY_CHILD_ID:"29518",
                                   ACCEPT:"text/html,application/xhtml+xml,application/xml;q=0.9,*;q=0.8",
                                   ACCEPT_ENCODING:"",
                                   ACCEPT_LANGUAGE:"en-US,en;q=0.5",
                                   X_APPY_CONN_TYPE:"w",
                                   X_APPY_TINFO:"",
                                   X_APPY_VISITOR_ID:"13cfcb08de0d2e84",
                                   X_APPY_OST:"",
                                   X_APPY_USV:"",
                                   X_APPY_REG_KEY:"abcd",
                                   X_APPY_VERSION:"11",
                                   X_APPY_VERSION_NAME:"1.0.7xx",
                                   X_APPY_TTR:"10800000",
                                   X_APPY_SESSION_ID:"abcd",
                                   X_APPY_APP_TYPE:"lite",
                                   
                                   X_APPY_IS_NEW_USER:"N",
                                   X_APPY_MSISDN:"",
                                   X_APPY_SUB_KEY:"",
                                   X_APPY_OS:"ios",
                                   X_APPY_OS_VERSION:"1.0",
                                   X_APPY_GOOGLE_CAMPAIGN_ID:"8700441600",
                                   X_APPY_IS_UPGRADED:"false",
                                   X_APPY_IS_VERSION_UPGRADE:"false",
                                   X_APPY_IS_GOOGLE_BOT:"false",
                                   X_APPY_UTM_SOURCE:"abcd",
                                   X_APPY_UTM_MEDIUM:"abcd",
                                   X_APPY_SCREEN_NAME:"",
                                   ]
        return headers
    }
    

    
    


}
