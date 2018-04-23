//
//  ContentDailyModel.swift
//  SexyColor.Swift
//
//  Created by xiongkai on 2017/9/7.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//

import Foundation
import HandyJSON


struct DailyData : HandyJSON {
    var code : Int?
    var message: String?
    var data: DailyModel?
    
    static func loadDaily(completion: (_ model: DailyData) -> ()) {
        let path = Bundle.main.path(forResource: "content_dailys", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        do {
            let jsonData = try Data(contentsOf: url)
            
            let json = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments)
            let jsonDic = json as! NSDictionary
            let toModel = JSONDeserializer<DailyData>.deserializeFrom(dict: jsonDic)!
            completion(toModel)
        } catch let error {
            print("读取本地数据出现错误！", error)
        }
    }
    
    
}

struct DailyModel : HandyJSON {
    var list: [DailyEntity]?
    var page_total: Int?
    var c_total: Int?
    var c_page_next: Int?
}

struct DailyEntity  : HandyJSON {
    var id: Int?
    var title: String?
    var cover_img: String?
    var img_height: Int?
    var img_with: Int?
    var praise_count: Int?
    var comment_count: Int?
}
