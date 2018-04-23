//
//  MeHeadCell.swift
//  SexyColor.Swift
//
//  Created by xiongkai on 2017/8/10.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class MeHeadCell: UITableViewCell {

    var indexPath: NSIndexPath!
    
    var headImageClosure: (() -> Void)?
    var signBtnClosure: (() -> Void)?
    weak var delegate : MeHotMenuDelegate?
    
    var headrData: MeHeadModel? {
        didSet {
            if let data = headrData {
                let url = URL(string: data.img)
                headImageView.kf.setImage(with: url, placeholder: UIImage(named: "avatar"))
                userNameLabel.text = data.name
                levelBtn.setTitle(levelBtn.titleLabel!.text! + "\(data.level)", for: .normal)
                if data.isSignState {
                    signBtn.setTitle(" 已签到", for: .normal)
                    signBtn.isUserInteractionEnabled = false
                } else {
                    signBtn.setTitle(" 签到", for: .normal)
                    signBtn.isUserInteractionEnabled = true
                }
                
                hideControl(isHide: data.isLoginState)
            }
        }
    }
    
    fileprivate let hotMenus = [0:(title: "趣豆商城",imageName: "Usre_qudou"), 1:(title: "浏览历史",imageName: "User_lishi"), 2:(title: "收藏夹",imageName: "User_soucang"), 3:(title: "我的订单",imageName: "User_dingdan")]

    
    fileprivate var headImageView: UIImageView!
    fileprivate var userNameLabel: UILabel!
    fileprivate var levelBtn: UIButton!
    fileprivate var signBtn: UIButton!
    
    fileprivate var regBtn: UIButton!
    fileprivate var loginBtn: UIButton!
    
    fileprivate var lineView: UIView!
    fileprivate var containerView: UIView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func setSubViews() {

        headImageView = UIImageView
            .sexy_create(contentView)
            .sexy_layout({ (make) in
                make.width.height.equalTo(60)
                make.centerX.equalTo(contentView)
                make.top.equalTo(2 * BigMargin)
            })
            .sexy_config({ (image) in
                image.layer.cornerRadius = 30
                image.layer.masksToBounds = true
                image.backgroundColor = UIColor.red
                image.image = UIImage(named: "avatar")
                image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(headImageAction)))
            })
        
        
        userNameLabel = UILabel
            .sexy_create(contentView)
            .sexy_layout({ (make) in
                make.top.equalTo(headImageView.snp.bottom).offset(Margin)
                make.centerX.equalTo(headImageView.snp.centerX).offset(-BigMargin)
                make.width.equalTo(90)
                make.height.equalTo(10)
            })
            .sexy_config({ (label) in
                label.font = UIFont.systemFont(ofSize: 13)
                label.textColor = UIColor.black
                label.textAlignment = .right
            })
  
        levelBtn = UIButton
            .sexy_create(contentView)
            .sexy_layout({ (make) in
                make.width.equalTo(25)
                make.height.equalTo(10)
                make.centerY.equalTo(userNameLabel.snp.centerY)
                make.leading.equalTo(userNameLabel.snp.trailing).offset(5)
            })
            .sexy_config({ (button) in
                button.setTitle("VIP", for: .normal)
                button.setTitleColor(UIColor.colorWithCustom(r: 248, g: 101, b: 104), for: .normal)
                button.titleLabel?.font = UIFont.systemFont(ofSize: 9)
                button.layer.borderWidth = 1
                button.layer.borderColor = UIColor.colorWithCustom(r: 248, g: 101, b: 104).cgColor
            })

        signBtn = UIButton
            .sexy_create(contentView)
            .sexy_layout({ (make) in
                make.width.equalTo(60)
                make.height.equalTo(20)
                make.centerY.equalTo(headImageView.snp.top)
                make.trailing.equalTo(contentView.snp.trailing).offset(-Margin)
            })
            .sexy_config({ (button) in
                button.setTitle(" 签到", for: .normal)
                button.setTitleColor(UIColor.colorWithCustom(r: 248, g: 101, b: 104), for: .normal)
                button.imageView?.contentMode = .scaleAspectFit
                button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
                button.setImage(UIImage(named: "User_qiandao"), for: .normal)
                button.addTarget(self, action: #selector(signBtnAction), for: .touchUpInside)
            })
        
        regBtn = UIButton
            .sexy_create(contentView)
            .sexy_layout({ (make) in
                make.width.equalTo(70)
                make.height.equalTo(30)
                make.top.equalTo(contentView).offset(NavigationH)
                make.trailing.equalTo(contentView.snp.centerX).offset(-Margin)
            })
            .sexy_config({ (button) in
                button.setTitle("注册", for: .normal)
                button.setTitleColor(UIColor.colorWithCustom(r: 248, g: 101, b: 104), for: .normal)
                button.layer.borderWidth = 1
                button.layer.borderColor = UIColor.colorWithCustom(r: 248, g: 101, b: 104).cgColor
                button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
                button.layer.cornerRadius = 2
            })

        loginBtn = UIButton
            .sexy_create(contentView)
            .sexy_layout({ (make) in
                make.width.equalTo(70)
                make.height.equalTo(30)
                make.top.equalTo(contentView).offset(NavigationH)
                make.leading.equalTo(contentView.snp.centerX).offset(Margin)
            })
            .sexy_config({ (button) in
                button.setTitle("登录", for: .normal)
                button.setTitleColor(UIColor.colorWithCustom(r: 248, g: 101, b: 104), for: .normal)
                button.layer.borderWidth = 1
                button.layer.borderColor = UIColor.colorWithCustom(r: 248, g: 101, b: 104).cgColor
                button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
                button.layer.cornerRadius = 2
            })
        
        lineView = UIView
            .sexy_create(contentView)
            .sexy_layout({ (make) in
                make.height.equalTo(1 / UIScreen.main.scale)
                make.top.equalTo(contentView).offset(190)
                make.leading.trailing.equalTo(contentView)
            })
            .sexy_config({ (view) in
                view.backgroundColor = GlobalColor
            })
        
        containerView = UIView
            .sexy_create(contentView)
            .sexy_layout({ (make) in
                make.height.equalTo(60)
                make.top.equalTo(lineView.snp.bottom)
                make.leading.trailing.equalTo(contentView)
            })
        
        hideControl(isHide: true)
        
        
        for i in 0..<hotMenus.count {
            let itemW = ScreenWidth * 0.25
            let itemH: CGFloat = 60
            let frame = CGRect(x: CGFloat(i) * itemW,y: 0,width: itemW,height: itemH)
            let view = MeHotView(frame: frame)
            view.tag = i
            view.hotViewData = hotMenus[i]
            view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hotMenuAction(tap:))))
            containerView.addSubview(view)
        }
    }
    
    func headImageAction() {
        if headImageClosure != nil {
            headImageClosure!()
        }
    }
    
    func signBtnAction() {
        if signBtnClosure != nil {
            signBtnClosure!()
        }
    }
    
    func hotMenuAction(tap: UITapGestureRecognizer) {
        let index = tap.view!.tag
        if delegate != nil {
            if delegate!.responds(to: #selector(MeHotMenuDelegate.hotMenuClick(index:))) {
                delegate!.hotMenuClick(index: index)
            }
        }
    }
    
    func hideControl(isHide: Bool) {

        headImageView.isHidden = isHide
        userNameLabel.isHidden = isHide
        levelBtn.isHidden = isHide
        signBtn.isHidden = isHide
        
        loginBtn.isHidden = !isHide
        regBtn.isHidden = !isHide

    }
}


@objc
protocol MeHotMenuDelegate: NSObjectProtocol {
    func hotMenuClick(index: Int)
}
