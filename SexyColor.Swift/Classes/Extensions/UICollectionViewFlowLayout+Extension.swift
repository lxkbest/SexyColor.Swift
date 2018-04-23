//
//  UICollectionViewFlowLayout+Extension.swift
//  SexyColor.Swift
//
//  Created by xiongkai on 2017/9/6.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//

import UIKit


extension UICollectionViewFlowLayout {
    
    func fixSlit(rect: inout CGRect, colCount: CGFloat, space: CGFloat = 0) -> CGFloat {
        let totalSpace = (colCount - 1) * space
        let itemWidth = (rect.width - totalSpace) / colCount
        let fixValue = 1 / UIScreen.main.scale
        var realItemWidth = floor(itemWidth) + fixValue
        if realItemWidth < itemWidth {
            realItemWidth += fixValue
        }
        let realWidth = colCount * realItemWidth + totalSpace
        let pointX = (realWidth - rect.width) / 2
        rect.origin.x = -pointX
        rect.size.width = realWidth
        return (rect.width - totalSpace) / colCount
    }
    
}
