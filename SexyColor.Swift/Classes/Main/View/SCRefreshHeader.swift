//
//  SCRefreshHeader.swift
//  SexyColor.Swift
//
//  Created by xiongkai on 2017/9/7.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//

import UIKit
import MJRefresh

class SCRefreshHeader: MJRefreshGifHeader {

    override func prepare() {
        super.prepare()
        
        lastUpdatedTimeLabel?.isHidden = true
        stateLabel.font = UIFont.systemFont(ofSize: 11)
        stateLabel.isHidden = true
        
        var idleImages:[UIImage] = [UIImage]()
        var pullingImages:[UIImage] = [UIImage]()
        var refreshingImages:[UIImage] = [UIImage]()
        var noMoreDataImages:[UIImage] = [UIImage]()
        
        for i in 1...7 {
            let image = UIImage(named: String(format: "loading_%d.png", i))
            idleImages.append(image!)
        }
        
        for i in 7...8 {
            let image = UIImage(named: String(format: "loading_%d.png", i))
            pullingImages.append(image!)

        }
        
        for i in 7...10 {
            let image = UIImage(named: String(format: "loading_%d.png", i))
            refreshingImages.append(image!)
        }
        
        let image = UIImage(named: String(format: "loading_%d.png", 10))
        noMoreDataImages.append(image!)

        self.setImages(idleImages, for: .idle)
        self.setImages(pullingImages, for: .pulling)
        self.setImages(refreshingImages, for: .refreshing)
        self.setImages(noMoreDataImages, duration: 1, for: .idle)
    }

    
}
