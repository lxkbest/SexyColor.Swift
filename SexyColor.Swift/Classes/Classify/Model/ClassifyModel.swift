//
//  ClassifyModel.swift
//  SexyColor.Swift
//
//  Created by xiongkai on 2017/9/5.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//

import Foundation
import HandyJSON


struct ClassifyData : HandyJSON {

    var code : Int?
    var message: String?
    var data: ClassifyModel?
    
    
    static func loadClassify(completion: (_ model: ClassifyData) -> ()) {
        let path = Bundle.main.path(forResource: "category", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        do {
            let jsonData = try Data(contentsOf: url)
            
            let json = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments)
            let jsonDic = json as! NSDictionary
            let toModel = JSONDeserializer<ClassifyData>.deserializeFrom(dict: jsonDic)!
            completion(toModel)
        } catch let error {
            print("读取本地数据出现错误！", error)
        }
    }
}

struct ClassifyModel : HandyJSON {
    var category_list : [CategoryList]?
    var template_id : Int?
}

struct CategoryList : HandyJSON {
    var cat_name : String?
    var sub_category : [SubCategory]?
}

struct SubCategory : HandyJSON {
    var link_url : Int?
    var cat_name : String?
    var cat_img : String?
    var is_hot : Bool?
}
