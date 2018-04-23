//
//  ShopcartCell.swift
//  SexyColor.Swift
//
//  Created by xiongkai on 2017/8/21.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher
import KingfisherWebP

class ShopcartCell: UITableViewCell {

    fileprivate var selectImageView: UIImageView!
    fileprivate var goodsImageView: UIImageView!
    fileprivate var goodsNameLabel: UILabel!
    fileprivate var goodsPriceLabel: UILabel!
    fileprivate var goodsSkuLabel: UILabel!
    
    fileprivate var goodsDeleteImageView: UIImageView!
    fileprivate var goodsNumIncreaseBtn: UIButton!
    fileprivate var goodsNumReduceBtn: UIButton!
    fileprivate var goodsNumberLabel: UILabel!
    
    weak var delegate : ShopcartDelegate?

    var CartsListData : CartsList? {
        didSet {
            if let data = CartsListData {
                let url = URL(string: data.goods_img!)
                goodsImageView.kf.setImage(with: url, placeholder: UIImage(named: "loadingbkg"), options: [.processor(WebPProcessor.default), .cacheSerializer(WebPSerializer.default)])
                goodsNameLabel.text = data.goods_name
                
 
                if let number = data.goods_number, let print = data.app_price  {
                    goodsNumberLabel.text = "\(number)"
                    
                    let totolPrice = Double(number) * print
                    goodsPriceLabel.text = "￥\(totolPrice.toString())"
 
                }
                
                
                if data.is_check! && data.is_expiry! {
                    selectImageView.image = UIImage(named: "radio_selected")
                } else if data.is_expiry! == false {
                    selectImageView.image = UIImage(named: "radioFailure")
                } else {
                    selectImageView.image = UIImage(named: "radio")
                }
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
        
        selectImageView = UIImageView.sexy_create(contentView)
            .sexy_layout({ (make) in
                make.centerY.equalTo(contentView)
                make.leading.equalTo(contentView).offset(Margin)
                make.width.height.equalTo(22)
            })
            .sexy_config({ (imageView) in
                imageView.image = UIImage(named: "radio")
                imageView.isUserInteractionEnabled = true
                imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(checkGoods(sender:))))
            })
        
        goodsImageView = UIImageView.sexy_create(contentView)
            .sexy_layout({ (make) in
                make.top.equalTo(contentView).offset(Margin)
                make.leading.equalTo(selectImageView.snp.trailing).offset(Margin)
                make.bottom.equalTo(contentView).offset(-Margin)
                make.width.equalTo(80)
            })
        
        goodsPriceLabel = UILabel.sexy_create(contentView)
            .sexy_layout({ (make) in
                make.top.equalTo(goodsImageView)
                make.trailing.equalTo(contentView).offset(-Margin)
                make.width.lessThanOrEqualTo(80)
                make.height.equalTo(20)
            })
            .sexy_config({ (label) in
                label.textAlignment = .right
                label.font = UIFont.systemFont(ofSize: 12)
            })
        
        goodsNameLabel = UILabel.sexy_create(contentView)
            .sexy_layout({ (make) in
                make.top.equalTo(goodsImageView)
                make.leading.equalTo(goodsImageView.snp.trailing).offset(Margin)
                make.trailing.equalTo(goodsPriceLabel.snp.leading).offset(-BigMargin)
                make.height.greaterThanOrEqualTo(20)
            })
            .sexy_config({ (label) in
                label.textAlignment = .left
                label.font = UIFont.systemFont(ofSize: 12)
                label.numberOfLines = 2
                label.lineBreakMode = .byTruncatingTail
            })
        
        goodsSkuLabel = UILabel.sexy_create(contentView)
            .sexy_layout({ (make) in
                make.top.equalTo(goodsNameLabel.snp.bottom).offset(5)
                make.leading.equalTo(goodsNameLabel)
                make.width.equalTo(60)
                make.height.equalTo(20)
            })
            .sexy_config({ (label) in
                label.textAlignment = .left
                label.font = UIFont.systemFont(ofSize: 12)
                label.numberOfLines = 0
            })
        
        goodsNumIncreaseBtn = UIButton.sexy_create(contentView)
            .sexy_layout({ (make) in
                make.bottom.equalTo(goodsImageView)
                make.leading.equalTo(goodsNameLabel)
                make.width.height.equalTo(20)
            })
            .sexy_config({ (btn) in
                btn.backgroundColor = GlobalColor
                btn.setImage(UIImage(named: "num_increase"), for: .normal)
                btn.imageView?.contentMode = .center
                btn.addTarget(self, action: #selector(plusGoods), for: .touchUpInside)
            })
        
        goodsNumberLabel = UILabel.sexy_create(contentView)
            .sexy_layout({ (make) in
                make.bottom.equalTo(goodsNumIncreaseBtn)
                make.leading.equalTo(goodsNumIncreaseBtn.snp.trailing).offset(2)
                make.width.equalTo(30)
                make.height.equalTo(20)
            })
            .sexy_config({ (label) in
                label.textAlignment = .center
                label.font = UIFont.systemFont(ofSize: 12)
                label.backgroundColor = GlobalColor
            })
        
        goodsNumReduceBtn = UIButton.sexy_create(contentView)
            .sexy_layout({ (make) in
                make.bottom.equalTo(goodsNumIncreaseBtn)
                make.leading.equalTo(goodsNumberLabel.snp.trailing).offset(2)
                make.width.height.equalTo(20)
            })
            .sexy_config({ (btn) in
                btn.backgroundColor = GlobalColor
                btn.setImage(UIImage(named: "num_reduce"), for: .normal)
                btn.imageView?.contentMode = .center
                btn.addTarget(self, action: #selector(reduceGoods), for: .touchUpInside)

            })
        
        goodsDeleteImageView = UIImageView.sexy_create(contentView)
            .sexy_layout({ (make) in
                make.trailing.equalTo(goodsPriceLabel)
                make.bottom.equalTo(goodsNumIncreaseBtn)
                make.width.height.equalTo(12)
            })
        .sexy_config({ (imageView) in
            imageView.isUserInteractionEnabled = true
            imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(removeGoods)))
            imageView.image = UIImage(named: "delete_list")
            imageView.contentMode = .center
        })
    }
    
    func checkGoods(sender: UIButton) {
        if delegate != nil {
            if delegate!.responds(to: #selector(ShopcartDelegate.checkGoods(_:))) {
                delegate!.checkGoods(self)
            }
        }
    }
    
    func plusGoods() {
        if delegate != nil {
            if delegate!.responds(to: #selector(ShopcartDelegate.numberGoods(cell:number:operation:))) {
                let number: Int = Int(goodsNumberLabel.text!)! + 1
                delegate!.numberGoods(cell: self, number: number, operation: 1)
            }
        }
    }
    
    func reduceGoods() {
        if delegate != nil {
            if delegate!.responds(to: #selector(ShopcartDelegate.numberGoods(cell:number:operation:))) {
                let number: Int = Int(goodsNumberLabel.text!)! - 1
                delegate!.numberGoods(cell: self, number: number, operation: 2)
            }
        }
    }
    
    func removeGoods() {
        if delegate != nil {
            if delegate!.responds(to: #selector(ShopcartDelegate.removeGoods(_:))) {
                delegate!.removeGoods(self)
            }
        }

    }

}

@objc
protocol ShopcartDelegate : NSObjectProtocol {
    func checkGoods(_ cell: ShopcartCell)
    func numberGoods(cell: ShopcartCell, number: Int, operation: Int)
    func removeGoods(_ cell: ShopcartCell)
}

enum ShopcartOperration : Int {
    case plus = 1
    case reduce = 2
}
