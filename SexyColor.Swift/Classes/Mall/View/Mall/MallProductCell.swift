//
//  MallProductCell.swift
//  SexyColor.Swift
//
//  Created by xiongkai on 2017/9/11.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//

import UIKit

class MallProductCell: UICollectionViewCell {
    
    fileprivate var imageView: UIImageView!
    fileprivate var titleLabel: UILabel!
    fileprivate var priceLabel: UILabel!
    fileprivate var soldNumLable: UILabel!
    
    
    var productData: ProductRecommendation? {
        didSet {
            if let data = productData {
                let url = URL(string: data.img_url!)
                imageView.kf.setImage(with: url)
                
                titleLabel.text = data.goods_name
                priceLabel.text = "￥\(data.app_price!)"
                soldNumLable.text = "销量\(data.sold_num!)"
            }
        }
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        setSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setSubViews() {
        
        imageView = UIImageView.sexy_create(contentView)
            .sexy_layout({ (make) in
                make.height.equalTo(ScreenWidth * 0.5)
                make.width.equalTo(ScreenWidth * 0.5)
                make.top.leading.equalTo(contentView)
            })
        
        titleLabel = UILabel.sexy_create(contentView)
            .sexy_layout({ (make) in
                make.top.equalTo(imageView.snp.bottom).offset(1)
                make.leading.equalTo(imageView).offset(2)
                make.trailing.equalTo(imageView).offset(-2)
                make.height.greaterThanOrEqualTo(10)
            })
            .sexy_config({ (label) in
                label.font = UIFont.systemFont(ofSize: 12)
                label.textColor = UIColor.black
                label.lineBreakMode = .byTruncatingTail
                label.numberOfLines = 2
            })
        
        
        priceLabel = UILabel.sexy_create(contentView)
            .sexy_layout({ (make) in
                make.bottom.equalTo(contentView).offset(-5)
                make.leading.equalTo(imageView)
                make.width.greaterThanOrEqualTo(20)
                make.height.equalTo(10)
            })
            .sexy_config({ (label) in
                label.font = UIFont.systemFont(ofSize: 12)
                label.textColor = UIColor.red
                label.textAlignment = .left
            })

        soldNumLable = UILabel.sexy_create(contentView)
            .sexy_layout({ (make) in
                make.bottom.equalTo(contentView).offset(-5)
                make.trailing.equalTo(imageView).offset(-5)
                make.width.greaterThanOrEqualTo(20)
                make.height.equalTo(10)
            })
            .sexy_config({ (label) in
                label.font = UIFont.systemFont(ofSize: 12)
                label.textColor = UIColor.lightGray
                label.textAlignment = .right
            })
    }
    
}
