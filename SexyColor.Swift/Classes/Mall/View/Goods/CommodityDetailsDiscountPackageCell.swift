//
//  CommodityDetailsDiscountPackageCell.swift
//  SexyColor.Swift
//
//  Created by kayzhang on 2017/8/25.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//商品详情优惠套餐cell

import UIKit
import Kingfisher
import KingfisherWebP

class CommodityDetailsDiscountPackageCell: UITableViewCell {

    fileprivate var commodityImageView : UIImageView!//第一个商品图片
    fileprivate var commodityImageViewS : UIImageView!//第二个商品图片
    fileprivate var priceLabel : UILabel!//价格
    fileprivate var economizeLabel : UILabel!//节省金额
    fileprivate var numberLabel : UILabel!//套餐个数
    
    var numberData : Int? {
        didSet {
            //套餐个数
            numberLabel.text = NSString(format: "共%d个套餐", numberData!) as String
        }
    }
    
    var discountPackageData : PackageInfo? {
        didSet {
            if let data = discountPackageData {
                
                let listData = data.goods_list
                let firstImageData = listData![0]
                let secondImageData = listData![1]
                
                //第一张图片
                var url = URL(string: firstImageData.goods_img!)
                commodityImageView.kf.setImage(with: url,
                                               placeholder: UIImage(named: "loadingbkg"),
                                               options: [.processor(WebPProcessor.default),
                                                         .cacheSerializer(WebPSerializer.default)])
                
                //第二张图片
                url = URL(string: secondImageData.goods_img!)
                commodityImageViewS.kf.setImage(with: url,
                                               placeholder: UIImage(named: "loadingbkg"),
                                               options: [.processor(WebPProcessor.default),
                                                         .cacheSerializer(WebPSerializer.default)])
                //价格
                priceLabel.text = NSString(format: "套餐价:￥%d",data.package_price!) as String
                
                //节省金额
                economizeLabel.text = NSString(format: "  立省￥%d  ", data.package_discount!) as String
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
        let discountPackageLabel : UILabel! = UILabel//优惠套餐字样
        .sexy_create(contentView)
        .sexy_layout { (make) in
            make.top.left.equalTo(contentView).offset(Margin)
        }
        .sexy_config { (label) in
            label.text = "优惠套餐"
            label.font = UIFont.systemFont(ofSize: 15)
        }
        
        commodityImageView = UIImageView//第一张图片
        .sexy_create(contentView)
        .sexy_layout({ (make) in
            make.top.equalTo(discountPackageLabel.snp.bottom).offset(Margin)
            make.left.equalTo(discountPackageLabel)
            make.width.height.equalTo(contentView.snp.width).multipliedBy(0.25)
        })
        .sexy_config({ (imageview) in
            imageview.image = UIImage.init(named: "loadingbkg")
            imageview.contentMode = UIViewContentMode.scaleAspectFit
        })
        
        let addImageView : UIImageView! = UIImageView//加号图片
        .sexy_create(contentView)
        .sexy_layout { (make) in
            make.left.equalTo(commodityImageView.snp.right).offset(0.5 * Margin)
            make.centerY.equalTo(commodityImageView)
            make.width.height.equalTo(commodityImageView).multipliedBy(0.3)
        }
        .sexy_config({ (imageview) in
            imageview.contentMode = UIViewContentMode.scaleAspectFit
            imageview.image = UIImage(named: "num_increase")
        })

        commodityImageViewS = UIImageView//第二张图片
        .sexy_create(contentView)
        .sexy_layout({ (make) in
            make.top.width.height.equalTo(commodityImageView)
            make.left.equalTo(addImageView.snp.right).offset(0.5 * Margin)
        })
        .sexy_config({ (imageview) in
            imageview.image = UIImage.init(named: "loadingbkg")
            imageview.contentMode = UIViewContentMode.scaleAspectFit
        })
        
        priceLabel = UILabel//价格
        .sexy_create(contentView)
        .sexy_layout({ (make) in
            //未处理警告
            make.top.equalTo(commodityImageView.snp.bottom).offset(Margin)
            make.left.equalTo(commodityImageView)
            make.bottom.equalTo(contentView).offset(-Margin)
        })
        .sexy_config({ (label) in
            label.font = UIFont.systemFont(ofSize: 13)
        })
        
        economizeLabel = UILabel//剩下的金额
        .sexy_create(contentView)
        .sexy_layout({ (make) in
            make.top.equalTo(priceLabel)
            make.left.equalTo(commodityImageViewS)
        })
        .sexy_config({ (label) in
            label.font = UIFont.systemFont(ofSize: 13)
            label.textColor = UIColor.red
            label.layer.borderWidth = 1
            label.layer.borderColor = UIColor.red.cgColor
        })
    
        
        numberLabel = UILabel//套餐个数
        .sexy_create(contentView)
        .sexy_layout({ (make) in
            make.top.equalTo(discountPackageLabel)
            make.left.equalTo(commodityImageViewS.snp.right)
            make.right.equalTo(contentView)
        })
        .sexy_config({ (label) in
            label.font = UIFont.systemFont(ofSize: 13)
            label.textColor = UIColor.lightGray
        })
        
        let _ = UIImageView
        .sexy_create(contentView)
            .sexy_layout({ (make) in
                make.top.equalTo(contentView).offset(Margin)
                make.width.height.equalTo(Margin * 1.5)
                make.right.equalTo(contentView).offset(-Margin)
            })
            .sexy_config({ (imageview) in
                imageview.image = UIImage(named: "more_setup")
            })

    }

}
