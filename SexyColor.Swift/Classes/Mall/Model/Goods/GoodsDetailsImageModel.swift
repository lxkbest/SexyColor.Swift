//
//  GoodsDetailsImageModel.swift
//  SexyColor.Swift
//
//  Created by kayzhang on 2017/9/5.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//

import UIKit
import HandyJSON

struct GoodsDetailsImageData: HandyJSON {
    var code : Int?
    var message: String?
    var data: GoodsDetailsImageModel?
    
    static func loadCommodity(completion: (_ model: GoodsDetailsImageData) -> ()) {
        let path = Bundle.main.path(forResource: "images", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        do {
            let jsonData = try Data(contentsOf: url)
            
            let json = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments)
            let jsonDic = json as! NSDictionary
            let toModel = JSONDeserializer<GoodsDetailsImageData>.deserializeFrom(dict: jsonDic)!
            completion(toModel)
        } catch let error {
            print("读取本地数据出现错误！", error)
        }
    }
}

struct GoodsDetailsImageModel: HandyJSON {
    var url_list : [UrlList]?
    var vedio_url : String?
}

struct UrlList: HandyJSON {
    var img_height : Int?
    var img_with : Int?
    var img_url : String?
}
