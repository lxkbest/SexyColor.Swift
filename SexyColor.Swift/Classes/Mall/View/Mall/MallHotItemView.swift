//
//  MallHotItemView.swift
//  SexyColor.Swift
//
//  Created by xiongkai on 2017/9/11.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//

import UIKit

class MallHotItemView: UIView {
    
    var imgPlaceholder: UIImage!
    var titleLabel: UILabel!
    var imageView: UIImageView!
    
    var tupleData: (title: String?, imgUrl: String?)? {
        didSet {
            if let data = tupleData {
                titleLabel.text = data.title
                
                let url = URL(string: data.imgUrl!)
                imageView.kf.setImage(with: url, placeholder: imgPlaceholder)
            }
        }
    }
    
    convenience init(frame: CGRect, image: UIImage) {
        self.init(frame: frame)
        imgPlaceholder = image
        setUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = CGRect(x: 5, y: 15, width: width - 10, height: height - 40)
        titleLabel.frame = CGRect(x: 5, y: height - 20, width: imageView.width, height: 10)    }
    
    fileprivate func setUI() {
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
//        imageView?.contentScaleFactor = UIScreen.main.scale
//        imageView?.clipsToBounds  = true
//        
        addSubview(imageView!)
        
        titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        titleLabel.textColor = UIColor.lightGray
        titleLabel.textAlignment = .center
        
        addSubview(titleLabel!)

    }
    

}
