//
//  GoodsListCollectionViewCell.swift
//  SexyColor.Swift
//
//  Created by kayzhang on 2017/9/11.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//商品列表列表形式cell

import UIKit
import Kingfisher
import KingfisherWebP

class GoodsListCollectionViewCell: UICollectionViewCell {
    
    fileprivate var imageView : UIImageView!
    fileprivate var name : UILabel!
    fileprivate var number : UILabel!
    fileprivate var price : UILabel!
    fileprivate var functionLabel: UILabel!
    
    var GoodsListCellData : goods_list? {
        didSet {
            if let data = GoodsListCellData {
                
                let url = URL(string: data.img_url!)
                imageView.kf.setImage(with: url,
                                      placeholder: UIImage(named: "loadingbkg"),
                                      options: [.processor(WebPProcessor.default),
                                                .cacheSerializer(WebPSerializer.default)])
                
                name.text = data.goods_name
                
                let str = "月销: " + "\(data.sold_num!)" + " | 评论" + "\(data.comment_num!)" + "条"
                number.text = str
                
                
                price.text = NSString(format: "￥%.2f",(data.app_price)!) as String
                
                let attriMuStr = NSMutableAttributedString()
                var functionAttriStr : NSAttributedString
                if data.hot == 1 {
                    attriMuStr.append(NSAttributedString(string: String(" ")))
                    functionAttriStr = NSAttributedString(string: " 热销 ", attributes: [ NSBackgroundColorAttributeName : UIColor.red, NSForegroundColorAttributeName : UIColor.white])
                    attriMuStr.append(functionAttriStr)
                }
                
                if data.vedio == 1 {
                    attriMuStr.append(NSAttributedString(string: String(" ")))
                    functionAttriStr = NSAttributedString(string: " 视屏 ", attributes: [ NSBackgroundColorAttributeName : UIColor.blue, NSForegroundColorAttributeName : UIColor.white])
                    attriMuStr.append(functionAttriStr)
                }
                
                functionAttriStr = NSAttributedString(string: "|", attributes: [ NSBackgroundColorAttributeName : UIColor.clear, NSForegroundColorAttributeName : UIColor.clear])
                attriMuStr.append(functionAttriStr)
                
                if data.is_free_shipping == 1 {
                    let free = NSAttributedString(string: "免运费", attributes: [ NSFontAttributeName : UIFont.systemFont(ofSize: 12), NSForegroundColorAttributeName : UIColor.lightGray])
                    attriMuStr.append(free)
                }
                
                functionLabel.attributedText = attriMuStr
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
            make.top.equalTo(contentView).offset(Margin * 0.3)
            make.left.equalTo(contentView)
            make.width.equalTo(contentView.snp.height)
            make.bottom.equalTo(contentView).offset(-Margin * 0.3)
        })
        .sexy_config({ (imageView) in
            imageView.contentMode = .scaleAspectFit
        })
        
        name = UILabel.sexy_create(contentView)
        .sexy_layout({ (make) in
            make.top.equalTo(contentView).offset(Margin)
            make.left.equalTo(imageView.snp.right).offset(Margin * 0.5)
            make.right.equalTo(contentView).offset(-Margin)
        })
        .sexy_config({ (label) in
            label.font = UIFont.systemFont(ofSize: 15)
            label.numberOfLines = 0
        })
        
        number = UILabel.sexy_create(contentView)
        .sexy_layout({ (make) in
            make.top.equalTo(imageView.snp.centerY)
            make.left.equalTo(name)
            make.right.equalTo(contentView).offset(-Margin)
        })
        .sexy_config({ (label) in
            label.font = UIFont.systemFont(ofSize: 13)
            label.textColor = UIColor.lightGray
        })
        
        price = UILabel.sexy_create(contentView)
        .sexy_layout({ (make) in
            make.left.equalTo(name)
            make.bottom.equalTo(imageView)
        })
        .sexy_config({ (label) in
            label.textColor = UIColor.red
            label.font = UIFont.systemFont(ofSize: 15)
        })
        
        functionLabel = UILabel.sexy_create(contentView)
            .sexy_layout({ (make) in
                make.centerY.equalTo(price)
                make.left.equalTo(price.snp.right)
            })
        .sexy_config({ (label) in
            label.font = UIFont.systemFont(ofSize: 13)
        })
        
        
        let _ = UIView.sexy_create(contentView)
        .sexy_layout { (make) in
            make.left.right.bottom.equalTo(contentView)
            make.height.equalTo(1)
        }
        .sexy_config { (view) in
            view.backgroundColor = AthensGrayColor
        }
        
        
        
    }
    
}
