//
//  payMenuView.swift
//  SexyColor.Swift
//
//  Created by kayzhang on 2017/8/31.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//

import UIKit

class payMenuView: UIView {

    
    fileprivate var choiceView : UIView!
    fileprivate var numberLaebl : UILabel!
    fileprivate var imageView : UIImageView!
    fileprivate var priceLabel : UILabel!
    fileprivate var choiceLabel : UILabel!
    fileprivate var choiceTableView : UITableView!
    fileprivate var addBtn : UIButton!
    fileprivate var reduceBtn : UIButton!

    fileprivate var selectedTag : NSInteger! = 0
    
    weak var delegate : PayMenuDelegate?
    
    var choiceData : [StandardList]? {
        didSet {
            let data = choiceData?[0]
            let url = URL(string: (data?.attr_pic)!)
            imageView.kf.setImage(with: url,
                                  placeholder: UIImage(named: "loadingbkg"),
                                  options: [.transition(.fade(1))],
                                  progressBlock: nil,
                                  completionHandler: nil)
            
            priceLabel.text = NSString(format: "￥%.2f",(data?.attr_price)!) as String
            choiceLabel.text = NSString(format: "已选择 %@",(data?.attr_value)!) as String

        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setSubViews()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setSubViews() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideenChice))
        tap.delegate = self
        self.addGestureRecognizer(tap)
        
        choiceView = UIView(frame: CGRect.init(x: 0, y: self.height, width: ScreenWidth, height: self.height * 0.6))
        self.addSubview(choiceView)
        choiceView.backgroundColor = UIColor.white
        
        let tapGesture = UITapGestureRecognizer(target: self, action: nil)
        tapGesture.delegate = self
        choiceView.addGestureRecognizer(tapGesture)
        
        setview()
    }
    
    func setview() {
        
        let bigImageView = UIView.sexy_create(choiceView)//商品图片
            .sexy_layout { (make) in
                make.top.equalTo(choiceView).offset(-Margin)
                make.left.equalTo(choiceView).offset(Margin)
                make.height.width.equalTo(choiceView.snp.width).multipliedBy(0.25)
            }
            .sexy_config { (view) in
                view.backgroundColor = UIColor.white
        }
        
        imageView = UIImageView.sexy_create(bigImageView)//商品图片
            .sexy_layout { (make) in
                make.top.left.equalTo(bigImageView).offset(Margin * 0.2)
                make.right.bottom.equalTo(bigImageView).offset(-Margin * 0.2)
            }
            .sexy_config { (imageView) in
                imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showImage)))
        }
        
        let closeBtn = UIButton.sexy_create(choiceView)//X按钮
            .sexy_layout { (make) in
                make.top.equalTo(choiceView).offset(Margin)
                make.right.equalTo(choiceView).offset(-0.5 * Margin)
                make.width.height.equalTo(35)
            }
            .sexy_config { (btn) in
                btn.setImage(UIImage.init(named: "close"), for: .normal)
                btn.addTarget(self, action: #selector(hideenChice), for: .touchUpInside)
        }
        
        
        let confirmBtn = UIButton.sexy_create(choiceView)//确定按钮
            .sexy_layout { (make) in
                make.left.right.bottom.equalTo(choiceView)
                make.height.equalTo(40)
            }
            .sexy_config { (btn) in
                btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
                btn.addTarget(self, action: #selector(pay), for: .touchUpInside)
                btn.setTitle("确定", for: .normal)
                btn.backgroundColor = UIColor.red
        }
        
        priceLabel = UILabel.sexy_create(choiceView)//商品价格
            .sexy_layout({ (make) in
                make.left.equalTo(bigImageView.snp.right).offset(Margin)
                make.top.equalTo(closeBtn.snp.centerY)
            })
            .sexy_config({ (label) in
                label.textColor = UIColor.red
                label.font = UIFont.systemFont(ofSize: 15)
            })
        
        choiceLabel = UILabel.sexy_create(choiceView)//选择的商品名称
            .sexy_layout({ (make) in
                make.top.equalTo(priceLabel.snp.bottom).offset(Margin * 0.5)
                make.left.equalTo(priceLabel)
                make.right.equalTo(choiceView).offset(-Margin * 0.5)
            })
            .sexy_config({ (label) in
                label.textColor = UIColor.lightGray
                label.font = UIFont.systemFont(ofSize: 11)
            })
        
        addBtn = UIButton.sexy_create(choiceView)//加按钮
            .sexy_layout { (make) in
                make.bottom.equalTo(confirmBtn.snp.top).offset(-Margin)
                make.right.equalTo(choiceView).offset(-Margin)
                make.width.height.equalTo(25)
            }
            .sexy_config { (btn) in
                btn.addTarget(self, action: #selector(add), for: .touchUpInside)
                btn.setImage(UIImage.init(named: "num_increase"), for: .normal)
                btn.backgroundColor = AthensGrayColor
        }
        
        numberLaebl = UILabel.sexy_create(choiceView)//数量
            .sexy_layout({ (make) in
                make.right.equalTo(addBtn.snp.left).offset(-2)
                make.width.equalTo(addBtn).multipliedBy(1.5)
                make.height.bottom.equalTo(addBtn)
            })
            .sexy_config({ (label) in
                label.text = "1"
                label.backgroundColor = AthensGrayColor
                label.textAlignment = .center
            })
        
        reduceBtn = UIButton.sexy_create(choiceView)//减按钮
            .sexy_layout { (make) in
                make.right.equalTo(numberLaebl.snp.left).offset(-2)
                make.height.width.bottom.equalTo(addBtn)
            }
            .sexy_config { (btn) in
                btn.isEnabled = false
                btn.addTarget(self, action: #selector(reduce), for: .touchUpInside)
                btn.setImage(UIImage.init(named: "num_reduce"), for: .normal)
                btn.backgroundColor = AthensGrayColor
        }
        
        choiceTableView = UITableView.sexy_create(choiceView)//商品列表
            .sexy_layout({ (make) in
                make.top.equalTo(imageView.snp.bottom).offset(Margin)
                make.left.right.equalTo(choiceView)
                make.bottom.equalTo(numberLaebl.snp.top).offset(-Margin)
            })
            .sexy_config({ (tableView) in
                tableView.separatorInset = UIEdgeInsetsMake(-ScreenHeight, 0, 0, 0)
                tableView.delegate = self
                tableView.dataSource = self
                tableView.tableFooterView = UIView()
            })
    }

    func showMenu(view : UIView, tag : Int) {
        view.addSubview(self)
        choiceView.tag = tag
        choiceView.frame = CGRect(x: 0, y: self.height, width: ScreenWidth, height: self.height * 0.6)
        UIView.animate(withDuration: AnimationDuration) {
            self.backgroundColor = UIColor.colorWithCustom(r: 0, g: 0, b: 0, alpha: 0.3)
            self.choiceView.frame = CGRect.init(x: 0, y: self.height * 0.4, width: ScreenWidth, height: self.height * 0.6)
        }
    }
    
    func hideenChice() {
        UIView.animate(withDuration: AnimationDuration, animations: {
            self.backgroundColor = UIColor.clear
            self.choiceView.frame = CGRect.init(x: 0, y: ScreenHeight, width: ScreenWidth, height: self.height * 0.6)
        }) { (_) in
            if self.delegate != nil {
                if self.delegate!.responds(to: #selector(PayMenuDelegate.remove)) {
                    self.delegate?.remove()
                }
            }
            self.removeFromSuperview()
        }
    }
    
    func showImage() {
        
    }
    
    func pay() {
        hideenChice()
        if self.delegate != nil {
            if self.delegate!.responds(to: #selector(PayMenuDelegate.pay(tag:chioce:))) {
                self.delegate?.pay(tag: self.choiceView.tag, chioce: self.selectedTag)
            }
        }
    }
    
    func add() {//增加
        var number = Int(numberLaebl.text!)
        number = number! + 1
        numberLaebl.text = NSString.init(format: "%d", number!) as String
        reduceBtn.isEnabled = true
    }
    
    func reduce() {//减少
        var number = Int(numberLaebl.text!)
        number = number! - 1
        numberLaebl.text = NSString.init(format: "%d", number!) as String
        if number == 1 {
            reduceBtn.isEnabled = false
        }
    }
    
}


extension payMenuView : UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        let touchPoint = touch.location(in: self)
        let tableViewFrame = choiceTableView.convert(choiceTableView.bounds, to: self)
        if tableViewFrame.contains(touchPoint) {
            return false
        }
        else {
            return true
            
        }
    }
}

extension payMenuView : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if choiceData == nil {
            return 0
        }
        return (choiceData?.count)!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let tag = selectedTag
        selectedTag = indexPath.row
        var indexPath : IndexPath = NSIndexPath.init(item: tag!, section: 0) as IndexPath
        tableView.reloadRows(at: [indexPath], with: .none)
        
        indexPath = NSIndexPath.init(item: selectedTag, section: 0) as IndexPath
        tableView.reloadRows(at: [indexPath], with: .none)
        
        let data = choiceData?[indexPath.row]
        let url = URL(string: (data?.attr_pic)!)!
        imageView.kf.setImage(with: url,
                              placeholder: UIImage(named: "loadingbkg"),
                              options: [.transition(.fade(1))],
                              progressBlock: nil,
                              completionHandler: nil)
        
        priceLabel.text = NSString(format: "￥%.2f",(data?.attr_price)!) as String
        choiceLabel.text = NSString(format: "已选择 %@",(data?.attr_value)!) as String
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "choiceCell")
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "choiceCell")
            let _ = UIImageView.sexy_create(cell!)
                .sexy_layout({ (make) in
                    make.top.equalTo(cell!).offset(BigMargin)
                    make.right.bottom.equalTo(cell!).offset(-Margin)
                    make.width.equalTo(33)
                })
                .sexy_config({ (imageView) in
                    imageView.tag = 1
                    imageView.contentMode = .scaleAspectFit
                })
        }
        
        let data = choiceData?[indexPath.row]
        
        let attriMuStr = NSMutableAttributedString.init(string: NSString(format: "%@", (data?.attr_value)!) as String, attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 13)])
        
        let attriStr : NSAttributedString =
            NSAttributedString(string: NSString(format: "  ￥%.2f", (data?.attr_price)!) as String, attributes: [NSForegroundColorAttributeName : UIColor.lightGray, NSFontAttributeName : UIFont.systemFont(ofSize: 12)])
        attriMuStr.append(attriStr)
        
        let imageView : UIImageView = cell!.viewWithTag(1) as! UIImageView
        if indexPath.row == selectedTag {
            attriMuStr.addAttributes([NSForegroundColorAttributeName : UIColor.red], range: NSRange.init(location: 0, length: attriMuStr.length))
            imageView.image = UIImage(named: "choose_icon")
        }
        else {
            imageView.image = UIImage(named: "")
        }
        cell?.textLabel?.attributedText = attriMuStr
        return cell!
    }
}

@objc
protocol PayMenuDelegate : NSObjectProtocol {
    func remove()
    func pay(tag : Int, chioce : Int)
}



