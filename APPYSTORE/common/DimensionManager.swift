//
//  File.swift
//  APPYSTORE
//
//  Created by BridgeLabz on 24/02/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit
import Foundation

class DimensionManager{
    static let H1: CGFloat = 40
    static let H2: CGFloat = 32
    static let H3: CGFloat = 24
    static let H4: CGFloat = 20
    

    static func convertPixelToPoint(pixel: CGFloat) -> CGFloat{
        return pixel / CGFloat(AppDelegate.density)
    }
    
    
    static func getGeneralizedWidth1280x720(width: CGFloat) -> CGFloat {
        return AppDelegate.DEVICE_WIDTH * (width / CGFloat(1280))
    }
    
    
    static func getGeneralizedHeight1280x720(height: CGFloat) -> CGFloat {
        return AppDelegate.DEVICE_HEIGHT * (height / CGFloat(720))
    }
    
    static func getGeneralizedWidthIn4isto3Ratio(height: CGFloat) -> CGFloat {
        return height * 4 / 3
    }
    
    static func getGeneralizedWidthIn16isto9Ratio(height: CGFloat) -> CGFloat {
        return height * 16 / 9
    }
    
    static func setDimension1280x720(view: UIView, width:CGFloat, height:CGFloat){
        view.bounds.size.width = AppDelegate.DEVICE_WIDTH * (width / CGFloat(1280))
        view.bounds.size.height = AppDelegate.DEVICE_HEIGHT * (height / CGFloat(720))
        print("width:  \(width)   height:  \(height)  viewWidth:  \(view.bounds.size.width)  viewHeight:  \(view.bounds.size.height)")
    }
    
    static func setTextSize1280x720(label: UILabel, size: CGFloat){
        let fontSize = size * AppDelegate.DEVICE_HEIGHT / 720.0
        label.font = label.font.withSize(fontSize)
    }
    
    static func setTextSize1280x720(textField: UITextField, size: CGFloat){
        let fontSize = size * AppDelegate.DEVICE_HEIGHT / 720.0
        textField.font = textField.font?.withSize(fontSize)
    }
    
    func userDeviceName() -> String {
        var name: [Int32] = [CTL_HW, HW_MACHINE]
        var size: Int = 2
        sysctl(&name, 2, nil, &size, &name, 0)
        var hw_machine = [CChar](repeating: 0, count: Int(size))
        sysctl(&name, 2, &hw_machine, &size, &name, 0)
        let platform: String = String(cString: hw_machine)
        
        //iPhone
        if platform == "iPhone1,1"        { return "iPhone 1G" }
        else if platform == "iPhone1,2"   { return "iPhone 3G" }
        else if platform == "iPhone2,1"   { return "iPhone 3GS" }
        else if platform == "iPhone3,1"   { return "iPhone 4" }
        else if platform == "iPhone3,3"   { return "iPhone 4 (Verizon)" }
        else if platform == "iPhone4,1"   { return "iPhone 4S" }
        else if platform == "iPhone5,1"   { return "iPhone 5 (GSM)" }
        else if platform == "iPhone5,2"   { return "iPhone 5 (GSM+CDMA)" }
        else if platform == "iPhone5,3"   { return "iPhone 5c (GSM)" }
        else if platform == "iPhone5,4"   { return "iPhone 5c (GSM+CDMA)" }
        else if platform == "iPhone6,1"   { return "iPhone 5s (GSM)" }
        else if platform == "iPhone6,2"   { return "iPhone 5s (GSM+CDMA)" }
        else if platform == "iPhone7,2"   { return "iPhone 6" }
        else if platform == "iPhone7,1"   { return "iPhone 6 Plus" }
        else if platform == "iPhone8,1"   { return "iPhone 6s" }
        else if platform == "iPhone8,2"   { return "iPhone 6s Plus" }
        else if platform == "iPhone8,4"   { return "iPhone SE" }
        else if platform == "iPhone9,1"   { return "iPhone 7 (GSM+CDMA)" }
        else if platform == "iPhone9,3"   { return "iPhone 7 (GSM)" }
        else if platform == "iPhone9,2"   { return "iPhone 7 Plus (GSM+CDMA)" }
        else if platform == "iPhone9,4"   { return "iPhone 7 Plus (GSM)" }
            
            //iPod Touch
        else if platform == "iPod1,1"     { return "iPod Touch 1G" }
        else if platform == "iPod2,1"     { return "iPod Touch 2G" }
        else if platform == "iPod3,1"     { return "iPod Touch 3G" }
        else if platform == "iPod4,1"     { return "iPod Touch 4G" }
        else if platform == "iPod5,1"     { return "iPod Touch 5G" }
        else if platform == "iPod7,1"     { return "iPod Touch 6G" }
            
            //iPad
        else if platform == "iPad1,1"     { return "iPad 1G" }
        else if platform == "iPad2,1"     { return "iPad 2 (Wi-Fi)" }
        else if platform == "iPad2,2"     { return "iPad 2 (GSM)" }
        else if platform == "iPad2,3"     { return "iPad 2 (CDMA)" }
        else if platform == "iPad2,4"     { return "iPad 2 (Wi-Fi, Mid 2012)" }
        else if platform == "iPad2,5"     { return "iPad Mini (Wi-Fi)" }
        else if platform == "iPad2,6"     { return "iPad Mini (GSM)" }
        else if platform == "iPad2,7"     { return "iPad Mini (GSM+CDMA)" }
        else if platform == "iPad3,1"     { return "iPad 3 (Wi-Fi)" }
        else if platform == "iPad3,2"     { return "iPad 3 (GSM+CDMA)" }
        else if platform == "iPad3,3"     { return "iPad 3 (GSM)" }
        else if platform == "iPad3,4"     { return "iPad 4 (Wi-Fi)"}
        else if platform == "iPad3,5"     { return "iPad 4 (GSM)" }
        else if platform == "iPad3,6"     { return "iPad 4 (GSM+CDMA)" }
        else if platform == "iPad4,1"     { return "iPad Air (Wi-Fi)" }
        else if platform == "iPad4,2"     { return "iPad Air (Cellular)" }
        else if platform == "iPad4,3"     { return "iPad Air (China)" }
        else if platform == "iPad4,4"     { return "iPad Mini 2G (Wi-Fi)" }
        else if platform == "iPad4,5"     { return "iPad Mini 2G (Cellular)" }
        else if platform == "iPad4,6"     { return "iPad Mini 2G (China)" }
        else if platform == "iPad4,7"     { return "iPad Mini 3 (Wi-Fi)" }
        else if platform == "iPad4,8"     { return "iPad Mini 3 (Cellular)" }
        else if platform == "iPad4,9"     { return "iPad Mini 3 (China)" }
        else if platform == "iPad5,1"     { return "iPad Mini 4 (Wi-Fi)" }
        else if platform == "iPad5,2"     { return "iPad Mini 4 (Cellular)" }
        else if platform == "iPad5,3"     { return "iPad Air 2 (Wi-Fi)" }
        else if platform == "iPad5,4"     { return "iPad Air 2 (Cellular)" }
        else if platform == "iPad6,3"     { return "iPad Pro 9.7\" (Wi-Fi)" }
        else if platform == "iPad6,4"     { return "iPad Pro 9.7\" (Cellular)" }
        else if platform == "iPad6,7"     { return "iPad Pro 12.9\" (Wi-Fi)" }
        else if platform == "iPad6,8"     { return "iPad Pro 12.9\" (Cellular)" }
            
            //Apple TV
        else if platform == "AppleTV2,1"  { return "Apple TV 2G" }
        else if platform == "AppleTV3,1"  { return "Apple TV 3" }
        else if platform == "AppleTV3,2"  { return "Apple TV 3 (2013)" }
        else if platform == "AppleTV5,3"  { return "Apple TV 4" }
            
            //Apple Watch
        else if platform == "Watch1,1"    { return "Apple Watch Series 1 (38mm, S1)" }
        else if platform == "Watch1,2"    { return "Apple Watch Series 1 (42mm, S1)" }
        else if platform == "Watch2,6"    { return "Apple Watch Series 1 (38mm, S1P)" }
        else if platform == "Watch2,7"    { return "Apple Watch Series 1 (42mm, S1P)" }
        else if platform == "Watch2,3"    { return "Apple Watch Series 2 (38mm, S2)" }
        else if platform == "Watch2,4"    { return "Apple Watch Series 2 (42mm, S2)" }
            
            //Simulator
        else if platform == "i386"        { return "Simulator" }
        else if platform == "x86_64"      { return "Simulator"}
        
        return platform
    }
}
