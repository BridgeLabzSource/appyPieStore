//
//  LayerColor.swift
//  APPYSTORE
//
//  Created by ios_dev on 21/04/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import Foundation


class LayerColor {
    
    static func getLayerColor(colorName: String?) -> [[String]] {
        var subLayercolorList: [[String]] = []
        let color = colorName ?? "grey"
        switch color {
            case "grey":
                subLayercolorList = [
                    ["#808080", "#666666"],
                    ["#cccccc", "#b6b3b3"],
                    ["#66ffffff", "#00ffffff"],
                    ["#ffffff", "#66ffffff"]
                ]
            case "red":
                subLayercolorList = [
                    ["#964050", "#9d2e43"],
                    ["#ff6b61", "#ff2e43"],
                    ["#66ffffff", "#00ffffff"],
                    ["#ffffff", "#66ffffff"],
            ]
            case "blue":
                subLayercolorList = [
                    ["#006aa7", "#0058a8"],
                    ["#29c5e2", "#0071bc"],
                    ["#66ffffff", "#00ffffff"],
                    ["#ffffff", "#66ffffff"],
            ]
            case "green":
                subLayercolorList = [
                    ["#00652f", "#007248"],
                    ["#51cd5e", "#00a448"],
                    ["#66ffffff", "#00ffffff"],
                    ["#ffffff", "#66ffffff"],
            ]
            case "orange":
                subLayercolorList = [
                    ["#e65f00", "#aa4024"],
                    ["#f77d1e", "#f15a24"],
                    ["#66ffffff", "#00ffffff"],
                    ["#ffffff", "#66ffffff"],
            ]
            case "violet":
                subLayercolorList = [
                    ["#2939a7", "#1a4198"],
                    ["#7763e2", "#1a4198"],
                    ["#66ffffff", "#00ffffff"],
                    ["#ffffff", "#66ffffff"],
            ]
            case "yellow":
                subLayercolorList = [
                    ["#cf5a3d", "#ce5900"],
                    ["#f1a824", "#f78e1e"],
                    ["#66ffffff", "#00ffffff"],
                    ["#ffffff", "#66ffffff"],
            ]
            case "purple":
                subLayercolorList = [
                    ["#c39eee", "#8c26f6"],
                    ["#8715fe", "#7714bc"],
                    ["#66ffffff", "#00ffffff"],
                    ["#ffffff", "#66ffffff"],
            ]
            
            default:
                subLayercolorList = [
                    ["#808080", "#666666"],
                    ["#cccccc", "#b6b3b3"],
                    ["#66ffffff", "#00ffffff"],
                    ["#ffffff", "#66ffffff"]
                ]
            break
        }
        
        return subLayercolorList
    }
}
