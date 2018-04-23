//
//  MallGoodsView.swift
//  SexyColor.Swift
//
//  Created by xiongkai on 2017/9/12.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//

import UIKit

class MallGoodsView: UIView {
    
    fileprivate var goodsImageView: UIImageView!
    fileprivate var nameLabel: UILabel!
    fileprivate var priceLabel: UILabel!

    var adListData: AdList? {
        didSet {
            if let data = adListData {
                nameLabel.text = data.main_title
                priceLabel.text = "￥\(data.goods_price!)"
                
                let url = URL(string: data.img_url!)
                goodsImageView.kf.setImage(with: url)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setUI() {
        
        goodsImageView = UIImageView.sexy_create(self)
            .sexy_layout({ (make) in
                make.top.equalTo(self).offset(5)
                make.centerX.equalTo(self)
                make.width.height.equalTo(104)
            })
        
        nameLabel = UILabel.sexy_create(self)
            .sexy_layout({ (make) in
                make.top.equalTo(goodsImageView.snp.bottom).offset(10)
                make.centerX.equalTo(self)
                make.height.equalTo(10)
            })
            .sexy_config({ (label) in
                label.font = UIFont.systemFont(ofSize: 12)
                label.textColor = UIColor.lightGray
                label.textAlignment = .center
            })
        priceLabel = UILabel.sexy_create(self)
            .sexy_layout({ (make) in
                make.top.equalTo(nameLabel.snp.bottom).offset(5)
                make.centerX.equalTo(self)
                make.height.equalTo(10)
            })
            .sexy_config({ (label) in
                label.font = UIFont.systemFont(ofSize: 12)
                label.textColor = UIColor.black

            })
    }

}
