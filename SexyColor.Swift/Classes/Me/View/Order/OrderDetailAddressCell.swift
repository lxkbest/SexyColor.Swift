//
//  OrderDetailCell.swift
//  SexyColor.Swift
//
//  Created by xiongkai on 2017/9/15.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//

import Foundation


class OrderDetailAddressCell: UITableViewCell {
    
    fileprivate var lineView: UIView!
    fileprivate var userNameLabel: UILabel!
    fileprivate var telLabel: UILabel!
    fileprivate var addressLabel: UILabel!
    
    var tupleData: (userName: String? , tel: String? , address: String?)? {
        didSet {
            if let data = tupleData {
                let patternImage = UIImage(named: "address_line")
                lineView.backgroundColor = UIColor(patternImage: patternImage!)
                
                userNameLabel.text = data.userName
                telLabel.text = data.tel
                addressLabel.text = data.address
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
        
        lineView = UIView.sexy_create(contentView)
            .sexy_layout({ (make) in
                make.top.left.right.equalTo(contentView)
                make.height.equalTo(5)
            })

        
        userNameLabel = UILabel.sexy_create(contentView)
            .sexy_layout({ (make) in
                make.left.equalTo(contentView).offset(Margin)
                make.top.equalTo(lineView.snp.bottom).offset(BigMargin)
                make.width.greaterThanOrEqualTo(50)
                make.height.equalTo(10)
            })
            .sexy_config({ (label) in
                label.font = UIFont.systemFont(ofSize: 14)
            })
        
        telLabel = UILabel.sexy_create(contentView)
            .sexy_layout({ (make) in
                make.left.equalTo(userNameLabel.snp.right).offset(20)
                make.top.equalTo(userNameLabel)
                make.width.greaterThanOrEqualTo(50)
                make.height.equalTo(10)
            })
            .sexy_config({ (label) in
                label.font = UIFont.systemFont(ofSize: 14)
            })
        
        addressLabel = UILabel.sexy_create(contentView)
            .sexy_layout({ (make) in
                make.top.equalTo(userNameLabel.snp.bottom).offset(10)
                make.left.equalTo(userNameLabel)
                make.right.equalTo(contentView).offset(-20)
                make.height.greaterThanOrEqualTo(30)
            })
            .sexy_config({ (label) in
                label.font = UIFont.systemFont(ofSize: 14)
                label.textColor = UIColor.lightGray
                label.numberOfLines = 2
                label.lineBreakMode = .byTruncatingTail

            })
        
    }
    
}
