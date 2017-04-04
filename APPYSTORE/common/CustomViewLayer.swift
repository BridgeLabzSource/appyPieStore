//
//  CustomViewLayer.swift
//  APPYSTORE
//
//  Created by ios_dev on 28/03/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import Foundation
import UIKit

enum LayerColorType {
    case RED
    case BLUE
    case GREEN
    case PURPLE
    case ORANGE
    case VIOLET
    case YELLOW
    case DEFAULT
}

class CustomViewLayer {
    let imageInset = UIEdgeInsetsMake(6, 6, 12, 12)
    
    var subLayercolorList = [
        ["#808080", "#666666"],
        ["#cccccc", "#b6b3b3"],
        ["#66ffffff", "#00ffffff"],
        ["#ffffff", "#66ffffff"],
        ]
    
    let redLayerColorList = [
        ["#964050", "#9d2e43"],
        ["#ff6b61", "#ff2e43"],
        ["#66ffffff", "#00ffffff"],
        ["#ffffff", "#66ffffff"],
    ]
    
    let blueLayerColorList = [
        ["#006aa7", "#0058a8"],
        ["#29c5e2", "#0071bc"],
        ["#66ffffff", "#00ffffff"],
        ["#ffffff", "#66ffffff"],
    ]
    
    let greenLayerColorList = [
        ["#00652f", "#007248"],
        ["#51cd5e", "#00a448"],
        ["#66ffffff", "#00ffffff"],
        ["#ffffff", "#66ffffff"],
    ]
    
    let orangeLayerColorList = [
        ["#e65f00", "#aa4024"],
        ["#f77d1e", "#f15a24"],
        ["#66ffffff", "#00ffffff"],
        ["#ffffff", "#66ffffff"],
    ]
    
    let violetLayerColorList = [
        ["#2939a7", "#1a4198"],
        ["#7763e2", "#1a4198"],
        ["#66ffffff", "#00ffffff"],
        ["#ffffff", "#66ffffff"],
        ]
    
    let yellowLayerColorList = [
        ["#cf5a3d", "#ce5900"],
        ["#f1a824", "#f78e1e"],
        ["#66ffffff", "#00ffffff"],
        ["#ffffff", "#66ffffff"],
        ]
    
    let purpleLayerColorList = [
        ["#c39eee", "#8c26f6"],
        ["#8715fe", "#7714bc"],
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
    
    func initialize(layer: CAShapeLayer, bounds: CGRect, layerColor: LayerColorType = .DEFAULT) {
        //the main layer
        switch layerColor {
        case .RED:
            subLayercolorList = redLayerColorList
        case .BLUE:
            subLayercolorList = blueLayerColorList
        case .GREEN:
            subLayercolorList = greenLayerColorList
        case .PURPLE:
            subLayercolorList = purpleLayerColorList
        case .ORANGE:
            subLayercolorList = orangeLayerColorList
        case .VIOLET:
            subLayercolorList = violetLayerColorList
        case .YELLOW:
            subLayercolorList = yellowLayerColorList
        default:
            break
        }
        
        makeRoundCorner(layer: layer)
        
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
            layer.frame = bounds
        }
        // for UIButton only
        //bringSubview(toFront: self.imageView!)
        //self.imageEdgeInsets = imageInset;
    }
    
    func makeRoundCorner(layer: CALayer){
        layer.cornerRadius = min(layer.frame.size.height, layer.frame.size.width) / 2.0
        layer.masksToBounds = true
        layer.allowsEdgeAntialiasing = true
    }
}
