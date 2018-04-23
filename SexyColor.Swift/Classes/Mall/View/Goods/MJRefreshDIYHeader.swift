//
//  MJRefreshDIYHeader.swift
//  SexyColor.Swift
//
//  Created by kayzhang on 2017/9/8.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//

import UIKit
import MJRefresh

class MJRefreshDIYHeader: MJRefreshGifHeader {
    
    override func prepare() {
        super.prepare()
        
        lastUpdatedTimeLabel?.isHidden = true
        stateLabel.font = UIFont.systemFont(ofSize: 11)
        
        var idleImages:[UIImage] = [UIImage]()
        var pullingImages:[UIImage] = [UIImage]()
        var refreshingImages:[UIImage] = [UIImage]()
        
        idleImages.append(UIImage(named:"loading_10")!)
        for i in 1...7 {
            idleImages.append(UIImage(named:"loading_\(i)")!)
        }
        
        for i in 7...8 {
            pullingImages.append(UIImage(named:"loading_\(i)")!)
        }
        
        for i in 9...10 {
            refreshingImages.append(UIImage(named:"loading_\(i)")!)
        }
        
        
        self.setImages(idleImages, for: .idle)
        self.setImages(pullingImages, for: .pulling)
        self.setImages(refreshingImages, for: .refreshing)
        self.mj_h += 20
        
    }
    
    override func placeSubviews() {
        super.placeSubviews()
        
        self.gifView.center.x = (ScreenWidth ) * 0.5
        self.gifView.frame.origin.y -= 10
        self.gifView.contentMode = .center
        
        self.stateLabel.frame.origin.y += 20
    }
}
