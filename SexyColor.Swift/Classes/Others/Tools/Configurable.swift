//
//  Configurable.swift
//  SexyColor.Swift
//
//  Created by xiongkai on 2017/8/11.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//

import Foundation
import SnapKit

protocol ChainConfigurable { }

extension ChainConfigurable where Self: UIView {
    
    func sexy_config(_ config: (Self) -> Void) -> Self {
        config(self)
        return self
    }
}

extension UIView: ChainConfigurable {
    static func sexy_create(_ withSuperView: UIView) -> Self {
        let result = self.init()
        withSuperView.addSubview(result)
        return result
    }
    
    func sexy_adhere(_ toSuperView: UIView) -> Self {
        toSuperView.addSubview(self)
        return self
    }
    
    func sexy_layout(_ snapKitMaker: (ConstraintMaker) -> Void) -> Self {
        snp.makeConstraints { (make) in
            snapKitMaker(make)
        }
        return self
    }
    
}

extension Namespace where Base: UIView {
    static func create(_ withSuperView: UIView) -> Namespace {
        let result = Base()
        withSuperView.addSubview(result)
        return Namespace(result)
    }
    
    func adhere(_ toSuperView: UIView) -> Namespace {
        toSuperView.addSubview(base)
        return self
    }
    
    func layout(_ snapKitMaker: (ConstraintMaker) -> Void) -> Namespace {
        base.snp.makeConstraints { (make) in
            snapKitMaker(make)
        }
        return self
    }
    
    func config(_ config: (Base) -> Void) -> Namespace {
        config(base)
        return self
    }
    
    var view: Base {
        return base
    }
}
