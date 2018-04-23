//
//  CouponModel.swift
//  SexyColor.Swift
//
//  Created by xiongkai on 2017/9/14.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//

import Foundation
import HandyJSON


struct CouponData : HandyJSON {
    
    var code : Int?
    var message : String?
    var data : OrderListModel?
    
    
}

struct CouponModel : HandyJSON {

    var bonus_list : [BonusList]?
    var invalid_bonus_list : [BonusList]?
}

struct BonusList : HandyJSON {

    var bonus_id : Int?
    var landing_type : Int?
    var order_id : Int?
    var start_date : Int?
    var end_date : Int?
    var type_name : String?
    var type_money : Double?
    var min_goods_amount : Int?
    var status : Int?
    var is_expiring : Int?
    var bonus_description : String?
    var unavailable_desc: String?
    var landing_link : String?
    
}
