//
//  TestViewController.swift
//  SexyColor.Swift
//
//  Created by kayzhang on 2017/9/5.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//

import UIKit
import Kingfisher
import KingfisherWebP

class TestViewController: UIViewController {
    
    var smallView : UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setSubViews()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setSubViews() {
//        view.backgroundColor = UIColor.white
//        let btn = UIButton(frame: CGRect(x: 0, y: 100, width: 100, height: 100))
//        btn.setImage(UIImage(named: "addpic_btn"), for: .normal)
//        btn.showRedWithValue(offsetX: 0, offsetY: 0, number: "")
//        btn.addTarget(self, action: #selector(addLayer(btn:)), for: .touchUpInside)
//        btn.backgroundColor = UIColor.red
//        view.addSubview(btn)
//        
//        let test = UIImageView(frame: CGRect(x: 100, y: 100, width: 44, height: 44))
//        test.image = UIImage(named: "addEvaluate")
//        test.showRedWithValue(offsetX: -2, offsetY: 0.1, number: "16")
//        test.layer.borderWidth = 1
//        test.layer.borderColor = UIColor.green.cgColor
//        view.addSubview(test)
        
        let imageview = UIImageView(frame: CGRect(x: 0, y: 100, width: ScreenWidth, height: 22))
        let image = UIImage(named: "more_black")?.resizableImage(withCapInsets: UIEdgeInsetsMake(0, 0, 0, 0), resizingMode: UIImageResizingMode.tile)
        imageview.image = image
        view.addSubview(imageview)
    }
    
    func addLayer(btn : UIButton) {
//        btn.showRedWithValue(number: "10")
    }
}
