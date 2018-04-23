//
//  MenuSliderView.swift
//  SexyColor.Swift
//
//  Created by kayzhang on 2017/8/29.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//滑动视图的menu

import UIKit

class MenuSliderView: UIView {
    
    var menuBar : UIView!
    var tagBtn : UIButton!
    
    weak var delegate : MenuSliderViewDelegate?
    
    var btnCofigData : MenuSliderViewModel! = MenuSliderViewModel(selectedColor : UIColor.red, unselectedColor : UIColor.lightGray, titleArray : ["商品", "详情", "评价"], isNav : true)

    func changeOfPage(sender:UIButton) {
        UIView.animate(withDuration: AnimationDuration) { () -> Void in
            self.menuBar.centerX = sender.centerX
            self.menuBar.snp.remakeConstraints({ (make) in
                make.bottom.equalTo(self)
                make.width.equalTo(self.getBtnLength(btn: sender) + 5)
                make.centerX.equalTo(sender)
                make.height.equalTo(3)
            })
        }
        
        
        if (tagBtn != nil) {
            tagBtn.isSelected = false
        }
        tagBtn = sender
        tagBtn.isSelected = true
        
        if delegate != nil {
            if delegate!.responds(to: #selector(MenuSliderViewDelegate.touchMenu(tag:))) {
                delegate!.touchMenu(tag: tagBtn.tag - 100)
            }
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
        if let data = btnCofigData {
            var lastBtn : UIButton!
            for i in 0...data.titleArray.count - 1 {
                let btn = UIButton
                    .sexy_create(self)
                    .sexy_layout({ (make) in
                        make.top.bottom.equalTo(self)
                        if (lastBtn != nil) {
                            make.left.equalTo(lastBtn.snp.right)
                            make.width.equalTo(lastBtn)
                        }
                        else {
                            make.left.equalTo(self)
                        }
                        if i == data.titleArray.count - 1 {
                            make.right.equalTo(self)
                        }
                    })
                    .sexy_config({ (btn) in
                        btn.setTitle(data.titleArray[i] as? String, for: .normal)
                        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
                        btn.setTitleColor(data.unselectedColor, for: .normal)
                        btn.setTitleColor(data.selectedColor, for: .selected)
                        btn.tag = i + 100
                        btn.addTarget(self, action:#selector(changeOfPage(sender:)), for:.touchUpInside)
                    })
                lastBtn = btn
            }
            
            menuBar = UIView
                .sexy_create(self)
                .sexy_layout({ (make) in
                    make.bottom.left.equalTo(self)
                    make.width.equalTo(getBtnLength(btn: lastBtn))
                    make.height.equalTo(3)
                })
                .sexy_config({ (view) in
                    view.backgroundColor = data.selectedColor
                })
            
            
        }

    }
    
    func getBtnLength(btn : UIButton) -> (CGFloat) {
        let attributes = [NSFontAttributeName: btn.titleLabel?.font]
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        let str = btn.title(for: .normal)
        let rect = str?.boundingRect(with: CGSize(width: 9999, height: 30), options: option, attributes: attributes as Any as? [String : Any], context: nil)
        return rect!.width
    }
    
}

@objc
protocol MenuSliderViewDelegate:NSObjectProtocol {
    func touchMenu (tag: NSInteger)
}
