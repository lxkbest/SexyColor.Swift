//
//  TasteViewController.swift
//  SexyColor.Swift
//
//  Created by xiongkai on 2017/8/4.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//  趣ing

import UIKit

class TasteViewController: BaseViewController {

    
    private var controllersArr: [UIViewController] = [ContentDailyViewController(), ContentEpisodeViewController(), ContentVideoViewController(), ContentImageViewController()]
    fileprivate var containerScrollView: UIScrollView!
    fileprivate var segmentView: FourSegmentView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNav()
        setChild()
        setUI()
        
    }
    
    func setNav() {
        segmentView = FourSegmentView(oneText: "日报", twoText: "段子", threeText: "视频", fourText: "图片")
        segmentView.frame = CGRect(x: 0, y: 0, width: ScreenWidth * 0.5, height: 44)
        segmentView.delegate = self
        navigationItem.titleView = segmentView
    }
    
    func setChild() {
        for vc in controllersArr {
            self.addChildViewController(vc)
        }
    }
    
    func setUI() {
        automaticallyAdjustsScrollViewInsets = false
        let frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight - NavigationH - TabbarH)
        containerScrollView = UIScrollView(frame: frame)
        containerScrollView.backgroundColor = GlobalColor
        containerScrollView.isPagingEnabled = true
        containerScrollView.contentSize = CGSize(width: ScreenWidth * 4, height: 0)
        containerScrollView.showsHorizontalScrollIndicator = false
        containerScrollView.showsVerticalScrollIndicator = false
        containerScrollView.delegate = self
        view.addSubview(containerScrollView)
        
        scrollViewDidEndScrollingAnimation(containerScrollView)
    }
    
    func setController() {
    
    }
}

extension TasteViewController: FourSegmentViewDelegate {
    func fourSegmentView(fourSegmentView: FourSegmentView, clickBtn btn: UIButton, fonIndex index: Int) {
        containerScrollView.setContentOffset(CGPoint(x: ScreenWidth * CGFloat(index), y: 0), animated: true)
    }
}

extension TasteViewController: UIScrollViewDelegate {
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let index = scrollView.contentOffset.x / scrollView.frame.size.width
        let vc = self.childViewControllers[Int(index)]
        vc.view.frame = CGRect(x: scrollView.contentOffset.x, y: 0, width: scrollView.width, height: scrollView.height)
        scrollView.addSubview(vc.view)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollViewDidEndScrollingAnimation(scrollView)
        if scrollView === containerScrollView {
            let index = Int(scrollView.contentOffset.x / ScreenWidth)
            segmentView.btnToIndex(index: index)
        }
    }
}
