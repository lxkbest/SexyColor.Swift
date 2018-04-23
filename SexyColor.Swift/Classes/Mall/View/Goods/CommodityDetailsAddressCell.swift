//
//  CommodityDetailsAddressCell.swift
//  SexyColor.Swift
//
//  Created by kayzhang on 2017/8/25.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//商品详情地址Cell

import UIKit

class CommodityDetailsAddressCell: UITableViewCell {

    fileprivate var forAddressLabel : UILabel!//商家地址
    fileprivate var toAddressLabel : UILabel!//客户地址
    fileprivate var timeLabel : UILabel!//时间
    
    var detailsAddressData : CommodityDetailsAddressModel? {
        didSet {
            if let data = detailsAddressData {
                
                //商家地址
                let attriMuStr = NSMutableAttributedString(string: NSString(format: " %@", data.forAddress as String) as String, attributes: nil)
                let attriStr : NSAttributedString = NSAttributedString(string: "至", attributes: [NSForegroundColorAttributeName : UIColor.lightGray])
                let smileImage : UIImage = UIImage(named: "map")!
                let textAttachment : NSTextAttachment = NSTextAttachment()
                textAttachment.image = smileImage
                textAttachment.bounds = CGRect(x: 0, y: -5, width: 10, height: 14)
                attriMuStr.insert(NSAttributedString(attachment: textAttachment), at: 0)
                attriMuStr.append(attriStr)
                
                forAddressLabel.attributedText = attriMuStr
                toAddressLabel.text = data.toAddress as String
                timeLabel.text = data.time as String
                
                //客户地址
                toAddressLabel.text = data.toAddress as String
                
                //时间
                timeLabel.text = NSString(format: "预计%@送达", data.time) as String
                
            }
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
        let sendLabel : UILabel! = UILabel//发送 字样
        .sexy_create(contentView)
        .sexy_layout { (make) in
            make.top.left.equalTo(contentView).offset(Margin)
        }
        .sexy_config { (label) in
            label.text = "发送"
            label.font = UIFont.systemFont(ofSize: 14)
            label.textColor = UIColor.lightGray
        }
        
        forAddressLabel = UILabel//商家地址+至 字样
        .sexy_create(contentView)
        .sexy_layout({ (make) in
            make.centerY.equalTo(sendLabel)
            make.left.equalTo(sendLabel.snp.right).offset(Margin)
        })
        .sexy_config({ (label) in
            label.textColor = UIColor.red
            label.font = UIFont.systemFont(ofSize: 13)
        })
        
        let _ = UIImageView
            .sexy_create(contentView)
            .sexy_layout({ (make) in
                make.centerY.equalTo(contentView)
                make.width.height.equalTo(Margin * 1.5)
                make.right.equalTo(contentView).offset(-Margin)
            })
            .sexy_config({ (imageview) in
                imageview.image = UIImage(named: "more_setup")
            })
        
        toAddressLabel = UILabel//客户地址
        .sexy_create(contentView)
        .sexy_layout({ (make) in
            make.top.equalTo(forAddressLabel)
            make.left.equalTo(forAddressLabel.snp.right)
            make.width.equalTo(contentView).multipliedBy(0.5)
        })
        .sexy_config({ (label) in
            label.numberOfLines = 0
            label.font = UIFont.systemFont(ofSize: 13)
        })
        
        timeLabel = UILabel//时间
        .sexy_create(contentView)
        .sexy_layout({ (make) in
            make.top.equalTo(toAddressLabel.snp.bottom).offset(Margin * 0.5)
            make.left.equalTo(forAddressLabel)
            make.bottom.equalTo(contentView).offset(-Margin)
        })
        .sexy_config({ (label) in
            label.textColor = UIColor.lightGray
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
