//
//  ClassifyHeadReusableView.swift
//  SexyColor.Swift
//
//  Created by xiongkai on 2017/9/5.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//

import UIKit

class ClassifyHeadReusableView: UICollectionReusableView {
    
    private var headTitleLabel: UILabel!
    
    var headTitle : String? {
        didSet {
            headTitleLabel.text = headTitle
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
        headTitleLabel = UILabel.sexy_create(self)
            .sexy_config { (label) in
                label.textAlignment = .center
                label.font = UIFont.systemFont(ofSize: 13)
                label.textColor = UIColor.black
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        headTitleLabel.frame = self.bounds
    }
}
