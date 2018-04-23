//
//  LoginViewController.swift
//  SexyColor.Swift
//
//  Created by xiongkai on 2017/8/8.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class LoginViewController: UIViewController {

    @IBOutlet weak var forgetPwdLabel: UILabel!
    @IBOutlet weak var gotoRegLabel: UILabel!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var containerView: UIView!
    
    let dispose = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor =  GlobalColor.cgColor
        containerView.layer.cornerRadius = 5
        
        lineView.backgroundColor = GlobalColor

        gotoRegLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(gotoRegAction)))
        forgetPwdLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(forgetPwdAction)))
        
        loginBtn.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.loginAction()
        }).addDisposableTo(dispose)
    }
    
    func gotoRegAction() {
        let vc = RegisterViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func forgetPwdAction() {
        let vc = ForgetViewController()
        navigationController?.pushViewController(vc, animated: true)

    }
    
    func loginAction() {
        
    }

}
