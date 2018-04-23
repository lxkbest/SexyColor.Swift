//
//  SegmentView.swift
//  SexyColor.Swift
//
//  Created by xiongkai on 2017/9/7.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//  简单四分段视图

import UIKit

class FourSegmentView: UIView {

    private let oneTextButton: UIButton = UIButton()
    private let twoTextButton: UIButton = UIButton()
    private let threeTextButton: UIButton = UIButton()
    private let fourTextButton: UIButton = UIButton()
    
    private let textColor: UIColor = UIColor.gray
    private let textFont: UIFont = UIFont.systemFont(ofSize: 15)
    
    
    private let lineView: UIView = UIView()
    private var selectedBtn: UIButton?
    weak var delegate: FourSegmentViewDelegate?
    
    
    convenience init(oneText: String, twoText: String, threeText: String, fourText: String) {
        self.init()
        setButton(btn: oneTextButton, title: oneText, tag: 100)
        setButton(btn: twoTextButton, title: twoText, tag: 101)
        setButton(btn: threeTextButton, title: threeText, tag: 102)
        setButton(btn: fourTextButton, title: fourText, tag: 103)
        setLineView()
        btnClick(sender: oneTextButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let btnW = width * 0.25
        oneTextButton.frame = CGRect(x: 0, y: 0, width: btnW, height: height)
        twoTextButton.frame = CGRect(x: btnW, y: 0, width: btnW, height: height)
        threeTextButton.frame = CGRect(x: btnW * 2, y: 0, width: btnW, height: height)
        fourTextButton.frame = CGRect(x: btnW * 3, y: 0, width: btnW, height: height)
        lineView.frame = CGRect(x: 0, y: height - 2, width: btnW, height: 2)
    }
    
    func setButton(btn: UIButton, title: String, tag: Int) {
        btn.setTitleColor(textColor, for: .normal)
        btn.setTitleColor(UIColor.red, for: .selected)
        btn.titleLabel?.font = textFont
        btn.tag = tag
        btn.setTitle(title, for: .normal)
        btn.addTarget(self, action: #selector(btnClick(sender:)), for: .touchUpInside)
        addSubview(btn)

    }
    
    func setLineView() {
        lineView.backgroundColor = UIColor.red
        addSubview(lineView)
    }
    
    func btnClick(sender: UIButton) {
        selectedBtn?.isSelected = false
        sender.isSelected = true
        selectedBtn = sender
        lineMove(index: sender.tag - 100)
        delegate?.fourSegmentView(fourSegmentView: self, clickBtn: sender, fonIndex: sender.tag - 100)
    }
    
    func btnToIndex(index: Int) {
        let btn = viewWithTag(index + 100) as! UIButton
        btnClick(sender: btn)
    }
    
    func lineMove(index: Int) {
        UIView.animate(withDuration: AnimationDuration) { 
            self.lineView.x = CGFloat(index) * self.lineView.width
        }
    }
    
}


protocol FourSegmentViewDelegate : NSObjectProtocol {
    func fourSegmentView(fourSegmentView: FourSegmentView, clickBtn btn: UIButton, fonIndex index: Int)
}

