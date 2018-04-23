//
//  OrderListModel.swift
//  SexyColor.Swift
//
//  Created by xiongkai on 2017/9/14.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//

import Foundation
import HandyJSON

struct OrderListData : HandyJSON {
    
    var code : Int?
    var message : String?
    var data : OrderListModel?

    static func loadOrderList(completion: (_ model: OrderListData) -> ()) {
        let path = Bundle.main.path(forResource: "order_list", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        do {
            let jsonData = try Data(contentsOf: url)
            
            let json = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments)
            let jsonDic = json as! NSDictionary
            let toModel = JSONDeserializer<OrderListData>.deserializeFrom(dict: jsonDic)!
            completion(toModel)
        } catch let error {
            print("读取本地数据出现错误！", error)
        }
    }

    
}

struct OrderListModel : HandyJSON {
    
    var order_list : [OrderList]?
    var page_total : Int?
    var c_total : Int?
    var c_page_next : Int?
}

struct OrderList : HandyJSON {
    
    var order_id : Int?
    var order_sn : String?
    var pay_id : Int?
    var consignee : String?
    var goods_amount : Int?
    var order_amount : Double?
    var bonus : Int?
    var shipping_fee : Int?
    var integral_money : Int?
    var payment_discount_price : Double?
    var user_discount_price : Double?
    var ordinary_goods_prices : Double?
    var specialty_goods_prices : Double?
    var deposit : Int?
    var add_time : String?
    var invoice_no : String?
    var shipping_name : String?
    var order_status : String?
    var is_comment : Int?
    
    var order_goods : [OrderGoods]?
    
}

struct OrderGoods : HandyJSON {

    var goods_id : Int?
    var order_sn : String?
    var goods_name : String?
    var goods_img : String?
    var app_price : Double?
    var goods_number : Int?
    var goods_attr : String?
    var extension_code : String?
    var is_comment : Int?

}
