//
//  APIManager.swift
//  SexyColor.Swift
//
//  Created by xiongkai on 2017/9/7.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//

import Foundation
import Moya


enum ApiManager {
    case getDaily
    case getContent(Int)
}

extension ApiManager : TargetType {
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }

    
    var baseURL: URL {
        return URL(string: "https://api-m.qu.cn/")!
    }
    
    var path: String {
        switch self {
        case .getDaily:
            return "community/daily"
        case .getContent(let type):
            return "community/\(type)"
        }
    }
    
    var method : Moya.Method {
        return .get
    }
    
    var parameters: [String: Any]? {
        return nil
    }
    
    var parameterCncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }

    
    var task: Task {
        return .requestPlain
    }
    
    var validate: Bool {
        return false
    }
}
