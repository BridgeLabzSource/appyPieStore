//
//  LayerColor.swift
//  APPYSTORE
//
//  Created by ios_dev on 21/04/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import Foundation


class ButtonColor {
    static let GREY_COLOR = "grey"
    static let RED_COLOR = "red"
    static let BLUE_COLOR = "blue"
    static let GREEN_COLOR = "green"
    static let ORANGE_COLOR = "orange"
    static let VIOLET_COLOR = "violet"
    static let YELLOW_COLOR = "yellow"
    static let PURPLE_COLOR = "purple"
    
    static func getLayerColor(colorName: String?) -> [[String]] {
        var subLayercolorList: [[String]] = []
        let color = colorName ?? GREY_COLOR
        switch color {
            case GREY_COLOR:
                subLayercolorList = [
                    ["#808080", "#666666"],
                    ["#cccccc", "#b6b3b3"],
                    ["#66ffffff", "#00ffffff"],
                    ["#ffffff", "#66ffffff"]
                ]
            case RED_COLOR:
                subLayercolorList = [
                    ["#964050", "#9d2e43"],
                    ["#ff6b61", "#ff2e43"],
                    ["#66ffffff", "#00ffffff"],
                    ["#ffffff", "#66ffffff"],
            ]
            case BLUE_COLOR:
                subLayercolorList = [
                    ["#006aa7", "#0058a8"],
                    ["#29c5e2", "#0071bc"],
                    ["#66ffffff", "#00ffffff"],
                    ["#ffffff", "#66ffffff"],
            ]
            case GREEN_COLOR:
                subLayercolorList = [
                    ["#00652f", "#007248"],
                    ["#51cd5e", "#00a448"],
                    ["#66ffffff", "#00ffffff"],
                    ["#ffffff", "#66ffffff"],
            ]
            case ORANGE_COLOR:
                subLayercolorList = [
                    ["#e65f00", "#aa4024"],
                    ["#f77d1e", "#f15a24"],
                    ["#66ffffff", "#00ffffff"],
                    ["#ffffff", "#66ffffff"],
            ]
            case VIOLET_COLOR:
                subLayercolorList = [
                    ["#2939a7", "#1a4198"],
                    ["#7763e2", "#1a4198"],
                    ["#66ffffff", "#00ffffff"],
                    ["#ffffff", "#66ffffff"],
            ]
            case YELLOW_COLOR:
                subLayercolorList = [
                    ["#cf5a3d", "#ce5900"],
                    ["#f1a824", "#f78e1e"],
                    ["#66ffffff", "#00ffffff"],
                    ["#ffffff", "#66ffffff"],
            ]
            case PURPLE_COLOR:
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
