//
//  MallTitleView.swift
//  SexyColor.Swift
//
//  Created by xiongkai on 2017/9/11.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//

import UIKit

class MallTitleView: UICollectionReusableView {

    var lineViewLeft: UIView!
    var titleLabel: UILabel!
    var lineViewRight: UIView!

    var msgData: String? {
        didSet {
            if let data = msgData {
                titleLabel.text = data
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
        
        titleLabel = UILabel.sexy_create(self)
            .sexy_layout({ (make) in
                make.center.equalTo(self)
                make.width.greaterThanOrEqualTo(20)
                make.height.equalTo(10)
            })
            .sexy_config({ (label) in
                label.font = UIFont.systemFont(ofSize: 12)
                label.textColor = UIColor.lightGray
            })
        
        
        
        lineViewLeft = UIView.sexy_create(self)
            .sexy_layout({ (make) in
                make.centerY.equalTo(titleLabel)
                make.trailing.equalTo(titleLabel.snp.leading).offset(1)
                make.width.equalTo(BigMargin)
                make.height.equalTo(1)
            })
            .sexy_config({ (view) in
                let layer = CAGradientLayer()
                layer.colors = [UIColor.clear.cgColor, UIColor.lightGray.cgColor, UIColor.lightGray.cgColor]
                layer.locations = [0, 0.1, 1]
                layer.startPoint = CGPoint(x: 0, y: 0.5)
                layer.endPoint = CGPoint(x: 1, y: 0.5)
                view.layer.mask = layer
            })
        
        lineViewRight = UIView.sexy_create(self)
            .sexy_layout({ (make) in
                make.centerY.equalTo(titleLabel)
                make.leading.equalTo(titleLabel.snp.trailing).offset(1)
                make.width.equalTo(BigMargin)
                make.height.equalTo(1)
            })
            .sexy_config({ (view) in
                let layer = CAGradientLayer()
                layer.colors = [UIColor.lightGray.cgColor, UIColor.lightGray.cgColor, UIColor.clear.cgColor]
                layer.locations = [1, 0.1, 0]
                layer.startPoint = CGPoint(x: 1, y: 0.5)
                layer.endPoint = CGPoint(x: 0, y: 0.5)
                view.layer.mask = layer
            })
    }


}
