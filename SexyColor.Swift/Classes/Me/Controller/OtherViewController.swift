//
//  OtherViewController.swift
//  SexyColor.Swift
//
//  Created by xiongkai on 2017/8/17.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//

import UIKit

class OtherViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    

}
