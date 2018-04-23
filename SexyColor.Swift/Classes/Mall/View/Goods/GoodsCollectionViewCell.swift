//
//  GoodsCollectionViewCell.swift
//  SexyColor.Swift
//
//  Created by kayzhang on 2017/8/30.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//推荐商品cell

import UIKit
import Kingfisher
import KingfisherWebP

class GoodsCollectionViewCell: UICollectionViewCell {
    
    fileprivate var imageView : UIImageView!
    fileprivate var nameLabel : UILabel!
    fileprivate var priceLabel : UILabel!
    
    var GoodsData : RecommendGoods? {
        didSet {
            if let data = GoodsData {
                let url = URL(string: data.goods_img!)
                imageView.kf.setImage(with: url,
                                      placeholder: UIImage(named: "loadingbkg"),
                                      options: [.processor(WebPProcessor.default),
                                                .cacheSerializer(WebPSerializer.default)])
                
                nameLabel.text = data.goods_name!
                
                priceLabel.text = NSString.init(format: "￥%.2f", Float(data.app_price!)) as String
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
        imageView = UIImageView.sexy_create(contentView)
        .sexy_layout({ (make) in
            make.top.left.right.equalTo(contentView)
            make.height.equalTo(contentView.snp.width)
        })
        .sexy_config({ (imageView) in
            imageView.contentMode = .scaleAspectFit
            imageView.backgroundColor = UIColor.green
        })
        
        nameLabel = UILabel.sexy_create(contentView)
        .sexy_layout({ (make) in
            make.top.equalTo(imageView.snp.bottom)
            make.left.right.equalTo(imageView)
        })
        .sexy_config({ (label) in
            label.font = UIFont.systemFont(ofSize: 15)
            label.textColor = UIColor.gray
        })
        
        priceLabel = UILabel.sexy_create(contentView)
        .sexy_layout({ (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(0.5 * Margin)
            make.left.right.equalTo(imageView)
        })
        .sexy_config({ (label) in
            label.font = UIFont.systemFont(ofSize: 13)
        })
        
        self.contentView.snp.makeConstraints { (make) in
            make.left.top.equalTo(0)
            make.width.equalTo((ScreenWidth - 4 * Margin) / 3)
            make.bottom.equalTo(priceLabel.snp.bottom)
        }
    }
    
    private func verifyUrl(str:String) -> Bool {
        if let url = NSURL(string: str) {
            return UIApplication.shared.canOpenURL(url as URL)
        }
        return false
    }
}
