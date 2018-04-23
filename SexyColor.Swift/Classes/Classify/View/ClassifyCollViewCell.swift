//
//  ClassifyCollViewCell.swift
//  SexyColor.Swift
//
//  Created by xiongkai on 2017/9/5.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//

import UIKit

class ClassifyCollViewCell: UICollectionViewCell {
    
    var textLabel : UILabel!
    private var imageView : UIImageView!
    
    var SubCategoryData : SubCategory? {
        didSet {
            if let data = SubCategoryData {
                if let text = data.cat_name {
                    textLabel.text = text
                } else {
                    textLabel.text = ""
                }
                
                if let img = data.cat_img {
                    let url = URL(string: img)
                    imageView.kf.setImage(with: url)
                } else {
                    imageView.image = UIImage()
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        setSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setSubViews() {
        
        imageView = UIImageView.sexy_create(self)
            .sexy_layout({ (make) in
                make.centerX.equalTo(self)
                make.centerY.equalTo(self).offset(-Margin)
                make.width.height.equalTo(30)
            })
        
        textLabel = UILabel.sexy_create(self)
            .sexy_layout({ (make) in
                make.top.equalTo(imageView.snp.bottom).offset(SamllMargin)
                make.centerX.equalTo(self)
                make.width.lessThanOrEqualTo(80)
            })
            .sexy_config({ (label) in
                label.font = UIFont.systemFont(ofSize: 10)
                label.textColor = UIColor.lightGray
                label.textAlignment = .center
            })
    }
}
