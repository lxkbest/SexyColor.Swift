//
//  EmptycartViewController.swift
//  SexyColor.Swift
//
//  Created by xiongkai on 2017/8/28.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//

import UIKit

class EmptyViewController: BaseViewController {

    private var emptyView : EmptyView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setEmptyView()
    }
    
    func setEmptyView() {
        emptyView = EmptyView.sexy_create(view)
            .sexy_layout({ (make) in
                make.top.equalTo(view)
                make.left.right.equalTo(view)
                make.bottom.equalTo(view).offset(-TabbarH)
        })
    }
    
    func setEmptyEnum(emptyEnum: EmptyEnum) {
        emptyView.empty = emptyEnum
    }
}
