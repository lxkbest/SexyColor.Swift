//
//  MemberPromptCell.swift
//  SexyColor.Swift
//
//  Created by kayzhang on 2017/8/25.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//

import UIKit

class MemberPromptCell: UITableViewCell {
    
    fileprivate var titleLabel : UILabel!//文本
    var titleStr : NSString = "" {
        didSet {
            let attriMuStr = NSMutableAttributedString(string: NSString(format: " %@", titleStr as String) as String , attributes: nil)
            let smileImage : UIImage = UIImage(named: "Goods_small_flag")!
            let textAttachment : NSTextAttachment = NSTextAttachment()
            textAttachment.image = smileImage
            textAttachment.bounds = CGRect(x: 0, y: 0, width: 10, height: 10)
            attriMuStr.insert(NSAttributedString(attachment: textAttachment), at: 0)
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
        titleLabel = UILabel//文本
        .sexy_create(contentView)
        .sexy_layout({ (make) in
            make.top.left.equalTo(contentView).offset(Margin)
            make.right.equalTo(contentView)
            make.bottom.equalTo(contentView).offset(-Margin)
        })
        .sexy_config({ (label) in
            label.font = UIFont.systemFont(ofSize: 13)
            label.adjustsFontSizeToFitWidth = true
            label.minimumScaleFactor = 0.6
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
