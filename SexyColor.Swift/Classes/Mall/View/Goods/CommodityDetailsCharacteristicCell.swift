//
//  CommodityDetailsCharacteristicCell.swift
//  SexyColor.Swift
//
//  Created by kayzhang on 2017/8/25.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//商品详情特性 正品保证 私密配送  支持货到付款 之类的

import UIKit

class CommodityDetailsCharacteristicCell: UITableViewCell {

    fileprivate var titleLabel : UILabel!
    
    var titleArray : NSArray = [] {
        didSet {
            let attriMuStr = NSMutableAttributedString()
            for str in titleArray {
                let attriMuStrS = NSMutableAttributedString(string: NSString(format: " %@  ", str as! String) as String, attributes: nil)
                let smileImage : UIImage = UIImage(named: "Goods_small_right")!
                let textAttachment : NSTextAttachment = NSTextAttachment()
                textAttachment.image = smileImage
                textAttachment.bounds = CGRect(x: 0, y: 0, width: 10, height: 10)
                attriMuStrS.insert(NSAttributedString(attachment: textAttachment), at: 0)
                attriMuStr.append(attriMuStrS);
            }
            titleLabel.attributedText = attriMuStr
        }
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setSubViews() {
        titleLabel = UILabel//显示的文本
        .sexy_create(contentView)
        .sexy_layout({ (make) in
            make.top.left.equalTo(contentView).offset(Margin)
            make.right.bottom.equalTo(contentView).offset(-Margin)
        })
        .sexy_config({ (label) in
            label.font = UIFont.systemFont(ofSize: 13)
        })
        
        let _ = UIView
            .sexy_create(contentView)
            .sexy_layout({ (make) in
                make.top.left.right.equalTo(contentView)
                make.height.equalTo(1)
            })
            .sexy_config({ (view) in
                view.backgroundColor = AthensGrayColor
            })
    }
}
