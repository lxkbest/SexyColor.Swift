//
//  MeCommonCell.swift
//  SexyColor.Swift
//
//  Created by xiongkai on 2017/8/10.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//

import UIKit

class MeCommonCell: UITableViewCell {


    var smallText: UILabel!
    var arrowImageView: UIImageView!
    var customColor: UIColor! = UIColor.gray {
        didSet {
            smallText.textColor = customColor
        }
    }
    
    var customState: Bool! = false {
        didSet {
            if customState {
                smallText.text = "已开启"
                smallText.textColor = UIColor.colorWithCustom(r: 65, g: 200, b: 241)
            } else {
                smallText.text = "已关闭"
                smallText.textColor = UIColor.gray
            }
            
        }
    }


    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .gray
        self.selectedBackgroundView = UIView(frame: self.frame)
        self.selectedBackgroundView?.backgroundColor = UIColor.colorWithCustom(r: 249, g: 249, b: 249)
        
        smallText = UILabel.sexy_create(contentView)
            .sexy_layout({ (make) in
                make.trailing.equalTo(contentView).offset(-30)
                make.centerY.equalTo(textLabel!)
                make.width.height.equalTo(textLabel!)
            })
            .sexy_config({ (label) in
                label.textAlignment = .right
                label.font = UIFont.systemFont(ofSize: 12)
                label.textColor = customColor
            })
        
        arrowImageView = UIImageView.sexy_create(contentView)
            .sexy_layout({ (make) in
                make.trailing.equalTo(-10)
                make.centerY.equalTo(contentView)
                make.width.height.equalTo(12)
            })
            .sexy_config({ (imageView) in
                imageView.image = UIImage(named: "Right_arr")
            })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


