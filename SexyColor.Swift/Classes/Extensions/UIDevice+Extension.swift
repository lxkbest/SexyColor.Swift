//
//  UIDevice+Extension.swift
//  ColorMoon
//
//  Created by xiongkai on 16/9/6.
//  Copyright © 2016年 薛凯凯圆滚滚. All rights reserved.
//  UIDevice扩展

import UIKit


extension UIDevice {

    
    /**
     获取设备屏幕尺寸
     */
    class func currentDeviceScreenMeasurement() -> CGFloat {
        var deviceScree: CGFloat = 3.5
        
        if 568 == ScreenHeight && 320 == ScreenWidth || 1136 == ScreenHeight && 640 == ScreenWidth {
            deviceScree = 4.0;
        } else if 667 == ScreenHeight && 375 == ScreenWidth || 1334 == ScreenHeight && 750 == ScreenWidth {
            deviceScree = 4.7
        } else if 736 == ScreenHeight && 414 == ScreenWidth || 2208 == ScreenHeight && 1242 == ScreenWidth {
            deviceScree = 5.5
        }
        return deviceScree
    }

    
}
