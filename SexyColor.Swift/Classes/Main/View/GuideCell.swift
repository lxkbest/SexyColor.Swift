//
//  GuideCell.swift
//  SexyColor.Swift
//
//  Created by xiongkai on 2017/8/4.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//

import UIKit

class GuideCell: UICollectionViewCell {
    fileprivate var imageView:UIImageView?
    fileprivate var nextBtn:UIButton?
    
    var image: UIImage? {
        didSet {
            imageView?.image = image
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setImageView()
        setNextBtn()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    fileprivate func setImageView() {
        imageView = UIImageView(frame: ScreenBounds)
        imageView?.contentMode = .scaleAspectFill
        self.contentView.addSubview(imageView!)
    }
    
    fileprivate func setNextBtn() {
        
        nextBtn = UIButton(type: .custom)
        nextBtn?.frame = CGRect(x: (ScreenWidth - 120) * 0.5, y: ScreenHeight * 0.85, width: 120, height: 35)
        nextBtn?.setBackgroundImage(UIImage(named: "立即体验"), for: UIControlState())
        nextBtn?.addTarget(self, action: #selector(GuideCell.actionNextBtn), for: .touchUpInside)
        nextBtn?.isHidden = true
        contentView.addSubview(nextBtn!)
    }
    
    func setHiddenBtn(_ isHidden: Bool) {
        nextBtn?.isHidden = isHidden
    }
    
    func actionNextBtn() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: GuideFinsh), object: nil)
    }

}
