//
//  GoodsCommentModel.swift
//  SexyColor.Swift
//
//  Created by kayzhang on 2017/9/5.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//商品详情-评论数据模型

import UIKit
import HandyJSON

struct GoodsCommentData: HandyJSON {
    var code : Int?
    var message : String?
    var data : GoodsCommentModel?
    
    static func loadCommodity(completion: (_ model: GoodsCommentData) -> ()) {
        let path = Bundle.main.path(forResource: "comment", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        do {
            let jsonData = try Data(contentsOf: url)
            
            let json = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments)
            let jsonDic = json as! NSDictionary
            let toModel = JSONDeserializer<GoodsCommentData>.deserializeFrom(dict: jsonDic)!
            completion(toModel)
        } catch let error {
            print("读取本地数据出现错误！", error)
        }
    }
}

struct GoodsCommentModel: HandyJSON {
    var comment_count : Int?
    var page_total : Int?
    var comment_list : [CommentList]?
}
