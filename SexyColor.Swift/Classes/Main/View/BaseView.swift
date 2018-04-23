//
//  BaseView.swift
//  SexyColor.Swift
//
//  Created by xiongkai on 2017/8/23.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//

import UIKit



class BaseView: UIView {

    var refreshClosure: (() -> Void)?
    private var netBreakImageView: UIImageView!
    private var netWorkLabel: UILabel!
    private var refreshLabel: UILabel!
    private var refreshBtn: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white

        netBreakImageView = UIImageView.sexy_create(self)
            .sexy_layout({ (make) in
                make.centerX.equalTo(self)
                make.centerY.equalTo(self).offset(-80)
                make.width.height.equalTo(80)
            })
            .sexy_config({ (imageView) in
                imageView.image = UIImage(named: "netbreak")
            })
        
        netWorkLabel = UILabel.sexy_create(self)
            .sexy_layout({ (make) in
                make.centerX.equalTo(self)
                make.top.equalTo(netBreakImageView.snp.bottom).offset(Margin)
                make.width.equalTo(200)
                make.height.equalTo(20)
            })
            .sexy_config({ (label) in
                label.text = "网络已断开或不稳定"
                label.textColor = UIColor.black
                label.font = UIFont.systemFont(ofSize: 14)
                label.textAlignment = .center
            })
        
        refreshLabel = UILabel.sexy_create(self)
            .sexy_layout({ (make) in
                make.centerX.equalTo(self)
                make.top.equalTo(netWorkLabel.snp.bottom).offset(5)
                make.width.equalTo(250)
                make.height.equalTo(20)
            })
            .sexy_config({ (label) in
                label.text = "您可以点击刷新按钮，再次加载"
                label.textColor = UIColor.lightGray
                label.font = UIFont.systemFont(ofSize: 14)
                label.textAlignment = .center
            })
        
        refreshBtn = UIButton.sexy_create(self)
            .sexy_layout({ (make) in
                make.centerX.equalTo(self)
                make.top.equalTo(refreshLabel.snp.bottom).offset(Margin)
                make.width.equalTo(120)
                make.height.equalTo(30)
            })
            .sexy_config({ (btn) in
                btn.setBackgroundImage(UIImage(named: "buttonBigRed"), for: .normal)
                btn.setBackgroundImage(UIImage(named: "buttonBigRedDown"), for: .selected)
                btn.setTitle("刷新界面", for: .normal)
                btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
                btn.addTarget(self, action: #selector(refresh), for: .touchUpInside)
            })
    }
    
    @objc
    fileprivate func refresh() {
        if refreshClosure != nil {
            refreshClosure!()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
