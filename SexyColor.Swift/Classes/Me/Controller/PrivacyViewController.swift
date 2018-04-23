//
//  PrivacyViewController.swift
//  SexyColor.Swift
//
//  Created by xiongkai on 2017/8/17.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//

import UIKit

class PrivacyViewController: BaseViewController {

    var indexPath: IndexPath?
    weak var delegate : PrivacyDelegate?
    
    fileprivate var circleImageView1: UIImageView!
    fileprivate var circleImageView2: UIImageView!
    fileprivate var circleImageView3: UIImageView!
    fileprivate var circleImageView4: UIImageView!
    fileprivate var circleImageView5: UIImageView!
    fileprivate var circleImageView6: UIImageView!
    fileprivate var circleImageView7: UIImageView!
    fileprivate var circleImageView8: UIImageView!

    fileprivate var frameImageView1: UIImageView!
    fileprivate var frameImageView2: UIImageView!
    fileprivate var frameImageView3: UIImageView!
    fileprivate var frameImageView4: UIImageView!
    fileprivate var frameImageView5: UIImageView!
    fileprivate var frameImageView6: UIImageView!
    fileprivate var frameImageView7: UIImageView!
    fileprivate var frameImageView8: UIImageView!
    
    fileprivate var containerView: UIView!
    fileprivate var passwordLabel: UILabel!
    fileprivate var confirmLabel: UILabel!
    fileprivate var hintLabel: UILabel!

    fileprivate var passwordStr: String = ""
    fileprivate var confirmStr: String = ""

    fileprivate var state: Bool = false {
        didSet {
            if state {
                title = "关闭隐私保护"
                passwordLabel.text = "请输入密码"
            } else {
                title = "设置app启动密码"
                passwordLabel.text = "请输入app启动密码"
            }
        }
    }
    
    fileprivate var mode: Bool = true {
        didSet {
            if mode {
                UIView.animate(withDuration: 0.7, animations: { [weak self] in
                    self!.containerView.frame.origin = CGPoint(x: self!.containerView.x + ScreenWidth, y: self!.containerView.y)
                })
            } else {
                UIView.animate(withDuration: 0.7, animations: { [weak self] in
                    self!.containerView.frame.origin = CGPoint(x: self!.containerView.x - ScreenWidth, y: self!.containerView.y)
                })
            }
        }
    }
    var collectionView: UICollectionView!
    var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "设置app启动密码"
        setUI()
        
    }
    
    func textChange(textField: UITextField) {
        if mode {
            switch textField.text!.length {
                case 1:
                    frameImageView1.isHidden = false
                case 2:
                    frameImageView2.isHidden = false
                case 3:
                    frameImageView3.isHidden = false
                case 4:
                    frameImageView4.isHidden = false
                    passwordStr = textField.text!
                    mode = false
                    textField.text = String()
                    reductionState2()
                default: break
            }
        } else {
            switch textField.text!.length {
                case 1:
                    frameImageView5.isHidden = false
                case 2:
                    frameImageView6.isHidden = false
                case 3:
                    frameImageView7.isHidden = false
                case 4:
                    frameImageView8.isHidden = false
                    confirmStr = textField.text!
                    if passwordStr == confirmStr {
                        UserDefaults.standard.set(confirmStr, forKey: "privacyPassword")
                        hintLabel.isHidden = true
                        containerView.frame.origin = CGPoint(x: containerView.x + ScreenWidth, y: self.containerView.y)
                        delegate?.isOpenPrivacy(isOpen: true, indexPath: indexPath!)
                        navigationController?.popViewController(animated: true)
                    } else {
                        textField.text = String()
                        mode = true
                        hintLabel.isHidden = false
                        reductionState1()
                    }
                default: break
            }
            
        }
        
        
    }
    
    func reductionState1() {
        frameImageView1.isHidden = true
        frameImageView2.isHidden = true
        frameImageView3.isHidden = true
        frameImageView4.isHidden = true
    }
    
    func reductionState2() {
        frameImageView5.isHidden = true
        frameImageView6.isHidden = true
        frameImageView7.isHidden = true
        frameImageView8.isHidden = true
    }
    
    func setUI() {
        
        
        containerView = UIView(frame: CGRect(x: 0, y: 30, width: ScreenWidth * 2, height: 100))
        view.addSubview(containerView)


        passwordTextField = UITextField.sexy_create(containerView)
            .sexy_layout({ (make) in
                make.centerX.equalTo(containerView).offset(-ScreenWidth * 0.5)
                make.top.equalTo(containerView).offset(5)
                make.width.equalTo(200)
                make.height.equalTo(20)
            })
            .sexy_config({ (textField) in
                textField.keyboardType = .numberPad
                textField.isHidden = true
                textField.becomeFirstResponder()
                textField.addTarget(self, action: #selector(textChange(textField:)), for: .editingChanged)
            })

        
        passwordLabel = UILabel.sexy_create(containerView)
            .sexy_layout({ (make) in
                make.centerX.equalTo(containerView).offset(-ScreenWidth * 0.5)
                make.top.equalTo(containerView).offset(5)
                make.width.equalTo(200)
                make.height.equalTo(20)
            })
            .sexy_config({ (label) in
                label.text = "请输入app启动密码"
                label.textAlignment = .center
            })
        
        confirmLabel = UILabel.sexy_create(containerView)
            .sexy_layout({ (make) in
                make.centerX.equalTo(containerView).offset(ScreenWidth * 0.5)
                make.top.equalTo(containerView).offset(5)
                make.width.equalTo(200)
                make.height.equalTo(20)
            })
            .sexy_config({ (label) in
                label.text = "请输入密码"
                label.textAlignment = .center
            })
 
        circleImageView1 = UIImageView.sexy_create(containerView)
            .sexy_layout({ (make) in
                make.top.equalTo(passwordLabel.snp.bottom).offset(20)
                make.leading.equalTo(containerView).offset((ScreenWidth - 100) * 0.5 - 61 - 25)
                make.width.equalTo(61)
                make.height.equalTo(53)
            })
            .sexy_config({ (imageView) in
                imageView.image = UIImage(named: "members_bit_bg")
            })
        
        frameImageView1 = UIImageView.sexy_create(circleImageView1)
            .sexy_layout({ (make) in
                make.center.equalTo(circleImageView1)
                make.width.height.equalTo(16)
            })
            .sexy_config({ (imageView) in
                imageView.image = UIImage(named: "members_bit_icon")
                imageView.isHidden = true
            })
 
        circleImageView2 = UIImageView.sexy_create(containerView)
            .sexy_layout({ (make) in
                make.top.equalTo(circleImageView1)
                make.leading.equalTo(circleImageView1.snp.trailing).offset(10)
                make.width.equalTo(61)
                make.height.equalTo(53)
            })
            .sexy_config({ (imageView) in
                imageView.image = UIImage(named: "members_bit_bg")
            })
        
        frameImageView2 = UIImageView.sexy_create(circleImageView2)
            .sexy_layout({ (make) in
                make.center.equalTo(circleImageView2)
                make.width.height.equalTo(16)
            })
            .sexy_config({ (imageView) in
                imageView.image = UIImage(named: "members_bit_icon")
                imageView.isHidden = true
            })
        
        circleImageView3 = UIImageView.sexy_create(containerView)
            .sexy_layout({ (make) in
                make.top.equalTo(circleImageView1)
                make.leading.equalTo(circleImageView2.snp.trailing).offset(10)
                make.width.equalTo(61)
                make.height.equalTo(53)
            })
            .sexy_config({ (imageView) in
                imageView.image = UIImage(named: "members_bit_bg")
            })
        
        frameImageView3 = UIImageView.sexy_create(circleImageView3)
            .sexy_layout({ (make) in
                make.center.equalTo(circleImageView3)
                make.width.height.equalTo(16)
            })
            .sexy_config({ (imageView) in
                imageView.image = UIImage(named: "members_bit_icon")
                imageView.isHidden = true
            })
        
        circleImageView4 = UIImageView.sexy_create(containerView)
            .sexy_layout({ (make) in
                make.top.equalTo(circleImageView1)
                make.leading.equalTo(circleImageView3.snp.trailing).offset(10)
                make.width.equalTo(61)
                make.height.equalTo(53)
            })
            .sexy_config({ (imageView) in
                imageView.image = UIImage(named: "members_bit_bg")
            })
        
        frameImageView4 = UIImageView.sexy_create(circleImageView4)
            .sexy_layout({ (make) in
                make.center.equalTo(circleImageView4)
                make.width.height.equalTo(16)
            })
            .sexy_config({ (imageView) in
                imageView.image = UIImage(named: "members_bit_icon")
                imageView.isHidden = true
            })
        
        hintLabel = UILabel.sexy_create(containerView)
            .sexy_layout({ (make) in
                make.centerX.equalTo(containerView).offset(-(ScreenWidth * 0.5))
                make.top.equalTo(passwordLabel.snp.bottom).offset(90)
                make.width.equalTo(200)
                make.height.equalTo(20)
            })
            .sexy_config({ (label) in
                label.text = "密码不匹配，请重试"
                label.textAlignment = .center
                label.font = UIFont.systemFont(ofSize: 13)
                label.isHidden = true
            })
        
        circleImageView5 = UIImageView.sexy_create(containerView)
            .sexy_layout({ (make) in
                make.top.equalTo(circleImageView1)
                make.leading.equalTo(containerView).offset((ScreenWidth - 100) * 0.5 - 61 - 25 + ScreenWidth)
                make.width.equalTo(61)
                make.height.equalTo(53)
            })
            .sexy_config({ (imageView) in
                imageView.image = UIImage(named: "members_bit_bg")
            })
        
        frameImageView5 = UIImageView.sexy_create(circleImageView5)
            .sexy_layout({ (make) in
                make.center.equalTo(circleImageView5)
                make.width.height.equalTo(16)
            })
            .sexy_config({ (imageView) in
                imageView.image = UIImage(named: "members_bit_icon")
                imageView.isHidden = true
            })
        
        circleImageView6 = UIImageView.sexy_create(containerView)
            .sexy_layout({ (make) in
                make.top.equalTo(circleImageView1)
                make.leading.equalTo(circleImageView5.snp.trailing).offset(10)
                make.width.equalTo(61)
                make.height.equalTo(53)
            })
            .sexy_config({ (imageView) in
                imageView.image = UIImage(named: "members_bit_bg")
            })
        
        frameImageView6 = UIImageView.sexy_create(circleImageView6)
            .sexy_layout({ (make) in
                make.center.equalTo(circleImageView6)
                make.width.height.equalTo(16)
            })
            .sexy_config({ (imageView) in
                imageView.image = UIImage(named: "members_bit_icon")
                imageView.isHidden = true
            })
        
        circleImageView7 = UIImageView.sexy_create(containerView)
            .sexy_layout({ (make) in
                make.top.equalTo(circleImageView1)
                make.leading.equalTo(circleImageView6.snp.trailing).offset(10)
                make.width.equalTo(61)
                make.height.equalTo(53)
            })
            .sexy_config({ (imageView) in
                imageView.image = UIImage(named: "members_bit_bg")
            })
        
        frameImageView7 = UIImageView.sexy_create(circleImageView7)
            .sexy_layout({ (make) in
                make.center.equalTo(circleImageView7)
                make.width.height.equalTo(16)
            })
            .sexy_config({ (imageView) in
                imageView.image = UIImage(named: "members_bit_icon")
                imageView.isHidden = true
            })
        
        circleImageView8 = UIImageView.sexy_create(containerView)
            .sexy_layout({ (make) in
                make.top.equalTo(circleImageView1)
                make.leading.equalTo(circleImageView7.snp.trailing).offset(10)
                make.width.equalTo(61)
                make.height.equalTo(53)
            })
            .sexy_config({ (imageView) in
                imageView.image = UIImage(named: "members_bit_bg")
            })
        
        frameImageView8 = UIImageView.sexy_create(circleImageView8)
            .sexy_layout({ (make) in
                make.center.equalTo(circleImageView8)
                make.width.height.equalTo(16)
            })
            .sexy_config({ (imageView) in
                imageView.image = UIImage(named: "members_bit_icon")
                imageView.isHidden = false
            })

    }
}

@objc
protocol PrivacyDelegate: NSObjectProtocol {
    func isOpenPrivacy(isOpen: Bool, indexPath: IndexPath)
}

