//
//  GlobalTheme.swift
//  SexyColor.Swift
//
//  Created by xiongkai on 2017/8/4.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//

import UIKit


/// 导航栏高度
let NavigationH: CGFloat = 64
/// tabbar高度
let TabbarH: CGFloat = 49
/// 默认Cell44
let CellH: CGFloat = 44

let ScreenWidth: CGFloat = UIScreen.main.bounds.width

let ScreenHeight: CGFloat = UIScreen.main.bounds.height

let ScreenBounds: CGRect = UIScreen.main.bounds


//let BaseUrl: String = "http://192.168.1.240:8087"
let BaseUrl: String = "http://112.74.134.186:8087"

let BasePath: String = "app/services/request"
/// 显示记录数
let PageSize: Int = 20
/// 是否首次启动
let isFirstLaunch: String = "isFirstLaunch"
/// 全局灰色背景
let GlobalColor:UIColor = UIColor.colorWithHexString(hex: "#f5f5f5")
/// 导航栏背景颜色
let NavigationBackgroundColor:UIColor = UIColor.colorWithCustom(r: 70, g: 160, b: 247)
/// APP导航条barButtonItem文字大小
let NavItemFont: UIFont = UIFont.systemFont(ofSize: 16)
/// APP导航条titleFont文字大小
let NavTitleFont: UIFont = UIFont.systemFont(ofSize: 18)
/// APP导航条titleFont文字大小(DoubleTextView)
let NavDoubleTitleFont: UIFont = UIFont.systemFont(ofSize: 16)
/// iPhone 5
let isIPhone5 = ScreenWidth == 568 ? true : false
/// iPhone 6
let isIPhone6 = ScreenWidth == 667 ? true : false
/// iPhone 6P
let isIPhone6P = ScreenWidth == 736 ? true : false
/// 动画时长
let AnimationDuration = 0.25
/// 蒙版透明度
let Alpha:CGFloat = 0.4
/// 新特性界面图片数量
let NewFeatureCount = 4
/// 圆角
let CornerRadius: CGFloat = 5.0
/// 小间距
let SamllMargin: CGFloat = 5.0
/// 间距
let Margin: CGFloat = 10.0
/// 大间距
let BigMargin: CGFloat = 20.0
/// 线宽
let LineWidth: CGFloat = 1.0
/// code 码 200 操作成功
let OK = 200
/// 超时响应
let TimeOut: TimeInterval = 5
/// Cache路径
let CachePath: String = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!

/// 颜色
let AthensGrayColor: UIColor = UIColor.colorWithCustom(r: 239, g: 239, b: 244)

/// 轮播图动画时长
let CycleAnimationDuration = 10.0


let GuideFinsh: String = "GuideFinsh"
let LoginFnish: String = "LoginFnish"
let LogoutFnish: String = "LogoutFnish"

func compareMAX(_ w: CGFloat,ww: CGFloat) -> CGFloat {
    if w >= ww {
        return w
    } else {
        return ww
    }
}
