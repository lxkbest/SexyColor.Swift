//
//  AppDelegate.swift
//  SexyColor.Swift
//
//  Created by xiongkai on 2017/8/4.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//

import UIKit
import Alamofire

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    private let NetworkManager = NetworkReachabilityManager(host: "www.baidu.com")
    var window: UIWindow?
    static var netWorkState : NetWorkState = .unknown

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        setNetWork()
        setWindow()
        setAppearance()
        return true
    }
    
    func setWindow() {
        window = UIWindow(frame: ScreenBounds)
        window?.makeKeyAndVisible()
//        UIApplication.shared.setStatusBarHidden(false, with: .fade)
//        UIApplication.shared.setStatusBarStyle(UIStatusBarStyle.lightContent, animated: false)
        window?.rootViewController = MainTabBarController()
        //window?.rootViewController = LoginViewController()
    }
    
    
    func setAppearance() {
        let tabbarItem = UITabBarItem.appearance()
        
        tabbarItem.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.gray, NSFontAttributeName : UIFont.systemFont(ofSize: 10)], for: UIControlState())
        
        tabbarItem.setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.red, NSFontAttributeName : UIFont.systemFont(ofSize: 10)], for: UIControlState.selected)
        
        let nav = UINavigationBar.appearance()
        nav.isTranslucent = false
        //nav.barTintColor = NavigationBackgroundColor
    }
    
    func setNetWork() {
        NetworkManager!.listener = { (status) in
            switch status {
            case .notReachable:
                AppDelegate.netWorkState = .notReachable
            case .unknown:
                AppDelegate.netWorkState = .unknown
            case .reachable(.ethernetOrWiFi):
                AppDelegate.netWorkState = .wifi
            case .reachable(.wwan):
                AppDelegate.netWorkState = .wwan
            }
        }
        NetworkManager!.startListening()
    }
    
    func setNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(AppDelegate.actionLoginFnish), name: NSNotification.Name(rawValue: LoginFnish), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AppDelegate.actionLogoutFnish), name: NSNotification.Name(rawValue: LogoutFnish), object: nil)
    }
    
    func actionLoginFnish() {
        window?.rootViewController = MainTabBarController()
    }
    
    func actionLogoutFnish() {
        window?.rootViewController = MainNavigationController(rootViewController: LoginViewController())
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }


}

enum NetWorkState {
    case notReachable
    case unknown
    case wwan
    case wifi
}
