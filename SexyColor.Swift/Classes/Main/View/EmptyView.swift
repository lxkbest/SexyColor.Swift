//
//  EmptycartView.swift
//  SexyColor.Swift
//
//  Created by xiongkai on 2017/8/28.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//

import UIKit

class EmptyView: UIView {

    private var emptyImageView: UIImageView!
    private var emptyLabel: UILabel!
    private var greetLabel: UILabel!

    var empty : EmptyEnum = EmptyEnum.other {
        didSet {
            if empty == EmptyEnum.cart {
                emptyImageView.isHidden = false
                emptyLabel.isHidden = false
                greetLabel.isHidden = false
                emptyImageView.image = UIImage(named: "empty_icon_cart")
                emptyLabel.text = "购物车还是空的"
                greetLabel.text = "说好的性福呢？说好的今夜九次郎呢？"
            } else if empty == EmptyEnum.order {
                emptyImageView.isHidden = false
                emptyLabel.isHidden = false
                greetLabel.isHidden = false
                emptyImageView.image = UIImage(named: "empty_order")
                emptyLabel.text = "暂无订单"
                greetLabel.text = "快去选购商品吧，让您的生活性福起来"
            } else {
                emptyImageView.isHidden = true
                emptyLabel.isHidden = true
                greetLabel.isHidden = true
            }
        }
    }
    
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.colorWithCustom(r: 247, g: 247, b: 247)
        
        emptyImageView = UIImageView.sexy_create(self)
            .sexy_layout({ (make) in
                make.centerX.equalTo(self)
                make.top.equalTo(self).offset(100)
                make.width.height.equalTo(80)
            })
            .sexy_config({ (imageView) in
                imageView.image = UIImage(named: "empty_icon_cart")
            })
        
        emptyLabel = UILabel.sexy_create(self)
            .sexy_layout({ (make) in
                make.centerX.equalTo(self)
                make.top.equalTo(emptyImageView.snp.bottom).offset(Margin)
                make.width.equalTo(200)
                make.height.equalTo(20)
            })
            .sexy_config({ (label) in
                label.text = "购物车还是空的"
                label.textColor = UIColor.black
                label.font = UIFont.systemFont(ofSize: 14)
                label.textAlignment = .center
            })
        
        greetLabel = UILabel.sexy_create(self)
            .sexy_layout({ (make) in
                make.centerX.equalTo(self)
                make.top.equalTo(emptyLabel.snp.bottom).offset(5)
                make.width.equalTo(250)
                make.height.equalTo(20)
            })
            .sexy_config({ (label) in
                label.text = "说好的性福呢？说好的今夜九次郎呢？"
                label.textColor = UIColor.lightGray
                label.font = UIFont.systemFont(ofSize: 14)
                label.textAlignment = .center
            })

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

enum EmptyEnum {
    case cart
    case order
    case other
}
