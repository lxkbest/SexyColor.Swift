//
//  CartsModel.swift
//  SexyColor.Swift
//
//  Created by xiongkai on 2017/8/21.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//

import UIKit
import HandyJSON


struct ShopCartData : HandyJSON{
    
    var code : Int?
    var message: String?
    var data: ShopCartModel?
    
    static func loadCarts(completion: (_ model: ShopCartData) -> ()) {
        let path = Bundle.main.path(forResource: "carts", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        do {
            let jsonData = try Data(contentsOf: url)
            
            let json = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments)
            let jsonDic = json as! NSDictionary
            let toModel = JSONDeserializer<ShopCartData>.deserializeFrom(dict: jsonDic)!
            completion(toModel)
        } catch let error {
            print("读取本地数据出现错误！", error)
        }
    }
    
    static func plusCarts(number: Int, completion: () -> ()) {
        completion()
    }
    
    static func reduceCarts(number: Int, completion: () -> ()) {
        completion()
    }
    
    static func removeCarts(completion: () -> ()) {
        completion()
    }

}

struct ShopCartModel : HandyJSON {
    var template_id : Int?
    var total_amount : Int?
    var rec_ids_array : [String]?
    var carts_list : [CartsList]?
    var bonus_info : BonusInfo?
    var carts_count : Int?
    
    
}

struct CartsList : HandyJSON {
    
    var rec_id : Int?
    var goods_id : Int?
    var is_special : Bool?
    var is_check : Bool?
    var special_type : Int?
    var special_id : Int?
    var goods_number : Int?
    var goods_name : String?
    var app_price : Double?
    var user_price : Double?
    var min_goods_amount : Int?
    var goods_img : String?
    var goods_spec_name : String?
    var goods_attr_price : Double?
    var expiry_at : Int?
    var extension_code : String?
    var is_expiry : Bool?
    var expire_msg : String?
}

struct BonusInfo : HandyJSON {
    var shopping_fee : Int?
    var shopping_fee_description : String?
}
