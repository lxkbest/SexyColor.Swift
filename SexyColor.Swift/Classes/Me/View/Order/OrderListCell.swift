//
//  OrderListCell.swift
//  SexyColor.Swift
//
//  Created by xiongkai on 2017/9/14.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//

import Foundation
import KingfisherWebP

class OrderListCell : UITableViewCell {

    fileprivate var containerView : UIView!
    fileprivate var orderSNLabel: UILabel!
    fileprivate var orderStateLabel: UILabel!
    fileprivate var topLineView: UIView!
    fileprivate var bottomLineView: UIView!
    
    fileprivate var totleCountLabel: UILabel!
    fileprivate var totlePriceLabel: UILabel!
    
    fileprivate var payBtn: UIButton!
    
    var orderListData : OrderList? {
        didSet {
            if let data = orderListData {
                orderSNLabel.text = "订单号:\(data.order_sn!)"
                orderStateLabel.text = "\(data.order_status!)"
                totleCountLabel.text = "共\(data.order_goods!.count)件商品"
                totlePriceLabel.text = "合计:￥\(data.order_amount!.toString())"
                
                if data.order_goods?.count == 1  {
                    let goods = data.order_goods?.first
                    
                    let goodsImgView = UIImageView.sexy_create(containerView)
                        .sexy_layout({ (make) in
                            make.top.equalTo(topLineView).offset(5)
                            make.bottom.equalTo(bottomLineView).offset(-5)
                            make.left.equalTo(orderSNLabel)
                            make.width.lessThanOrEqualTo(60)
                        })
                        .sexy_config({ (imageView) in
                            imageView.contentMode = .scaleToFill
                            let url = URL(string: goods!.goods_img!)
                            imageView.kf.setImage(with: url, placeholder: UIImage(named: "loadingbkg"), options: [.processor(WebPProcessor.default), .cacheSerializer(WebPSerializer.default)])
                        })
                    
                    let goodsPriceLabel = UILabel.sexy_create(containerView)
                        .sexy_layout({ (make) in
                            make.top.equalTo(goodsImgView)
                            make.height.greaterThanOrEqualTo(10)
                            make.width.equalTo(100)
                            make.right.equalTo(orderStateLabel)
                        })
                        .sexy_config({ (label) in
                            label.text = "￥\(goods!.app_price!.toString())x\(goods!.goods_number!)"
                            label.font = UIFont.systemFont(ofSize: 12)
                            label.textAlignment = .right
                        })
                    
                    let _ = UILabel.sexy_create(containerView)
                        .sexy_layout({ (make) in
                            make.top.equalTo(goodsPriceLabel)
                            make.left.equalTo(goodsImgView.snp.right).offset(10)
                            make.right.equalTo(goodsPriceLabel.snp.left).offset(-20)
                            make.height.greaterThanOrEqualTo(10)
                        })
                        .sexy_config({ (label) in
                            label.lineBreakMode = .byTruncatingTail
                            label.numberOfLines = 2
                            label.text = goods?.goods_name
                            label.font = UIFont.systemFont(ofSize: 12)
                        })
                    
                } else if data.order_goods!.count > 1 {
                    var imgX = 0
                    for i in 0..<data.order_goods!.count {
                        if i > 2 {
                            let _ = UIImageView.sexy_create(containerView)
                                .sexy_layout({ (make) in
                                    make.top.equalTo(topLineView).offset(5)
                                    make.bottom.equalTo(bottomLineView).offset(-5)
                                    make.left.equalTo(imgX + 70)
                                    make.width.lessThanOrEqualTo(60)
                                })
                                .sexy_config({ (imageView) in
                                    imageView.contentMode = .scaleAspectFit
                                    imageView.image = UIImage(named: "more_commodity")
                                })
                            break
                        }
                        let goods = data.order_goods![i]
                        
                        imgX = 5 + 70 * i
                        
                        let _ = UIImageView.sexy_create(containerView)
                            .sexy_layout({ (make) in
                                make.top.equalTo(topLineView).offset(5)
                                make.bottom.equalTo(bottomLineView).offset(-5)
                                make.left.equalTo(imgX)
                                make.width.lessThanOrEqualTo(60)
                            })
                            .sexy_config({ (imageView) in
                                imageView.contentMode = .scaleToFill
                                let url = URL(string: goods.goods_img!)
                                imageView.kf.setImage(with: url, placeholder: UIImage(named: "loadingbkg"), options: [.processor(WebPProcessor.default), .cacheSerializer(WebPSerializer.default)])
                            })
                    }
                }
            }
        }
    }

    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = GlobalColor
        selectionStyle = .none
        setSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setSubViews() {
        
        containerView = UIView.sexy_create(contentView)
            .sexy_layout({ (make) in
                make.left.right.equalTo(contentView)
                make.top.equalTo(contentView).offset(10)
                make.bottom.equalTo(contentView)
            })
            .sexy_config({ (view) in
                view.backgroundColor = UIColor.white
            })
        
        
        topLineView = UIView.sexy_create(containerView)
            .sexy_layout({ (make) in
                make.left.right.equalTo(containerView)
                make.centerY.equalTo(containerView).multipliedBy(0.5)
                make.height.equalTo(1)
            })
            .sexy_config({ (view) in
                view.backgroundColor = GlobalColor
            })
        
        bottomLineView = UIView.sexy_create(containerView)
            .sexy_layout({ (make) in
                make.left.right.equalTo(containerView)
                make.centerY.equalTo(containerView).multipliedBy(1.5)
                make.height.equalTo(1)
            })
            .sexy_config({ (view) in
                view.backgroundColor = GlobalColor
            })
        
        orderSNLabel = UILabel.sexy_create(containerView)
            .sexy_layout({ (make) in
                make.left.equalTo(containerView).offset(5)
                make.centerY.equalTo(topLineView.snp.top).multipliedBy(0.5)
                make.width.greaterThanOrEqualTo(50)
                make.height.equalTo(10)
            })
            .sexy_config({ (label) in
                label.font = UIFont.systemFont(ofSize: 12)
                label.textColor = UIColor.lightGray
                label.textAlignment = .left
            })
        
        orderStateLabel = UILabel.sexy_create(containerView)
            .sexy_layout({ (make) in
                make.right.equalTo(containerView).offset(-5)
                make.top.equalTo(orderSNLabel)
                make.width.greaterThanOrEqualTo(50)
                make.height.equalTo(10)
            })
            .sexy_config({ (label) in
                label.font = UIFont.systemFont(ofSize: 12)
                label.textAlignment = .right
            })
        
        totleCountLabel = UILabel.sexy_create(containerView)
            .sexy_layout({ (make) in
                make.left.equalTo(orderSNLabel)
                make.centerY.equalTo(bottomLineView.snp.top).multipliedBy(1.15)
                make.width.greaterThanOrEqualTo(50)
                make.height.equalTo(10)
            })
            .sexy_config({ (label) in
                label.font = UIFont.systemFont(ofSize: 12)
                label.textAlignment = .right
                label.textColor = UIColor.lightGray
            })
        
        totlePriceLabel = UILabel.sexy_create(containerView)
            .sexy_layout({ (make) in
                make.left.equalTo(totleCountLabel.snp.right).offset(5)
                make.top.equalTo(totleCountLabel)
                make.width.greaterThanOrEqualTo(50)
                make.height.equalTo(10)
            })
            .sexy_config({ (label) in
                label.font = UIFont.systemFont(ofSize: 12)
                label.textAlignment = .right
                label.textColor = UIColor.red
            })
        
        payBtn = UIButton.sexy_create(containerView)
            .sexy_layout({ (make) in
                make.right.equalTo(orderStateLabel)
                make.top.equalTo(bottomLineView).offset(5)
                make.bottom.equalTo(containerView).offset(-5)
                make.width.equalTo(60)
            })
            .sexy_config({ (btn) in
                btn.setTitle("立即支付", for: .normal)
                btn.setTitleColor(UIColor.red, for: .normal)
                btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
                btn.layer.borderColor = UIColor.red.cgColor
                btn.layer.borderWidth = 1
                btn.layer.cornerRadius = 2
                btn.layer.masksToBounds = true
            })
    }
}
