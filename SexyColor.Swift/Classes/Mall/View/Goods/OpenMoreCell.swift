//
//  OpenMoreCell.swift
//  SexyColor.Swift
//
//  Created by kayzhang on 2017/9/7.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//展开更多cell

import UIKit

class OpenMoreCell: UITableViewCell {

    var label : UILabel!

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setSubViews() {
        
        let _ = UIView.sexy_create(self)
        .sexy_layout { (make) in
            make.top.left.right.equalTo(self)
            make.height.equalTo(1)
        }
        .sexy_config { (view) in
            view.backgroundColor = AthensGrayColor
        }

        label = UILabel.sexy_create(self)
        .sexy_layout { (make) in
            make.top.left.equalTo(self).offset(Margin)
            make.right.bottom.equalTo(self).offset(-Margin)
        }
        .sexy_config({ (label) in
            label.font = UIFont.systemFont(ofSize: 13)
            label.textAlignment = .center
            label.textColor = UIColor.lightGray
        })
        
    }

}
