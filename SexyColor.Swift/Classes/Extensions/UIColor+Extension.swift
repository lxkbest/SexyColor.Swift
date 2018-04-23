//
//  UIColor+Extension.swift
//  ColorMoon
//
//  Created by xiongkai on 16/9/6.
//  Copyright © 2016年 薛凯凯圆滚滚. All rights reserved.
//  UIColor扩展

import UIKit


extension UIColor {

    /**
     自定义颜色
     */
    class func colorWithCustom(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat = 1) -> UIColor {
        return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
        
    }
    /**
     随机颜色
     */
    class func randomColor() -> UIColor {
        
        let r = CGFloat(arc4random_uniform(256))
        let g = CGFloat(arc4random_uniform(256))
        let b = CGFloat(arc4random_uniform(256))
        return colorWithCustom(r: r, g: g, b: b)
    }
    
    /**
     将16进制颜色转换成UIColor
     */
    class func colorWithHexString(hex: String) -> UIColor {
        var cString =  hex.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()
        if cString.length < 6 {
            return UIColor.clear
        }
        
        if cString.hasPrefix("0X") {
            cString = (cString as NSString).substring(from: 2)
        }
        if cString.hasPrefix("#") {
            cString =  (cString as NSString).substring(from: 1)
        }
        if cString.length != 6 {
            return UIColor.clear
        }
        
        var range:NSRange = NSRange(location: 0, length: 2)
        
        let rString =  (cString as NSString).substring(with: range)
        range.location = 2
        let gString =  (cString as NSString).substring(with: range)
        range.location = 4
        let bString =  (cString as NSString).substring(with: range)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        return colorWithCustom(r: CGFloat(r), g: CGFloat(g), b: CGFloat(b))
    }
    
}
