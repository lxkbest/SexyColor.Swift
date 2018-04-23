//
//  CommodityDetailsNameCell.swift
//  SexyColor.Swift
//
//  Created by kayzhang on 2017/8/24.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//商品详情名称Cell

import UIKit

class CommodityDetailsNameCell: UITableViewCell {

    fileprivate var nameLabel: UILabel!//名称
    fileprivate var explainLabel: UILabel!//说明
    fileprivate var priceLabel: UILabel!//价格
    fileprivate var functionLabel: UILabel!//包邮这些功能
    fileprivate var numberLabel: UILabel!//数量
    

    var detailsNameData: GoodsInfo? {
        didSet {
            if let data = detailsNameData {
                nameLabel.text = data.goods_name
                explainLabel.text = data.seller_note
                priceLabel.text = NSString(format: "￥%d", data.app_price!) as String
                let attriMuStr = NSMutableAttributedString()
                var functionAttriStr : NSAttributedString
                if data.hot == 1 {
                    functionAttriStr = NSAttributedString(string: " 热销 ", attributes: [ NSBackgroundColorAttributeName : UIColor.red])
                    attriMuStr.append(functionAttriStr)
                    attriMuStr.append(NSAttributedString(string: String(" ")))
                }
                
                if data.vedio == 1 {
                    functionAttriStr = NSAttributedString(string: " 视屏 ", attributes: [ NSBackgroundColorAttributeName : UIColor.blue])
                    attriMuStr.append(functionAttriStr)
                    attriMuStr.append(NSAttributedString(string: String(" ")))
                    
                }
                
                if data.is_new == 1 {
                    functionAttriStr = NSAttributedString(string: " 包邮 ", attributes: [ NSBackgroundColorAttributeName : UIColor.green])
                    attriMuStr.append(functionAttriStr)
                }
                
                functionAttriStr = NSAttributedString(string: "|", attributes: [ NSBackgroundColorAttributeName : UIColor.clear, NSForegroundColorAttributeName : UIColor.clear])
                attriMuStr.append(functionAttriStr)
                
                functionLabel.attributedText = attriMuStr
                
                numberLabel.text = NSString(format: "月销%d", data.sold_num!) as String
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {//初始化
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setSubViews () {//设置视图
        
        nameLabel = UILabel//名称
        .sexy_create(contentView)//添加到视图
        .sexy_layout({ (make) in//设置相对位置
            make.top.left.equalTo(contentView).offset(Margin)
            make.right.equalTo(contentView).offset(-Margin)
        })
        .sexy_config({ (label) in//控件设置
            label.font = UIFont.systemFont(ofSize: 15)
            label.textColor = UIColor.black
        })
        
        explainLabel = UILabel//说明
            .sexy_create(contentView)//添加到视图
            .sexy_layout({ (make) in//设置相对位置
                make.top.equalTo(nameLabel.snp.bottom).offset(0.5 * Margin)//snp -> mas_
                make.left.equalTo(nameLabel)
                make.right.equalTo(nameLabel)
            })
            .sexy_config({ (label) in//控件设置
                label.font = UIFont.systemFont(ofSize: 13)
                label.textColor = UIColor.lightGray
            })
        
        
        priceLabel = UILabel//价格
        .sexy_create(contentView)
        .sexy_layout({ (make) in
            make.top.equalTo(explainLabel.snp.bottom).offset(0.5 * Margin)
            make.left.equalTo(explainLabel)
            make.bottom.equalTo(contentView).offset(-Margin)
        })
        .sexy_config({ (label) in
            label.font = UIFont.systemFont(ofSize: 18)
            label.textColor = UIColor.red
        })
        
        functionLabel = UILabel//包邮这些功能
        .sexy_create(contentView)
        .sexy_layout({ (make) in
            make.centerY.equalTo(priceLabel)
            make.left.equalTo(priceLabel.snp.right).offset(0.5 * Margin)
        })
        .sexy_config({ (label) in
            label.textColor = UIColor.white
            label.font = UIFont.systemFont(ofSize: 12)
        })
        
        numberLabel = UILabel//销量
            .sexy_create(contentView)
            .sexy_layout({ (make) in
                make.centerY.equalTo(priceLabel)
                make.right.equalTo(contentView).offset(-Margin)
            })
            .sexy_config({ (label) in
                label.font = UIFont.systemFont(ofSize: 13)
                label.textAlignment = NSTextAlignment.right
                label.textColor = UIColor.lightGray
            })
    }

}
