//
//  HistoricalFMDB.swift
//  SexyColor.Swift
//
//  Created by kayzhang on 2017/9/15.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//

import UIKit
import FMDB

class HistoricalFMDB: NSObject {
//    //定义一个单例对象（类对象）
//    //系统中shareManager、defaultManager、standerdManager这一类获取的对象一般都是单例对象
//    static let shareManager = HistoricalFMDB()
//    //定义管理数据库的对象
//    let fmdb : FMDatabase!
//    
//    //线程锁,通过加锁和解锁来保证所做操作数据的安全性
//    let lock = NSLock()
//    
//    //1.重写父类的构造方法
//    override init() {
//        var path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
//        path = path?.appending("/Historical.plist")
//        fmdb = FMDatabase(path: path)
//        if !fmdb.open() {
//            print("数据库打开失败")
//            return
//        }
//        let createSql = "create table if not exists student(userName varchar(1024),passWord varchar(1024))"
//        
//        
//        do {
//            try fmdb.executeUpdate(createSql, values: nil)
//        }catch {
//            print(fmdb.lastErrorMessage())
//        }
//    }
//    
//    //2.增
//    func insertDataWith(model:goods_list) {
//        
//        //加锁操作
//        lock.lock()
//        //sel语句
//        //(?,?)表示需要传的值，对应前面出现几个字段，后面就有几个问号
//        let insetSql = "insert into student(userName, passWord) values(?,?)"
//        //更新数据库
//        do {
//            try fmdb.executeUpdate(insetSql, values: [model.userName!,model.passWord!])
//        }catch {
//            print(fmdb.lastErrorMessage())
//        }
//        
//        //解锁
//        lock.unlock()
//    }
//    
//    //3.删
//    func deleteDataWith(model:goods_list) {
//        
//        //加锁操作
//        lock.lock()
//        //sel语句
//        //where表示需要删除的对象的索引，是对应的条件
//        let deleteSql = "delete from student where userName = ?"
//        //更新数据库
//        do{
//            try fmdb.executeUpdate(deleteSql, values: [model.userName!])
//        }catch {
//            print(fmdb.lastErrorMessage())
//        }
//        
//        //解锁
//        lock.unlock()
//    }
//    
//    //5.判断数据库中是否有当前数据(查找一条数据)
//    func isHasDataInTable(model:goods_list) -> Bool {
//        
//        let isHas = "select * from student where userName = ?"
//        do{
//            let set = try fmdb.executeQuery(isHas, values: [model.goods_name!])
//            //查找当前行，如果数据存在，则接着查找下一行
//            if set.next() {
//                return true
//            }else {
//                return false
//            }
//        }catch {
//            print(fmdb.lastErrorMessage())
//        }
//        
//        return true
//    }
//    
//    //6.查找全部数据
//    func fetchAllData() ->[goods_list] {
//        
//        let fetchSql = "select * from student"
//        //用于承接所有数据的临时数组
//        var tempArray = [goods_list]()
//        do {
//            let set = try fmdb.executeQuery(fetchSql, values: nil)
//            //循环遍历结果
//            while set.next() {
//                var model = goods_list()
//                //给字段赋值
//                model.comment_num = 1//set.string(forColumn: "z")
//                model.comment_num = 1//set.string(forColumn: "z")
//                tempArray.append(model)
//            }
//        }catch {
//            print(fmdb.lastErrorMessage())
//        }
//        
//        return tempArray
//    }
}
