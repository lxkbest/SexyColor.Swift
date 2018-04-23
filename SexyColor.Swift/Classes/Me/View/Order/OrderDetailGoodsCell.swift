//
//  OrderDetailGoodsCell.swift
//  SexyColor.Swift
//
//  Created by xiongkai on 2017/9/15.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//

import UIKit
import KingfisherWebP

class OrderDetailGoodsCell: UITableViewCell {

    
    fileprivate var goodsImageView: UIImageView!
    fileprivate var goodsNameLabel: UILabel!
    fileprivate var goodsSdkLabel: UILabel!
    fileprivate var goodsPriceLabel: UILabel!
    fileprivate var lineView: UIView!
    
    var goodsData: OrderGoods? {
        didSet {
            if let data = goodsData {
                let url = URL(string: data.goods_img!)
                goodsImageView.kf.setImage(with: url, placeholder: UIImage(named: "loadingbkg"), options: [.processor(WebPProcessor.default), .cacheSerializer(WebPSerializer.default)])
                
                goodsNameLabel.text = data.goods_name
                goodsPriceLabel.text = "\(data.app_price!)x\(data.goods_number!)"
                goodsSdkLabel.text = data.goods_attr
                
            }
        }
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    fileprivate func setSubViews() {
    
        goodsImageView = UIImageView.sexy_create(contentView)
            .sexy_layout({ (make) in
                make.centerY.equalTo(contentView)
                make.left.equalTo(contentView).offset(10)
                make.width.height.equalTo(50)
            })
        
        goodsPriceLabel = UILabel.sexy_create(contentView)
            .sexy_layout({ (make) in
                make.top.equalTo(goodsImageView)
                make.right.equalTo(contentView).offset(-10)
                make.height.equalTo(10)
                make.width.greaterThanOrEqualTo(50)
            })
            .sexy_config({ (label) in
                label.font = UIFont.systemFont(ofSize: 12)
                label.textAlignment = .right
            })
        
        goodsNameLabel = UILabel.sexy_create(contentView)
            .sexy_layout({ (make) in
                make.left.equalTo(goodsImageView.snp.right).offset(10)
                make.right.equalTo(goodsPriceLabel.snp.left).offset(-10)
                make.top.equalTo(goodsImageView)
                make.height.greaterThanOrEqualTo(10)
            })
            .sexy_config({ (label) in
                label.font = UIFont.systemFont(ofSize: 14)
                label.textAlignment = .left
                label.numberOfLines = 2
                label.lineBreakMode = .byTruncatingTail
            })
        
        goodsSdkLabel = UILabel.sexy_create(contentView)
            .sexy_layout({ (make) in
                make.left.equalTo(goodsImageView.snp.right).offset(10)
                make.bottom.equalTo(goodsImageView)
                make.height.equalTo(10)
                make.width.greaterThanOrEqualTo(20)
            })
            .sexy_config({ (label) in
                label.font = UIFont.systemFont(ofSize: 12)
                label.textColor = UIColor.lightGray
                label.textAlignment = .left
                label.numberOfLines = 2
                label.lineBreakMode = .byTruncatingTail
            })
        
        lineView = UIView.sexy_create(contentView)
            .sexy_layout({ (make) in
                make.left.right.equalTo(contentView)
                make.height.equalTo(1)
                make.bottom.equalTo(contentView)
            })
            .sexy_config({ (view) in
                view.backgroundColor = GlobalColor
            })

    }

}
