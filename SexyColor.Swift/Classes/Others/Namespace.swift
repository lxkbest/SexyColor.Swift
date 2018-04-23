//
//  Namespace.swift
//  SexyColor.Swift
//
//  Created by xiongkai on 2017/8/11.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//

import Foundation


protocol NamespaceCompatible {
    associatedtype CompatibleType
    var sexy: CompatibleType { get }
    static var sexy: CompatibleType.Type { get }
}

struct Namespace<Base> {
    let base: Base
    
    init(_ base: Base) {
        self.base = base
    }
}

extension NamespaceCompatible {
    var sexy: Namespace<Self> {
        return Namespace(self)
    }
    
    static var sexy: Namespace<Self>.Type {
        return Namespace.self
    }
}

extension NSObject: NamespaceCompatible {
    static var sexy: NSObject.Type {
        return self
    }

    var sexy: NSObject {
        return self
    }
 }
