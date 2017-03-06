//
//  CustomButton.swift
//  APPYSTORE
//
//  Created by BridgeLabz on 01/03/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit

@IBDesignable class CustomButton: UIButton {
    
    let subLayercolorList = [
        ["#808080", "#666666"],
        ["#cccccc", "#b6b3b3"],
        ["#66ffffff", "#00ffffff"],
        ["#ffffff", "#66ffffff"],
        ]
    
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
        backgroundColor = .white
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
        
        
        /*let imageSubLayer = CALayer()
        let image = UIImage(named:"category_audio_media_type")?.cgImage
        //layer.frame = bounds
        imageSubLayer.contents = image
        //layer.insertSublayer(imageSubLayer, at: 0)
        layer.addSublayer(imageSubLayer)*/
    }
    
    func makeRoundCorner(layer: CALayer){
        layer.cornerRadius = min(layer.frame.size.height, layer.frame.size.width) / 2.0
        layer.masksToBounds = true
        layer.allowsEdgeAntialiasing = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
}
