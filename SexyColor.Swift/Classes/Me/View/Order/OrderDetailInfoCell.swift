//
//  OrderDetailInfoCell.swift
//  SexyColor.Swift
//
//  Created by xiongkai on 2017/9/15.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//

import UIKit

class OrderDetailInfoCell: UITableViewCell {

    
    fileprivate var payTimeLabel: UILabel!
    fileprivate var orderSNLabel: UILabel!
    fileprivate var payMethodLabel: UILabel!
    
    var tupleData: (time: String? , sn: String? , method: Int?)? {
        didSet {
            if let data = tupleData {
                if let time = data.time, let sn = data.sn {
                    payTimeLabel.text = "下单日期：\(time)"
                    orderSNLabel.text = "订单编号：\(sn)"
                }
                
                var methodStr = ""
                if let newMethod = data.method {
                    if newMethod == 4 {
                        methodStr = "支付宝"
                    } else if newMethod == 12 {
                        methodStr = "微信支付"
                    }
                    payMethodLabel.text = "支付方式：\(methodStr)"

                }
                
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
        
        payTimeLabel = UILabel.sexy_create(self)
            .sexy_layout({ (make) in
                make.left.equalTo(contentView).offset(Margin)
                make.top.equalTo(contentView).offset(Margin)
                make.width.greaterThanOrEqualTo(50)
                make.height.equalTo(10)
            })
            .sexy_config({ (label) in
                label.font = UIFont.systemFont(ofSize: 14)
            })
        
        orderSNLabel = UILabel.sexy_create(self)
            .sexy_layout({ (make) in
                make.left.equalTo(contentView).offset(Margin)
                make.top.equalTo(payTimeLabel.snp.bottom).offset(Margin)
                make.width.greaterThanOrEqualTo(50)
                make.height.equalTo(10)
            })
            .sexy_config({ (label) in
                label.font = UIFont.systemFont(ofSize: 14)
            })

        
        payMethodLabel = UILabel.sexy_create(self)
            .sexy_layout({ (make) in
                make.left.equalTo(contentView).offset(Margin)
                make.top.equalTo(orderSNLabel.snp.bottom).offset(Margin)
                make.width.greaterThanOrEqualTo(50)
                make.height.equalTo(10)
            })
            .sexy_config({ (label) in
                label.font = UIFont.systemFont(ofSize: 14)
            })

        
    }
    
}
