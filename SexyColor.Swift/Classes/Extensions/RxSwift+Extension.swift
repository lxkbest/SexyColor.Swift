//
//  RxSwift+Extension.swift
//  SexyColor.Swift
//
//  Created by xiongkai on 2017/9/7.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import HandyJSON

extension PrimitiveSequence where TraitType == SingleTrait, ElementType == Response {
    public func mapModel<T: HandyJSON>(_ type: T.Type) -> Single<T> {
        return flatMap { response -> Single<T> in
            return Single.just(response.mapModel(T.self))
        }
    }
}

extension Response {
    func mapModel<T: HandyJSON>(_ type: T.Type) -> T {
        let jsonString = String.init(data: data, encoding: .utf8)
        return JSONDeserializer<T>.deserializeFrom(json: jsonString)!
    }
}
