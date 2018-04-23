//
//  MallHotView.swift
//  SexyColor.Swift
//
//  Created by xiongkai on 2017/9/11.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//

import UIKit

class MallHotView: UICollectionReusableView {
    
    private var iconW: CGFloat = ScreenWidth / 5
    private var iconH: CGFloat = 80
    
    var hotListClosure: ((_ index: Int) -> Void)?
    
    var rows: Int = 0
    
    var hotListData: [HotList]? {
        didSet {
            if let data = hotListData {
                if data.count % 4 != 0 {
                    rows = data.count / 5 + 1
                } else {
                    rows = data.count / 5
                }
                
                if subviews.count <= 0 {
                    for i in 0..<data.count {
                        let iconX = CGFloat(i % 5) * iconW
                        let iconY = iconH * CGFloat(i / 5)
                        let frame = CGRect(x: iconX, y: iconY, width: iconW, height: iconH)
                        let iconBtn = MallHotItemView(frame: frame, image: UIImage(named: "loadingbkg")!)
                        iconBtn.tupleData = (data[i].main_title, data[i].img_url)
                        iconBtn.tag = i
                        iconBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(setClick(_:))))
                        backgroundColor = UIColor.white
                        addSubview(iconBtn)
                    }
                } else {
                    var i = 0
                    for iconBtn in self.subviews {
                        let btn = iconBtn as! MallHotItemView
                        btn.tupleData = (data[i].main_title, data[i].img_url)
                        i += 1
                    }

                }
                
            }
        }
    }
    
    func setClick(_ tap: UITapGestureRecognizer) {
        if hotListClosure != nil {
            hotListClosure!(tap.view!.tag)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
