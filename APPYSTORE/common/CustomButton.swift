//
//  CustomButton.swift
//  APPYSTORE
//
//  Created by BridgeLabz on 01/03/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit

@IBDesignable class CustomButton: UIButton {
    
    let imageInset = UIEdgeInsetsMake(6, 6, 12, 12)
    var buttonImageView: UIImageView?
    @IBInspectable var buttonImage: UIImage?
    @IBInspectable var buttonColor: String?
    
    var subLayercolorList = [[String]]()
    
    //Note: try to keep even numbers only otherwise leyers won't be complete round
    let subLayerSizeTruncation: [CGFloat] = [
        2,
        6,
        18,
        24
    ]
    
    let subLayerInset: [CGFloat] = [
        2,
        3,
        5,
        2
    ]
    
    func initialize() {
        //the main layer
        subLayercolorList = LayerColor.getLayerColor(colorName: buttonColor)
        self.layer.backgroundColor = UIColor.white.cgColor
        makeRoundCorner(layer: self.layer)
        
        //add sub layers
        for i in 0...subLayercolorList.count - 1 {
            let gradient : CAGradientLayer = CAGradientLayer()
            
            let arrayColors = [UIColor.init(hex: subLayercolorList[i][0]).cgColor, UIColor.init(hex: subLayercolorList[i][1]).cgColor]
            gradient.colors = arrayColors
            
            
            if(i == 3) {
                //the white glossy dot effect
                let cornerToPerimeterDist = layer.frame.size.width / 2 * (sqrt(2) - 1)
                
                gradient.frame = bounds.insetBy(dx: cornerToPerimeterDist, dy: cornerToPerimeterDist)
                gradient.frame.size = CGSize(width:10.0, height:10.0)
                
            } else {
                gradient.frame = bounds.insetBy(dx: subLayerInset[i], dy: subLayerInset[i])
                gradient.frame.size = CGSize(width:gradient.frame.size.width - subLayerSizeTruncation[i], height:gradient.frame.size.height - subLayerSizeTruncation[i])
            }
            
            makeRoundCorner(layer: gradient)
            
            layer.insertSublayer(gradient as CALayer, at: UInt32(i))
        }
        
        bringSubview(toFront: self.imageView!)
        //self.imageEdgeInsets = imageInset;
        
        imageView?.frame = CGRect(
            x: 0,
            y: 0,
            width: DimensionManager.getGeneralizedHeight1280x720(height: 20),
            height: DimensionManager.getGeneralizedHeight1280x720(height: 20)
        )
        
        buttonImageView?.removeFromSuperview()
        
        
        buttonImageView = UIImageView(image: buttonImage)
        
        
        buttonImageView?.frame = CGRect(
            x: layer.frame.origin.x ,
            y: layer.frame.origin.y ,
            width: DimensionManager.getGeneralizedHeight1280x720(height: 60),
            height: DimensionManager.getGeneralizedHeight1280x720(height: 60)
        )
        
        buttonImageView?.center = CGPoint(x: layer.frame.size.width/2 - 5, y: layer.frame.height/2 - 5)
        
        addSubview(buttonImageView!)
        //self.imageView?.center = CGPoint(x: self.frame.size.width/2 - 5, y: self.frame.height/2 - 5)
        
        DimensionManager.setTextSize1280x720(label: self.titleLabel!, size: DimensionManager.H3)
    }
    
    func makeRoundCorner(layer: CALayer){
        layer.cornerRadius = min(layer.frame.size.height, layer.frame.size.width) / 2.0
        layer.masksToBounds = true
        layer.allowsEdgeAntialiasing = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //initialize()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        initialize()
    }
}
