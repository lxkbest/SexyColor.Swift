//
//  MeHotView.swift
//  SexyColor.Swift
//
//  Created by xiongkai on 2017/8/14.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//

import UIKit
import SnapKit


class MeHotView: UIView {
    
    fileprivate var titleLable: UILabel!
    fileprivate var hotImageView: UIImageView!

    var hotViewData: (String, String)? {
        didSet {
            titleLable?.text = hotViewData!.0
            hotImageView?.image = UIImage(named: hotViewData!.1)
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
        
        hotImageView = UIImageView
            .sexy_create(self)
            .sexy_layout({ [weak self] (make) in
                make.centerX.equalTo(self!.snp.centerX)
                make.top.equalTo(self!.snp.top)
                make.width.equalTo(self!.width - 20)
                make.height.equalTo(self!.height - 20)
            })
            .sexy_config({ (imageView) in
                imageView.isUserInteractionEnabled = false
                imageView.contentMode = .center
            })
        
        titleLable = UILabel
            .sexy_create(self)
            .sexy_layout({ [weak self] (make) in
                make.centerX.equalTo(self!.snp.centerX)
                make.top.equalTo(self!.hotImageView.snp.bottom)
                make.width.equalTo(self!.width - 20)
                make.height.equalTo(10)
            })
            .sexy_config({ (label) in
                label.isUserInteractionEnabled = false
                label.font = UIFont.systemFont(ofSize: 12)
                label.textColor = UIColor.gray
                label.textAlignment = .center
            })
    }

}
