//
//  GoodsChioceAttributeView.swift
//  SexyColor.Swift
//
//  Created by kayzhang on 2017/9/12.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//

import UIKit

class GoodsChioceAttributeView: UIView {
    
    fileprivate var btnViews : UIView!
    weak var delegate : GoodsChioceAttributeDelegate?
    
    var data : [GoodsChioceAttributeArray]? {
        didSet {
            btnViews.removeAllSubviews()
            addBtn()
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
        self.backgroundColor = UIColor.white
        
        btnViews = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 0))
        self.addSubview(btnViews)
    }
    
    func addBtn() {
        var lastX = 10
        var lastY = 5
        
        if data!.count == 0 {
            btnViews.height = CGFloat(0)
            if delegate != nil {
                if delegate!.responds(to: #selector(GoodsChioceAttributeDelegate.changeHeight(height:))) {
                    delegate?.changeHeight(height: 0)
                }
            }
            return
        }
        
        for i in 0...data!.count - 1 {
            let attributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 15)]
            let option = NSStringDrawingOptions.usesLineFragmentOrigin
            let text: NSString = data![i].name as NSString
            let rect = text.boundingRect(with: CGSize(width: 9999, height: 30), options: option, attributes: attributes, context: nil)
            let btn = UIButton()
            btn.setTitle(text as String, for: .normal)
            btn.layer.cornerRadius = 15
            btn.layer.masksToBounds = true
            btn.backgroundColor = AthensGrayColor
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            btn.setTitleColor(UIColor.lightGray, for: .normal)
            btn.setImage(UIImage(named: "Qing-ribao-xx"), for: .normal)
            btn.addTarget(self, action: #selector(clear(btn:)), for: .touchUpInside)
            btn.tag = i
            if lastY == 5 {
                if CGFloat(lastX) + rect.width + 30 >= ScreenWidth - 50 {//保留位置放清空按钮
                    lastY += 35
                    lastX = 10
                }
            }
            else if CGFloat(lastX) + rect.width + 30 >= ScreenWidth {
                lastY += 35
                lastX = 10
            }
            
            let frame = CGRect(x: lastX, y: lastY, width: Int(rect.width) + 20, height: 30)
            btn.frame = frame
            setButton(btn: btn)
            btnViews.addSubview(btn)
            lastX = lastX + Int(rect.width) + 30 + 10
        }
        let clearBtn = UIButton(frame: CGRect(x: ScreenWidth - 45, y: 10, width: 40, height: 20))
        clearBtn.setTitle("清空", for: .normal)
        clearBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        clearBtn.setTitleColor(UIColor.red, for: .normal)
        clearBtn.setBackgroundImage(UIImage(named: "smallRed_Button"), for: .normal)
        clearBtn.addTarget(self, action: #selector(clearAll), for: .touchUpInside)
        btnViews.addSubview(clearBtn)
        
        if btnViews.height != CGFloat(lastY + 35) {
            btnViews.height = CGFloat(lastY + 35)
            if delegate != nil {
                if delegate!.responds(to: #selector(GoodsChioceAttributeDelegate.changeHeight(height:))) {
                    delegate?.changeHeight(height: btnViews.height)
                }
            }
        }
    }
    
    func setButton(btn : UIButton) {
        btn.width += 10
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        let imageSize : CGSize = (btn.imageView?.frame.size)!
        let titleSize : CGSize = (btn.titleLabel?.frame.size)!
        btn.imageEdgeInsets = UIEdgeInsetsMake(0,titleSize.width + 5, 0, -titleSize.width - 5);
        btn.titleEdgeInsets = UIEdgeInsetsMake(0,-imageSize.width, 0, imageSize.width);
    }
    
    func clear(btn : UIButton) {
        if delegate != nil {
            if delegate!.responds(to: #selector(GoodsChioceAttributeDelegate.remove(tag:index:))) {
                delegate?.remove(tag: btn.tag, index: (data?[btn.tag].index)!)
            }
        }
        data?.remove(at: btn.tag)
        btnViews.removeAllSubviews()
        addBtn()
    }
    
    func clearAll() {
        if delegate != nil {
            if delegate!.responds(to: #selector(GoodsChioceAttributeDelegate.removeAll)) {
                delegate?.removeAll()
            }
        }
        data?.removeAll()
        btnViews.removeAllSubviews()
        addBtn()
    }

}

struct GoodsChioceAttributeArray {
    var name : String
    var index : Int
}


@objc
protocol GoodsChioceAttributeDelegate : NSObjectProtocol {
    func changeHeight(height :CGFloat)
    func remove(tag : Int, index : Int)
    func removeAll()
}
