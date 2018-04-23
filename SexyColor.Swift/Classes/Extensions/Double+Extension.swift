//
//  Double.swift
//  ColorMoon
//
//  Created by xiongkai on 16/9/13.
//  Copyright © 2016年 薛凯凯圆滚滚. All rights reserved.
//  Double扩展

import Foundation

extension Double {

    /**
     转字符串保留两位小数
     */
    func toString() -> String  {
        return String(format: "%.2f", self)
    }
    
    /**
     转字符串保留两位小数外加￥符号
     */
    func toStringByRMB() -> String {
        let str = String(format: "%.2f", self)
        return "￥\(str)"
    }
    
}