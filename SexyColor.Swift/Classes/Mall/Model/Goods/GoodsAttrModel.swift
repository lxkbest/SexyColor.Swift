//
//  GoodsAttrModel.swift
//  SexyColor.Swift
//
//  Created by kayzhang on 2017/9/5.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//立即购买 + 商品详情

import UIKit
import HandyJSON

struct GoodsAttrData: HandyJSON {
    var code : Int?
    var message: String?
    var data: GoodsAttrModel?
    
    static func loadCommodity(completion: (_ model: GoodsAttrData) -> ()) {
        let path = Bundle.main.path(forResource: "attr", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        do {
            let jsonData = try Data(contentsOf: url)
            
            let json = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments)
            let jsonDic = json as! NSDictionary
            let toModel = JSONDeserializer<GoodsAttrData>.deserializeFrom(dict: jsonDic)!
            completion(toModel)
        } catch let error {
            print("读取本地数据出现错误！", error)
        }
    }
}

struct GoodsAttrModel: HandyJSON {
    var parameter : [Parameter]?
    var standard : Standard?
}

struct Parameter: HandyJSON {
    var attr_name : String?
    var attr_value : String?
}

struct Standard: HandyJSON {
    var standard_name : String?
    var standard_list : [StandardList]?
}

struct StandardList: HandyJSON {
    var attr_value : String?
    var goods_id : String?
    var goods_attr_id : String?
    var attr_pic : String?
    var attr_price : Double?
    var user_price : Double?
}
