//
//  GoodsGridCollectionViewCell.swift
//  SexyColor.Swift
//
//  Created by kayzhang on 2017/9/11.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//商品列表网格形式cell

import UIKit
import Kingfisher
import KingfisherWebP

class GoodsGridCollectionViewCell: UICollectionViewCell {
    
    fileprivate var imageView : UIImageView!
    fileprivate var name : UILabel!
    fileprivate var number : UILabel!
    fileprivate var price : UILabel!
    
    var GoodsGridCellData : goods_list? {
        didSet {
            if let data = GoodsGridCellData {
                let url = URL(string: data.img_url!)
                imageView.kf.setImage(with: url,
                                      placeholder: UIImage(named: "loadingbkg"),
                                      options: [.processor(WebPProcessor.default),
                                                .cacheSerializer(WebPSerializer.default)])
                
                name.text = data.goods_name
                
                price.text = NSString(format: "￥%.2f",(data.app_price)!) as String
                
                number.text = NSString(format: "销量 %d",(data.sold_num)!) as String
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setSubViews() {
        
        self.backgroundColor = UIColor.white
        
        imageView = UIImageView.sexy_create(contentView)
        .sexy_layout({ (make) in
            make.left.top.right.equalTo(contentView)
            make.height.equalTo(contentView.snp.width)
        })
        .sexy_config({ (imageView) in
            imageView.contentMode = .scaleAspectFit
        })
        
        name = UILabel.sexy_create(contentView)
        .sexy_layout({ (make) in
            make.top.equalTo(imageView.snp.bottom).offset(Margin)
            make.right.equalTo(contentView).offset(-Margin)
            make.left.equalTo(contentView).offset(Margin)
        })
        .sexy_config({ (label) in
            label.numberOfLines = 2
            label.font = UIFont.systemFont(ofSize: 15)
        })
        
        price = UILabel.sexy_create(contentView)
        .sexy_layout({ (make) in
            make.left.equalTo(contentView).offset(Margin)
            make.bottom.equalTo(contentView).offset(-Margin)
        })
        .sexy_config({ (label) in
            label.font = UIFont.systemFont(ofSize: 14)
            label.textColor = UIColor.red
        })
        
        number = UILabel.sexy_create(contentView)
        .sexy_layout({ (make) in
            make.right.equalTo(contentView).offset(-Margin)
            make.bottom.equalTo(price)
        })
        .sexy_config({ (label) in
            label.font = UIFont.systemFont(ofSize: 14)
            label.textColor = UIColor.lightGray
        })
        
    }
    
}
