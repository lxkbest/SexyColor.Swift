//
//  OrderDetailModel.swift
//  SexyColor.Swift
//
//  Created by xiongkai on 2017/9/14.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//

import Foundation
import HandyJSON

struct OrderDetailData : HandyJSON {
    
    var code : Int?
    var message : String?
    var data : OrderDetailModel?
    
    static func loadOrderDetail(completion: (_ model: OrderDetailData) -> (), sn: String) {
        let path = Bundle.main.path(forResource: "order_detail_\(sn)", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        do {
            let jsonData = try Data(contentsOf: url)
            
            let json = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments)
            let jsonDic = json as! NSDictionary
            let toModel = JSONDeserializer<OrderDetailData>.deserializeFrom(dict: jsonDic)!
            completion(toModel)
        } catch let error {
            print("读取本地数据出现错误！", error)
        }
    }
    
}

struct OrderDetailModel : HandyJSON {
    
    
    var order_info : OrderInfo?
    var order_goods : [OrderGoods]?
}

struct OrderInfo : HandyJSON {
    
    var order_id : Int?
    var order_sn : String?
    var pay_id: Int?
    var consignee : String?
    var goods_amount : Double?
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
    var order_tel : String?
    var order_address : String?
    
}
