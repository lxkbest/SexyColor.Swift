//
//  GoodsListChoiceMenuView.swift
//  SexyColor.Swift
//
//  Created by kayzhang on 2017/9/11.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//

import UIKit

class GoodsListChoiceMenuView: UIView {
    fileprivate var choiceView : UIView!
    fileprivate var leftTableView : UITableView!
    fileprivate var rightTableView : UITableView!
    fileprivate var leftIndex : Int! = 0
    fileprivate let leftData = ["品牌", "特点", "价格区间"]
    
    weak var delegate : GoodsListChoiceMenuDelegate?
    
    var GoodsListChoiceMenuData : Screening? {
        didSet {
            leftTableView.selectRow(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .none)
            rightTableView.reloadData()
        }
    }
    
    var tagChoiceData : Array<Int>! = [-1, -1, -1]
    
    
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
        
        choiceView = UIView(frame: CGRect(x: 0, y: -ScreenHeight * 0.5, width: ScreenWidth, height: ScreenHeight * 0.5))
        self.addSubview(choiceView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: nil)
        tapGesture.delegate = self
        choiceView.addGestureRecognizer(tapGesture)
        
        setTableView()
        
    }
    
    func setTableView() {
        leftTableView = UITableView(frame: CGRect(x: 0, y: 0, width: ScreenWidth / 3, height: choiceView.height))
        leftTableView.delegate = self
        leftTableView.dataSource = self
        leftTableView.separatorInset = UIEdgeInsetsMake(-ScreenHeight / 3, 0, 0, 0)
        leftTableView.backgroundColor = AthensGrayColor
        leftTableView.tableFooterView = UIView()
        choiceView.addSubview(leftTableView)
        
        rightTableView = UITableView(frame: CGRect(x: ScreenWidth / 3, y: 0, width: ScreenWidth / 3 * 2, height: choiceView.height))
        rightTableView.delegate = self
        rightTableView.dataSource = self
        rightTableView.tableFooterView = UIView()
        choiceView.addSubview(rightTableView)
    }
    
    func showMenu(view : UIView) {
        view.addSubview(self)
        choiceView.frame = CGRect(x: 0, y: -ScreenHeight * 0.5, width: ScreenWidth, height: ScreenHeight * 0.5)
        UIView.animate(withDuration: AnimationDuration) {
            self.backgroundColor = UIColor.colorWithCustom(r: 0, g: 0, b: 0, alpha: 0.3)
            self.choiceView.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight * 0.5)
        }
    }
    
    func hideenChice() {
        UIView.animate(withDuration: AnimationDuration, animations: {
            self.backgroundColor = UIColor.clear
            self.choiceView.frame = CGRect(x: 0, y: -ScreenHeight * 0.5, width: ScreenWidth, height: ScreenHeight * 0.5)
        }) { (_) in
            if self.delegate != nil {
                if self.delegate!.responds(to: #selector(GoodsListChoiceMenuDelegate.hidden)) {
                    self.delegate?.hidden()
                }
            }
            self.removeFromSuperview()
        }
    }
    
}

extension GoodsListChoiceMenuView : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == leftTableView {
            return 3
        }
        else {
            if GoodsListChoiceMenuData == nil {
                return 0
            }
            var rightNumber = 0
            if leftIndex == 0 {
                rightNumber = (GoodsListChoiceMenuData?.brands?.count)!
            }
            else if leftIndex == 1 {
                rightNumber = (GoodsListChoiceMenuData?.characteristic?.count)!
            }
            else if leftIndex == 2 {
                rightNumber = (GoodsListChoiceMenuData?.price_grade?.count)!
            }
            return rightNumber
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == leftTableView {
            if leftIndex != indexPath.row {
                leftIndex = indexPath.row
                rightTableView.reloadData()
            }
        }
        else {
//MARK : - 隐藏
            tagChoiceData[leftIndex] = indexPath.row
            if delegate != nil {
                if delegate!.responds(to: #selector(GoodsListChoiceMenuDelegate.choice(data:))) {
                    delegate?.choice(data: tagChoiceData)
                }
            }
            hideenChice()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        if tableView == leftTableView {
            cell = tableView.dequeueReusableCell(withIdentifier: "goodsListChoiceCell")
            if cell == nil {
                cell = UITableViewCell(style: .default, reuseIdentifier: "goodsListChoiceCell")
                cell?.backgroundColor = UIColor.clear
            }
            cell?.selectedBackgroundView = UIView(frame: CGRect(x: 0, y: 0, width: (cell?.width)!, height: (cell?.height)! - 2))
            cell?.selectedBackgroundView?.backgroundColor = UIColor.white
            
            cell?.textLabel?.textAlignment = .center
            cell?.textLabel?.highlightedTextColor = UIColor.red
            cell?.textLabel?.text = leftData[indexPath.row]
        }
        else {
            cell = tableView.dequeueReusableCell(withIdentifier: "choiceCell")
            if cell == nil {
                cell = UITableViewCell.init(style: .default, reuseIdentifier: "choiceCell")
                cell?.selectionStyle = .none
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
                
                cell?.backgroundColor = UIColor.white
            }
            
//            MARK : - 处理右边tableview的数据显示  回调修改后的tagChoiceData以便网络获取或下次的记录
//            MARK : - 缺少一个展示选中的视图（预计是内部是用按钮弄的）
            
            var Str = ""
            
            if leftIndex == 0 {
                let data = GoodsListChoiceMenuData?.brands?[indexPath.row]
                Str = (data?.brand_name)!
            }
            else if leftIndex == 1 {
                let data = GoodsListChoiceMenuData?.characteristic?[indexPath.row]
                Str = (data?.name)!
            }
            else if leftIndex == 2 {
                let data = GoodsListChoiceMenuData?.price_grade?[indexPath.row]
                Str = (data?.price_range)!
            }
            cell?.textLabel?.text = Str
            
            let rightIndex = tagChoiceData[leftIndex]
            
            let imageView : UIImageView = cell!.viewWithTag(1) as! UIImageView
            if indexPath.row == rightIndex {
                imageView.image = UIImage(named: "choose_icon")
                cell?.textLabel?.textColor = UIColor.red
            }
            else {
                imageView.image = UIImage(named: "")
                cell?.textLabel?.textColor = UIColor.black
            }
        }
        
        return cell!
    }
}

extension GoodsListChoiceMenuView : UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        let touchPoint = touch.location(in: self)
        let leftTableViewFrame = leftTableView.convert(leftTableView.bounds, to: self)
        let rightTableViewFrame = rightTableView.convert(rightTableView.bounds, to: self)
        if leftTableViewFrame.contains(touchPoint) || rightTableViewFrame.contains(touchPoint) {
            return false
        }
        else {
            return true
            
        }
    }
}

@objc
protocol GoodsListChoiceMenuDelegate : NSObjectProtocol {
    func choice(data : Array<Int>)
    func hidden()
}
