//
//  String+Extension.swift
//  ColorMoon
//
//  Created by xiongkai on 16/9/6.
//  Copyright © 2016年 薛凯凯圆滚滚. All rights reserved.
//  String扩展

import UIKit

extension String {

    
    var ocStr : NSString {
        get {
            return self as NSString
        }
    }
    var length: Int {
        get {
            return self.characters.count
        }
    }
    /**
     OC的快捷拼接方法
     */
    func stringByAppendingPathComponent(_ pathConmonent: String) -> String {
        return self.ocStr.appendingPathComponent(pathConmonent) as String
    }
    
    func stringByAppendingPathExtension(_ ext: String) -> String {
        return self.ocStr.appendingPathExtension(ext)! as String
    }
    
    
    var md5: String! {
        let str = self.cString(using: String.Encoding.utf8)
        
        let strLen = CC_LONG(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        
        CC_MD5(str!, strLen, result)
        
        let hash = NSMutableString()
        for i in 0..<digestLen {
            hash.appendFormat("%02x", result[i])
        }
        
        result.deallocate(capacity: digestLen)
        
        return hash.copy() as! String
    }
    
    /// 判断手机号是否合法
    static func isValidmobile(_ string: String) -> Bool {
        // 判断是否是手机号
        let patternString = "^1[3|4|5|7|8][0-9]\\d{8}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", patternString)
        return predicate.evaluate(with: string)
    }
    
    /// 判断密码是否合法
    static func isValidPasswod(_ string: String) -> Bool {
        // 验证密码是 6 - 16 位字母或数字
        let patternString = "^[0-9A-Za-z]{6,16}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", patternString)
        return predicate.evaluate(with: string)
    }
    
    func cleanDecimalPointZear() -> String {
        
        let newStr = self as NSString
        var s = NSString()
        var offset = newStr.length - 1
        while offset > 0 {
            s = newStr.substring(with: NSMakeRange(offset, 1)) as NSString
            if s.isEqual(to: "0") || s.isEqual(to: ".") {
                offset -= 1
            } else {
                break
            }
        }
        return newStr.substring(to: offset + 1)
    }

    
}
