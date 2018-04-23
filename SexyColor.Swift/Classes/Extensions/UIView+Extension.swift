//
//  UIView+Extension.swift
//  ColorMoon
//
//  Created by xiongkai on 16/9/6.
//  Copyright © 2016年 薛凯凯圆滚滚. All rights reserved.
//  UIView扩展

import UIKit


extension UIView {

    /// 裁剪 view 的圆角
    func clipRectCorner(_ direction: UIRectCorner, cornerRadius: CGFloat) {
        let cornerSize = CGSize(width: cornerRadius, height: cornerRadius)
        let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: direction, cornerRadii: cornerSize)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        layer.addSublayer(maskLayer)
        layer.mask = maskLayer
    }
    
    /**
     移除所有子控件
     */
    func removeAllSubviews() {
        subviews.forEach { (view) in
            view.removeFromSuperview()
        }
    }
    
    /// x
    var x: CGFloat {
        get {
            return frame.origin.x
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.x    = newValue
            frame                 = tempFrame
        }
    }
    
    /// y
    var y: CGFloat {
        get {
            return frame.origin.y
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.y    = newValue
            frame                 = tempFrame
        }
    }
    
    /// height
    var height: CGFloat {
        get {
            return frame.size.height
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size.height = newValue
            frame                 = tempFrame
        }
    }
    
    /// width
    var width: CGFloat {
        get {
            return frame.size.width
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size.width = newValue
            frame = tempFrame
        }
    }
    
    /// size
    var size: CGSize {
        get {
            return frame.size
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size = newValue
            frame = tempFrame
        }
    }
    
    /// centerX
    var centerX: CGFloat {
        get {
            return center.x
        }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.x = newValue
            center = tempCenter
        }
    }
    
    /// centerY
    var centerY: CGFloat {
        get {
            return center.y
        }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.y = newValue
            center = tempCenter;
        }
    }
    
    func showRedWithValue(offsetX : CGFloat, offsetY : CGFloat, number : String) {
        
        hideRed()
        
        let attributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 10)]
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        var rect = number.boundingRect(with: CGSize(width: 9999, height: 30), options: option, attributes: attributes, context: nil)
        if rect.width < rect.height {
            rect.size = CGSize(width: rect.height, height: rect.height)
        }
        
        var numberLabel : UILabel!
        
        let offX : CGFloat = offsetX != 0 ? offsetX : 1
        let offY : CGFloat = offsetY != 0 ? offsetY : 0.05
        
        var x : CGFloat!
        var y : CGFloat!
        
        if self is UIImageView {
            x = CGFloat(ceilf(Float(self.width + offX - (rect.width + 5) / 2)))
            y = CGFloat(ceilf(Float(self.height * offY - (rect.height + 5) / 2)))
        }
        else {
            x = CGFloat(ceilf(Float(((self as! UIButton).imageView?.frame.maxX)! - offX - (rect.width + 5) / 2)))
            y = CGFloat(ceilf(Float(((self as! UIButton).imageView?.frame.minY)! - self.height * offY)))
            
        }
        numberLabel = UILabel(frame: CGRect(x: x, y: y, width: rect.width + 5, height: rect.height + 5))
        
        numberLabel.text = number
        numberLabel.font = UIFont.systemFont(ofSize: 10)
        numberLabel.textColor = UIColor.white
        numberLabel.backgroundColor = UIColor.red
        numberLabel.layer.cornerRadius = (rect.height + 5) / 2
        numberLabel.textAlignment = .center
        numberLabel.clipsToBounds = true
        self.addSubview(numberLabel)
    }
    
    func hideRed() {
        for view in self.subviews {
            if view.tag == 10086 {
                view.removeFromSuperview()
            }
        }
    }
    
}














