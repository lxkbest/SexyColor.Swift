//
//  ContentDailyCell.swift
//  SexyColor.Swift
//
//  Created by xiongkai on 2017/9/7.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//  日报Cell

import UIKit

class ContentDailyCell: UITableViewCell {
    
    var bgImg: UIImageView!
    var shadowImg: UIImageView!
    var titleLab: UILabel!
    var commentLab: UILabel!
    var praiseLab: UILabel!
    
    var DailyData: DailyEntity? {
        didSet {
            if let data = DailyData {
                
                if let img = data.cover_img {
                    let url = URL(string: img)
                    bgImg.kf.setImage(with: url)
                }
                shadowImg?.image = UIImage(named: "loadshadow")
                titleLab.text = data.title
                commentLab.text = "\(data.comment_count!)评论"
                praiseLab.text = "\(data.praise_count!)赞"
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
        
        bgImg = UIImageView.sexy_create(contentView).sexy_layout({ (make) in
            //make.edges.equalTo(contentView.snp.edges)
            make.top.left.right.equalTo(contentView)
            make.bottom.equalTo(contentView).offset(-Margin)
        })
        
        shadowImg = UIImageView.sexy_create(bgImg).sexy_layout({ (make) in
            make.top.equalTo(bgImg.snp.centerY).offset(Margin)
            make.bottom.equalTo(bgImg.snp.bottom)
            make.left.right.equalTo(bgImg)
        }).sexy_config({ (imgaeView) in
            imgaeView.alpha = 0.5
        })
        
        titleLab = UILabel.sexy_create(contentView).sexy_layout({ (make) in
            make.top.equalTo(contentView.snp.bottom).offset(-50)
            make.centerX.equalTo(contentView)
            make.height.equalTo(10)
            make.width.greaterThanOrEqualTo(50)
        }).sexy_config({ (label) in
            label.textColor = UIColor.white
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 13)
        })
        
        commentLab = UILabel.sexy_create(contentView).sexy_layout({ (make) in
            make.top.equalTo(titleLab.snp.bottom).offset(Margin)
            make.centerX.equalTo(titleLab).offset(-BigMargin)
            make.height.equalTo(10)
            make.width.lessThanOrEqualTo(50)
        }).sexy_config({ (label) in
            label.textColor = UIColor.lightGray
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 12)
        })
        
        praiseLab = UILabel.sexy_create(contentView).sexy_layout({ (make) in
            make.top.equalTo(titleLab.snp.bottom).offset(Margin)
            make.centerX.equalTo(titleLab).offset(BigMargin)
            make.height.equalTo(10)
            make.width.lessThanOrEqualTo(50)
        }).sexy_config({ (label) in
            label.textColor = UIColor.lightGray
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 12)
        })
        
        
    }
}
