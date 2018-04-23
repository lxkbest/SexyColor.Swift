//
//  FavoritesModel.swift
//  SexyColor.Swift
//
//  Created by xiongkai on 2017/9/14.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//

import Foundation
import HandyJSON

struct FavoritesData : HandyJSON {
    
    var code : Int?
    var message : String?
    var data : FavoritesModel?
    
}

struct FavoritesModel : HandyJSON {

    var collection_list : [CollectionList]?
    var page_total : Int?
    var c_total : Int?
    
}

struct CollectionList : HandyJSON {

    var id : Int?
    var goods_id : Int?
    var goods_name : String?
    var app_price : Double?
    var sold_num : Int?
    var img_url : String?
    var comment_count : Int?
    
}
