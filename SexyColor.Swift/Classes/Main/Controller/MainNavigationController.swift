//
//  MainNavigationViewController.swift
//  SexyColor.Swift
//
//  Created by xiongkai on 2017/8/4.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController, UIGestureRecognizerDelegate, UINavigationControllerDelegate {

    override open func viewDidLoad() {
        super.viewDidLoad()
        self.interactivePopGestureRecognizer?.delegate = self
        self.delegate = self
    }
    
    lazy var backBtn: UIButton = {
        let btn = UIButton(type: .custom)
        let btnW: CGFloat = ScreenWidth > 375.0 ? 32 : 32
        btn.frame = CGRect(x: 0, y: 0, width: btnW, height: 32)
        btn.contentHorizontalAlignment = .left
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0)
        btn.setImage(UIImage(named: "Back"), for: UIControlState())
        btn.setImage(UIImage(named: "Back"), for: .highlighted)
        btn.titleLabel?.isHidden = true
        btn.addTarget(self, action: #selector(MainNavigationController.actionBack), for: .touchUpInside)
        return btn
    }()
    
    override open func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if childViewControllers.count > 0 {
            self.interactivePopGestureRecognizer?.isEnabled
                = true
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
        
    }
    
    override open func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        if viewControllers.count > 0 {
            let viewController = viewControllers.last
            viewController!.navigationItem.leftBarButtonItems = [UIBarButtonItem(customView: backBtn)]
            viewController!.navigationItem.hidesBackButton = true
        }
        super.setViewControllers(viewControllers, animated: animated)
        
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        if navigationController.viewControllers.count == 1 {
            self.interactivePopGestureRecognizer?.isEnabled
                = false
        }
    }

    
    func actionBack() {
        popViewController(animated: true)
    }

}
