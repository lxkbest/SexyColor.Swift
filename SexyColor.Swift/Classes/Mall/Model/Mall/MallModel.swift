//
//  MallModel.swift
//  SexyColor.Swift
//
//  Created by xiongkai on 2017/9/8.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//

import Foundation
import HandyJSON

struct MallData : HandyJSON {
    
    var code : Int?
    var message : String?
    var data : MallModel?
    
    static func loadMall(completion: (_ model: MallData) -> ()) {
        let path = Bundle.main.path(forResource: "sites", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        do {
            let jsonData = try Data(contentsOf: url)
            
            let json = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments)
            let jsonDic = json as! NSDictionary
            let toModel = JSONDeserializer<MallData>.deserializeFrom(dict: jsonDic)!
            completion(toModel)
        } catch let error {
            print("读取本地数据出现错误！", error)
        }
    }
    
}

struct MallModel : HandyJSON {
    
    var template_id : Int?
    var product_recommendation : [ProductRecommendation]?
    var top_ads : [TopAds]?
    var hot_list : [HotList]?
    var other_recommend_list: [OtherRecommendList]?
    var room_info: MallRoomInfo?
    var presetkey: String?
}

struct OtherRecommendList : HandyJSON {
    var main_title: String?
    var subtitle: String?
    var link_url: String?
    var type: Int?
    var ad_list: [AdList]?
}

struct AdList : HandyJSON {
    var link_url: String?
    var main_title: String?
    var subtitle: String?
    var img_url: String?
    var type: Int?
    var goods_price: String?
}

struct MallRoomInfo : HandyJSON {
    var id: Int?
    var userid: Int?
    var groupid: String?
    var timestamp: Int?
    var type: Int?
    var viewer_count : Int?
    var like_count: Int?
    var title: String?
    var play_url: String?
    var fileid: Int?
    var is_show: Int?
    var hls_play_url: String?
    var nickname: String?
    var headpic: String?
    var frontcover: String?
    var location: String?
    var video_icon: String?
}

struct TopAds : HandyJSON {
    var link_url: Int?
    var main_title: String?
    var subtitle: String?
    var img_url: String?
    var type: Int?
    var goods_price: Double?
}

struct HotList : HandyJSON {
    var link_url: String?
    var main_title: String?
    var subtitle: String?
    var img_url: String?
    var type: Int?
    var goods_price: Double?
}



struct ProductRecommendation : HandyJSON {
    var goods_id: Int?
    var goods_attr: Int?
    var goods_sn: Int?
    var goods_name: String?
    var goods_number: Int?
    var app_price: Double?
    var special_price: Double?
    var special_type: Int?
    var special_id: Int?
    var sort_order: Int?
    var start: Int?
    var recommend: Int?
    var total_comment: Int?
    var market_price: Double?
    var discount: Double?
    var img_url: String?
    var seller_note: String?
    var difference: Int?
    var user_number: Int?
    var sold_num: Int?
    
}
