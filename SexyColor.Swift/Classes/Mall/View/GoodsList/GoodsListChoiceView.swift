//
//  GoodsListChoiceView.swift
//  SexyColor.Swift
//
//  Created by kayzhang on 2017/9/11.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//

import UIKit

class GoodsListChoiceView: UIView {

    weak var delegate : GoodsListChoiceDelegate?
    
    fileprivate var tagBtn : UIButton!
//    MARK : - 0 标准样式  1 ↑  2 ↓
    fileprivate var recordPrice : Int! = 0
    
    fileprivate let number : Int = 100
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setSubViews() {
        
        self.backgroundColor = UIColor.white
        
        let titles = ["推荐", "价格", "销量", "筛选"]
        let images = ["", "", "list_sortdefault", "screen"]
        let btnW = self.width / CGFloat(titles.count)
        let btnH = self.height
        for i in 0...titles.count - 1 {
            let btn = UIButton(frame: CGRect(x: CGFloat(i) * btnW, y: 0, width: btnW, height: btnH))
            btn.setTitle(titles[i], for: .normal)
            let imageName = images[i]
            btn.setImage(UIImage(named: imageName), for: .normal)
            btn.setTitleColor(UIColor.red, for: .selected)
            btn.setTitleColor(UIColor.lightGray, for: .normal)
            btn.tag = i + number
            btn.addTarget(self, action: #selector(click(btn:)), for: .touchUpInside)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            self.addSubview(btn)
            if imageName.length != 0 {
                setButton(btn: btn)
            }
            if i == 0 {
                tagBtn = btn
                btn.isSelected = true
            }
        }
        
        let lineView = UIView(frame: CGRect(x: 0, y: btnH - 1, width: self.width, height: 1))
        lineView.backgroundColor = AthensGrayColor
        self.addSubview(lineView)
    }
    
    func click(btn : UIButton) {
        if btn.tag != 3 + number {
            
            if btn.tag == 2 + number {
                recordPrice = recordPrice + 1 > 2 ? 1 : recordPrice + 1
                switch recordPrice {
                case 1:
                    btn.setImage(UIImage(named: "list_sortup"), for: .normal)
                    break
                case 2:
                    btn.setImage(UIImage(named: "list_sortdown"), for: .normal)
                    break
                default:
                    break
                }
            }
            else if tagBtn != btn {
                recordPrice = 0
                let priceBtn : UIButton = viewWithTag(2 + number) as! UIButton
                priceBtn.setImage(UIImage(named: "list_sortdefault"), for: .normal)
            }
            else {
                return
            }
            tagBtn.isSelected = false
            tagBtn = btn
            tagBtn.isSelected = true
        }
        else {
            if delegate != nil {
                if delegate!.responds(to: #selector(delegate?.show)) {
                    delegate?.show()
                }
            }
        }
    }
    
    func leftTiitleBtn() {
        
    }
    
    func setButton(btn : UIButton) {
        let imageSize : CGSize = (btn.imageView?.frame.size)!
        let titleSize : CGSize = (btn.titleLabel?.frame.size)!
        btn.imageEdgeInsets = UIEdgeInsetsMake(0,titleSize.width, 0, -titleSize.width - 5);
        btn.titleEdgeInsets = UIEdgeInsetsMake(0,-imageSize.width - 5, 0, imageSize.width);
    }
}

@objc
protocol GoodsListChoiceDelegate : NSObjectProtocol {
    func show()
}
