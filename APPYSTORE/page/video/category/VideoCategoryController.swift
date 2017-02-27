//
//  ViewController.swift
//  APPYSTORE
//
//  Created by BridgeLabz on 21/02/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit

class VideoCategoryController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    //MARK: IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    //MARK: variables
    let image = ["ic_launcher", "ic_launcher", "ic_launcher", "ic_launcher", "ic_launcher", "ic_launcher"]
    
    var pointOfPixels: CGFloat!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        // getting point value of pixels
        pointOfPixels = DimentionManager.convertPixelToPoint(pixel: 64.0)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return image.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as!  CustomImageCell
        
        // setting cornerRadius of backgroundImage
        cell.mBgImage.layer.cornerRadius = self.pointOfPixels
        cell.mBgImage.clipsToBounds = true
        
        // setting cornerRadius of logoButton
        cell.mLogoBtn.layer.cornerRadius = self.pointOfPixels
        cell.mLogoBtn.clipsToBounds = true
        
        // setting cornerRadius of view
        cell.mMainView.layer.cornerRadius = self.pointOfPixels
        cell.mMainView.clipsToBounds = true
        
        // setting shadow of view
        cell.mMainView.layer.backgroundColor = UIColor.white.cgColor
        cell.mMainView.layer.masksToBounds = true
        cell.mMainView.layer.borderWidth = 10.0
        cell.mMainView.layer.borderColor = UIColor.white.cgColor
        cell.mMainView.layer.shadowOpacity = 0.7
        cell.mMainView.layer.shadowOffset = CGSize(width:0, height:3)
        cell.mMainView.layer.shadowRadius = 20.0
        
         //   cell.mainView.layer.masksToBounds = false
      //  cell.mainView.layer.shadowColor = UIColor.green.cgColor
     //   cell.mainView.layer.shadowOpacity = 1
     //   cell.mainView.layer.shadowOffset = CGSize.zero
      //  cell.mainView.layer.shadowRadius = 10
     //   cell.mainView.layer.shadowPath = UIBezierPath(rect: cell.mainView.bounds).cgPath
    //   cell.mainView.layer.shouldRasterize = true
        
        
   //     _ = createView(position: CGPoint(x: 40, y: 50), label: "bare", indexPath: indexPath)
        
  //      let plain = createView(position: CGPoint(x: 180, y: 50), label: "", indexPath: indexPath)
  //      applyPlainShadow(view: plain)
        
  //      let curved = createView(position: CGPoint(x: 40, y: 200), label: "curved", indexPath: indexPath)
  //      applyCurvedShadow(view: curved)
        
  //      let hover = createView(position: CGPoint(x: 180, y: 200), label: "hover", indexPath: indexPath)
   //     applyHoverShadow(view: hover)
        
//        cell.layer.shadowColor = UIColor.black.cgColor
//        cell.layer.shadowOffset = CGSize(width: 0, height: 10)
//        cell.layer.shadowOpacity = 0.4
//        cell.layer.shadowRadius = 5
//        cell.bgImage.image = UIImage(named: image[indexPath.row])
        return cell
    }
    
    func createView(position: CGPoint, label: String, indexPath: IndexPath) -> UIView {
        let imageView = UIImageView(image: UIImage(named: image[indexPath.row]))
        
        imageView.frame = CGRect(origin: position, size: CGSize(width: 100, height: 100))
        
        let labelView = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
        labelView.textAlignment = NSTextAlignment.center
        labelView.text = label
        labelView.textColor = UIColor.white
        imageView.addSubview(labelView)
        
        view!.addSubview(imageView);
        
        return imageView
    }
    
    func applyPlainShadow(view: UIView) {
        let layer = view.layer
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 10)
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 5
    }
    
    func applyCurvedShadow(view: UIView) {
        let size = view.bounds.size
        let width = size.width
        let height = size.height
        let depth = CGFloat(11.0)
        let lessDepth = 0.8 * depth
        let curvyness = CGFloat(5)
        let radius = CGFloat(1)
        
        let path = UIBezierPath()
        
        // top left
        path.move(to: CGPoint(x: radius, y: height))
        
        // top right
        path.addLine(to: CGPoint(x: width - 2*radius, y: height))
        
        // bottom right + a little extra
        path.addLine(to: CGPoint(x: width - 2*radius, y: height + depth))
        
        // path to bottom left via curve
        path.addCurve(to: CGPoint(x: radius, y: height + depth),
                             controlPoint1: CGPoint(x: width - curvyness, y: height + lessDepth - curvyness),
                             controlPoint2: CGPoint(x: curvyness, y: height + lessDepth - curvyness))
        
        let layer = view.layer
        layer.shadowPath = path.cgPath
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowRadius = radius
        layer.shadowOffset = CGSize(width: 0, height: -3)
    }
    
    func applyHoverShadow(view: UIView) {
        let size = view.bounds.size
        let width = size.width
        let height = size.height
        
        let ovalRect = CGRect(x: 5, y: height + 5, width: width - 10, height: 15)
        let path = UIBezierPath(roundedRect: ovalRect, cornerRadius: 10)
        
        let layer = view.layer
        layer.shadowPath = path.cgPath
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 5
        layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    
    //width = 48
    // height= 32
   
 }

