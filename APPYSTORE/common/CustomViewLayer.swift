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
    
    var subLayercolorList = LayerColor.getLayerColor(colorName: "grey")
    
    let redLayerColorList = LayerColor.getLayerColor(colorName: "red")
    
    let blueLayerColorList = LayerColor.getLayerColor(colorName: "blue")
    
    let greenLayerColorList = LayerColor.getLayerColor(colorName: "green")
    
    let orangeLayerColorList = LayerColor.getLayerColor(colorName: "orange")
    
    let violetLayerColorList = LayerColor.getLayerColor(colorName: "violet")
    
    let yellowLayerColorList = LayerColor.getLayerColor(colorName: "yellow")
    
    let purpleLayerColorList = LayerColor.getLayerColor(colorName: "purple")
    
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
