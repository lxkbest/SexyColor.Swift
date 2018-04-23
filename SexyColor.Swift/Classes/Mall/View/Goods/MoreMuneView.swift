//
//  MoreMuneView.swift
//  SexyColor.Swift
//
//  Created by kayzhang on 2017/9/13.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//

import UIKit

class MoreMuneView: UIView {
    
    var moreChoice : ((_ row : Int) -> ())?//swift 闭包（black）
    var remove : (() -> ())?
    
    fileprivate var tableView : UITableView!
    fileprivate let titleArray = ["回首页", "商品分类", "在线客服", "浏览历史"]
    
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
        
        tableView = UITableView(frame : CGRect(x: 0, y: -176, width: ScreenWidth, height: 176))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.bounces = false
        self.addSubview(tableView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: nil)
        tapGesture.delegate = self
        tableView.addGestureRecognizer(tapGesture)
    }
    
    func showMenu(view : UIView) {
        view.addSubview(self)
        tableView.y = -176
        UIView.animate(withDuration: AnimationDuration) {
            self.backgroundColor = UIColor.colorWithCustom(r: 0, g: 0, b: 0, alpha: 0.3)
            self.tableView.y = 0
        }
    }
    
    func hideenChice() {
        if self.remove != nil {
            self.remove!()
        }
        UIView.animate(withDuration: AnimationDuration, animations: {
            self.backgroundColor = UIColor.clear
            self.tableView.y = -176
        }) { (_) in
            self.removeFromSuperview()
        }
    }
}

extension MoreMuneView : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
            cell?.textLabel?.textColor = UIColor.gray
            cell?.textLabel?.font = UIFont.systemFont(ofSize: 15)
            cell?.accessoryType = .disclosureIndicator
            cell?.selectionStyle = .none
        }
        cell?.textLabel?.text = titleArray[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//MARK: - 点击
        hideenChice()
        if moreChoice != nil {
            moreChoice!(indexPath.row)
        }
        
    }
}

extension MoreMuneView : UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        let touchPoint = touch.location(in: self)
        let tableViewFrame = tableView.convert(tableView.bounds, to: self)
        if tableViewFrame.contains(touchPoint) {
            return false
        }
        else {
            return true
            
        }
    }
}
