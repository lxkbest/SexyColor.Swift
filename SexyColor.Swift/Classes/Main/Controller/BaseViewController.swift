//
//  BaseViewController.swift
//  SexyColor.Swift
//
//  Created by xiongkai on 2017/8/4.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//

import UIKit
import SnapKit

class BaseViewController: UIViewController {

    var baseView : BaseView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = GlobalColor
        setBaseView()
    }

    func setBaseView() {
        baseView = BaseView.sexy_create(view).sexy_layout({ (make) in
            make.top.left.right.equalTo(view)
            make.bottom.equalTo(view).offset(-TabbarH)
        })
        hideBaseView()
    }
    
    func showBaseView() {
        baseView.isHidden = false
        view.bringSubview(toFront: baseView)
    }
    
    func hideBaseView() {
        baseView.isHidden = true
        view.sendSubview(toBack: baseView)
    }

}


