//
//  GoodsListModel.swift
//  SexyColor.Swift
//
//  Created by kayzhang on 2017/9/11.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//

import UIKit
import HandyJSON

struct GoodsListData : HandyJSON {
    var code : Int?
    var message: String?
    var data: GoodsListModel?
    
    static func loadCommodity(completion: (_ model: GoodsListData) -> ()) {
        let path = Bundle.main.path(forResource: "pages", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        do {
            let jsonData = try Data(contentsOf: url)
            
            let json = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments)
            let jsonDic = json as! NSDictionary
            let toModel = JSONDeserializer<GoodsListData>.deserializeFrom(dict: jsonDic)!
            completion(toModel)
        } catch let error {
            print("读取本地数据出现错误！", error)
        }
    }
}

struct GoodsListModel : HandyJSON {
    var link_url : String?
    var ad_info : NSDictionary?
    var cat_list : NSArray?
    var screening : Screening?
    var page_total : Int?
    var c_total : Int?
    var c_page_next : Int?
    var goods_list : [goods_list]?
}

struct Screening : HandyJSON {
    var brands : [Brands]?
    var price_grade : [PriceGrade]?
    var characteristic : [characteristic]?
}

struct Brands : HandyJSON {
    var brand_id : Int?
    var brand_name : String?
}

struct PriceGrade : HandyJSON {
    var min : Int?
    var max : Int?
    var price_range : String?
    var selected : Int?
}

struct characteristic : HandyJSON {
    var chara : Int?
    var name : String?
}

struct goods_list : HandyJSON {
    var goods_id : Int?
    var img_url : String?
    var is_new : Int?
    var hot : Int?
    var promote : Int?
    var vedio : Int?
    var goods_name : String?
    var app_price : Double?
    var sold_num : Int?
    var comment_num : Int?
    var is_free_shipping : Int?
}



