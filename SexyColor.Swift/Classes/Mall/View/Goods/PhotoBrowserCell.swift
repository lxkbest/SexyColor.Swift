//
//  PhotoBrowserCell.swift
//  SexyColor.Swift
//
//  Created by kayzhang on 2017/9/8.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//

import UIKit

class PhotoBrowserCell: UICollectionViewCell {
    
    var photoImage : PhotoBrowserImage!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setSubViews() {
        self.backgroundColor = UIColor.white
        photoImage = PhotoBrowserImage(frame: self.bounds)
        photoImage.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(photoImage)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        photoImage.zoomScale = 1.0;
        photoImage.contentSize = photoImage.bounds.size;
    }
    
}


