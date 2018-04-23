//
//  FileManage.swift
//  SexyColor.Swift
//
//  Created by xiongkai on 2017/8/17.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//

import Foundation

class FileManage: NSObject {
    
    static let fileManager = FileManager.default
    
    /**
     计算单个文件的大小
     */
    class func fileSize(_ path: String) -> Double {
        
        if fileManager.fileExists(atPath: path) {
            var dict = try? fileManager.attributesOfItem(atPath: path)
            if let fileSize = dict![FileAttributeKey.size] as? Int{
                return Double(fileSize) / 1024.0 / 1024.0
            }
        }
        
        return 0.0
    }
    
    /**
     计算整个文件夹的大小
     */
    class func folderSize(_ path: String) -> Double {
        var folderSize: Double = 0
        if fileManager.fileExists(atPath: path) {
            let chilerFiles = fileManager.subpaths(atPath: path)
            for fileName in chilerFiles! {
                let tmpPath = path as NSString
                let fileFullPathName = tmpPath.appendingPathComponent(fileName)
                folderSize += FileManage.fileSize(fileFullPathName)
            }
            return folderSize
        }
        return 0
    }
    
    /**
     清除文件 同步
     */
    class func cleanFolder(_ path: String, complete:() -> ()) {
        
        let chilerFiles = self.fileManager.subpaths(atPath: path)
        for fileName in chilerFiles! {
            let tmpPath = path as NSString
            let fileFullPathName = tmpPath.appendingPathComponent(fileName)
            if self.fileManager.fileExists(atPath: fileFullPathName) {
                do {
                    try self.fileManager.removeItem(atPath: fileFullPathName)
                } catch {
                    
                }
            }
        }
        
        complete()
    }
    
    /**
     清除文件异步
     */
    class func cleanFolderAsync(_ path: String, complete:@escaping () -> ()) {
        
        let queue = DispatchQueue(label: "cleanQueue", attributes: [])
        queue.async { () -> Void in
            let chilerFiles = self.fileManager.subpaths(atPath: path)
            for fileName in chilerFiles! {
                let tmpPath = path as NSString
                let fileFullPathName = tmpPath.appendingPathComponent(fileName)
                if self.fileManager.fileExists(atPath: fileFullPathName) {
                    do {
                        try self.fileManager.removeItem(atPath: fileFullPathName)
                    } catch  {
                        
                    }
                }
            }
            
            complete()
        }
    }
    
    /**
     获取磁盘总空间大小
     */
    class func diskOfAllSizeMBytes() -> Double {
        do {
            let dic = try? self.fileManager.attributesOfItem(atPath: NSHomeDirectory())
            if let number = dic![FileAttributeKey.systemSize] as? Int {
                return Double(number) / 1024 / 1024
            }
        } 
        return 0.0
    }
    
    /**
     获取磁盘可用空间大小
     */
    class func diskOfFreeSizeMBytes() -> Double {
        do {
            let dic = try? self.fileManager.attributesOfItem(atPath: NSHomeDirectory())
            if let number = dic![FileAttributeKey.systemFreeSize] as? Int {
                return Double(number) / 1024 / 1024
            }
        }
        return 0.0
    }
    
}
