//
//  UIBarButtonItem+Extension.swift
//  ColorMoon
//
//  Created by xiongkai on 16/9/9.
//  Copyright © 2016年 薛凯凯圆滚滚. All rights reserved.
//  UIBarButtonItem扩展

import UIKit

extension UIBarButtonItem {

    /**
     针对导航条右边按钮的自定义item
     */
    convenience init(imageName: String, highlImageName: String, targer: AnyObject, action: Selector) {
        let button: UIButton = UIButton(type: .custom)
        button.setImage(UIImage(named: imageName), for: .normal)
        button.setImage(UIImage(named: highlImageName), for: .highlighted)
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 44)
        button.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -10)
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.right
        button.addTarget(targer, action: action, for: .touchUpInside)
        
        self.init(customView: button)
    }
    
    /**
     针对导航条右边按钮有选中状态的自定义item
     */
    convenience init(imageName: String, highlImageName: String, selectedImage: String, targer: AnyObject, action: Selector) {
        let button: UIButton = UIButton(type: .custom)
        button.setImage(UIImage(named: imageName), for: UIControlState())
        button.setImage(UIImage(named: highlImageName), for: .highlighted)
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 44)
        button.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -10)
        button.setImage(UIImage(named: selectedImage), for: .selected)
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.right
        button.addTarget(targer, action: action, for: .touchUpInside)
        
        self.init(customView: button)
    }
    
    /**
     针对导航条左边按钮的自定义item
     */
    convenience init(leftimageName: String, highlImageName: String, targer: AnyObject, action: Selector) {
        let button: UIButton = UIButton(type: .custom)
        button.setImage(UIImage(named: leftimageName), for: .normal)
        button.setImage(UIImage(named: highlImageName), for: .highlighted)
        button.frame = CGRect(x: 0,y: 0,width: 80,height: 44)
        button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0)
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        button.addTarget(targer, action: action, for: .touchUpInside)
        
        self.init(customView: button)
    }
    
    
    
    /**
     导航条纯文字按钮
     */
    convenience init(title: String, titleClocr: UIColor, targer: AnyObject ,action: Selector) {
        
        let button = UIButton(type: .custom)
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleClocr, for: .normal)
        button.titleLabel?.font = NavItemFont
        button.setTitleColor(UIColor.gray, for: .highlighted)
        button.frame = CGRect(x: 0,y: 0,width: 80,height: 44)
        button.titleLabel?.textAlignment = NSTextAlignment.right
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.right
        button.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -5)
        button.addTarget(targer, action: action, for: .touchUpInside)
        
        self.init(customView: button)
    }
    
    convenience init(title: String, titleColor: UIColor, imageName: String, highlImageName: String, targer: AnyObject, action: Selector, edge:UIEdgeInsets) {
        
        let button: UIButton = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        button.setImage(UIImage(named: imageName), for: .normal)
        button.setImage(UIImage(named: highlImageName), for: .highlighted)
        
        let imageSize:CGSize = button.imageView!.frame.size
        let titleSize:CGSize = button.titleLabel!.frame.size
        
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left:-imageSize.width, bottom: -imageSize.height - 5, right: 0)
        button.imageEdgeInsets = UIEdgeInsets(top: -titleSize.height - 5, left: 0, bottom: 0, right: -titleSize.width)
        button.addTarget(targer, action: action, for: .touchUpInside)
        
        button.contentEdgeInsets = edge
        self.init(customView: button)
    }
    
}
