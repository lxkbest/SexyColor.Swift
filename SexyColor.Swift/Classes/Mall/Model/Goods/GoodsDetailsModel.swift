//
//  GoodsModel.swift
//  SexyColor.Swift
//
//  Created by kayzhang on 2017/9/4.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//商品详情-商品

import UIKit
import HandyJSON

struct GoodsDetailsData: HandyJSON {
    var code : Int?
    var message: String?
    var data: GoodsDetailsModel?
    
    static func loadCommodity(completion: (_ model: GoodsDetailsData) -> ()) {
        let path = Bundle.main.path(forResource: "goods", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        do {
            let jsonData = try Data(contentsOf: url)
            
            let json = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments)
            let jsonDic = json as! NSDictionary
            let toModel = JSONDeserializer<GoodsDetailsData>.deserializeFrom(dict: jsonDic)!
            completion(toModel)
        } catch let error {
            print("读取本地数据出现错误！", error)
        }
    }
}


struct GoodsDetailsModel: HandyJSON {
    var goods_info : GoodsInfo?
    var bouns_info : BonusInfo?
    var goods_gallery : [String]?
    var comment_count : Int?
    var comment_list : [CommentList]?
    var goods_float_ad : GoodsFloatAd?
    var package_total : Int?
    var package_info : PackageInfo?
    var recommend_goods : [RecommendGoods]?
}

struct GoodsInfo: HandyJSON {
    var goods_id : Int?
    var  goods_sn : String?
    var cat_id : Int?
    var goods_name : String?
    var seller_note : String?
    var app_price : Int?
    var market_price : Int?
    var deposit : Int?
    var sold_num : Int?
    var is_special : Int?
    var is_collection : Int?
    var collection_id : Int?
    var special_type : Int?
    var special_id : Int?
    var referer_type : Int?
    var zt_id : Int?
    var goods_attr : Int?
    var is_free_shipping : Int?
    var remaining_time : Int?
    var user_reduction : String?
    var user_price : Double?
    var pay_points : Int?
    var payment_reduction : String?
    var easemob_url : String?
    var is_new : Int?
    var hot : Int?
    var vedio : Int?
}

struct CommentList: HandyJSON {
    var comment_img_list : [String]?
    var user_comment : String?
    var user_name : String?
    var avatar : String?
    var add_time : String?
    var rank_name : String?
    var region : String?
}

struct GoodsFloatAd: HandyJSON {
    var link_url : String?
    var main_title : String?
    var subtitle : String?
    var img_url : String?
    var type : Int?
    var type_name : String?
}

struct PackageInfo: HandyJSON {
    var package_id : Int?
    var package_name : String?
    var package_price : Int?
    var goods_list : [GoodsList]?
    var package_goods_price : Int?
    var package_discount : Int?
}

struct GoodsList: HandyJSON {
    var goods_id : Int?
    var goods_sn : String?
    var goods_name : String?
    var goods_price : Int?
    var goods_img : String?
}

struct RecommendGoods: HandyJSON {
    var goods_id : Int?
    var goods_name : String?
    var goods_img : String?
    var app_price : Int?
}






