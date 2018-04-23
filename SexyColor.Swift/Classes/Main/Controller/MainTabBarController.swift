//
//  MainTabBarController.swift
//  SexyColor.Swift
//
//  Created by xiongkai on 2017/8/4.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    var oldIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        setTabbar()
    }
    

    func setTabbar() {
        setTabbarChild(MallViewController(), title: "首页", imageName: "Nav_home", imageNameHighlight: "Nav_home_on", tag: 0)
        
        setTabbarChild(ClassifyViewController(), title: "分类", imageName: "Nav_find", imageNameHighlight: "Nav_find_on", tag: 1)
        setTabbarChild(TasteViewController(), title: "趣ing", imageName: "Nav_ing", imageNameHighlight: "Nav_ing_on", tag: 2)
        setTabbarChild(ShopcartViewController(), title: "购物车", imageName: "Nav_car", imageNameHighlight: "Nav_car_on", tag: 3)
        
        setTabbarChild(MeViewController(), title: "我", imageName: "Nav_user", imageNameHighlight: "Nav_user_on", tag: 4)

    }
    
    func setTabbarChild(_ childVC: UIViewController, title: String, imageName: String, imageNameHighlight: String, tag: Int) {
        
        childVC.title = title
        childVC.tabBarItem.image = UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal)
        childVC.tabBarItem.selectedImage = UIImage(named: imageNameHighlight)?.withRenderingMode(.alwaysOriginal)
        let navVC = MainNavigationController(rootViewController: childVC)
        addChildViewController(navVC)
    }
}

extension MainTabBarController : UITabBarControllerDelegate {
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let index = tabBar.items?.index(of: item)
        if index != self.oldIndex {
            self.animationIndex(index: index!)
        }
    }
    
    func animationIndex(index: NSInteger) {
        var tabbarBtnArray:[Any] = [Any]()
        
        for tabbarBtn in self.tabBar.subviews {
            if tabbarBtn .isKind(of: NSClassFromString("UITabBarButton")!)  {
                tabbarBtnArray.append(tabbarBtn)
            }
        }
        
        
        let animation = CAKeyframeAnimation()
        animation.keyPath = "transform.scale"
        animation.values = [1.0, 1.3, 0.9, 1.15, 0.95, 1.02, 1.0]
        animation.duration = 1
        animation.calculationMode = kCAAnimationCubic
        
        let tabBarLayer = (tabbarBtnArray[index] as AnyObject).layer
        tabBarLayer?.add(animation, forKey: nil)
        
        self.oldIndex = index
    }
    
}
