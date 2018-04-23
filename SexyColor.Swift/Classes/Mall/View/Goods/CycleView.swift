//
//  CycleView.swift
//  SexyColor.Swift
//
//  Created by kayzhang on 2017/9/5.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//

import UIKit
import Kingfisher
import KingfisherWebP

class CycleView: UIView {
    
    fileprivate var timer:Timer?
    fileprivate var contentScrollView:UIScrollView!
    fileprivate var leftImageView : UIImageView!
    fileprivate var middleImageView : UIImageView!
    fileprivate var rightImageView : UIImageView!
    fileprivate var pageControl : UIPageControl!
    
    weak var delegate : CycleViewDelegate?
    
    var changeFrame : CGRect! {
        didSet {
            if changeFrame != CGRect.zero {
                contentScrollView.frame = CGRect(x: 0, y: 0, width: changeFrame.width, height: changeFrame.height)
                middleImageView.frame = CGRect(x: middleImageView.x, y: middleImageView.y, width: changeFrame.width, height: changeFrame.height)
                timer?.fireDate = Date.distantFuture
                pageControl.frame = CGRect(x: 0, y: changeFrame.height - 30, width: self.width, height: 30)
            }
            else {
                timer?.fireDate = NSDate.init() as Date
            }
        }
    }
    
    var imageArray : [String] = [] {
        didSet {
            if imageArray.count > 1 {
                pageControl.numberOfPages = imageArray.count
                indexOfCurrentImage = 0
                contentScrollView.isScrollEnabled = true
                setScrollViewWithImage()
                setupTimer()
            }
            else {
                pageControl.isHidden = true
                let url = URL(string: imageArray[0])
                middleImageView.kf.setImage(with: url,
                                            placeholder: UIImage(named: "loadingbkg"),
                                            options: [.processor(WebPProcessor.default),
                                                      .cacheSerializer(WebPSerializer.default)])
            }
            
        }
    }
    
    var indexOfCurrentImage: Int! {
        didSet {
            pageControl.currentPage = indexOfCurrentImage
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setScrollViewWithImage() {
        let imageViews = [leftImageView, middleImageView, rightImageView]
        for i in 0...2 {
            var pageNumber = indexOfCurrentImage - 1 + i
            if pageNumber < 0 {
                pageNumber = imageArray.count - 1
            }
            else if pageNumber == imageArray.count {
                pageNumber = 0
            }
            let url = URL(string: imageArray[pageNumber])
            let imageView = imageViews[i]
            imageView?.kf.setImage(with: url,
                                   placeholder: UIImage(named: "loadingbkg"),
                                   options: [.processor(WebPProcessor.default),
                                             .cacheSerializer(WebPSerializer.default)])
        }
        contentScrollView.setContentOffset(CGPoint.init(x: self.width, y: 0), animated: false)
    }
    
    func setSubViews() {
        contentScrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        contentScrollView.contentSize = CGSize.init(width: self.width * 3, height: 0)
        contentScrollView.isPagingEnabled = true
        contentScrollView.isScrollEnabled = false
        contentScrollView.showsVerticalScrollIndicator = false
        contentScrollView.showsHorizontalScrollIndicator = false
        contentScrollView.delegate = self
        contentScrollView.contentSize = CGSize.init(width: self.width * 3, height: 0)
        self.addSubview(contentScrollView)
        
        leftImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        leftImageView.contentMode = .scaleAspectFill
        contentScrollView.addSubview(leftImageView)
        
        middleImageView = UIImageView(frame: CGRect(x: width, y: 0, width: width, height: height))
        middleImageView.contentMode = .scaleAspectFill
        middleImageView.isUserInteractionEnabled = true
        let singleClick = UITapGestureRecognizer(target: self, action: #selector(singleClick(gestureRecognizer:)))
        middleImageView.addGestureRecognizer(singleClick)
        contentScrollView.addSubview(middleImageView)
        
        rightImageView = UIImageView(frame: CGRect(x: width * 2, y: 0, width: width, height: height))
        rightImageView.contentMode = .scaleAspectFill
        contentScrollView.addSubview(rightImageView)
        
        pageControl = UIPageControl(frame: CGRect(x: 0, y: height - 30, width: width, height: 30))
        pageControl.isUserInteractionEnabled = false
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPageIndicatorTintColor = UIColor.red
        self.addSubview(pageControl)
    }
    
    func setupTimer() {
        timer = Timer(timeInterval: CycleAnimationDuration, target: self, selector: #selector(autoChangeCycleCell), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .commonModes)
    }
    
    func autoChangeCycleCell() {
        contentScrollView.setContentOffset(CGPoint.init(x: self.width * 2, y: 0), animated: true)
    }
    
    func singleClick(gestureRecognizer : UITapGestureRecognizer) {
        if delegate != nil {
            if delegate!.responds(to: #selector(delegate?.show(index:))) {
                delegate?.show(index: indexOfCurrentImage)
            }
        }
    }
    
}

extension CycleView : UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        timer?.invalidate()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            self.scrollViewDidEndDecelerating(scrollView)
        }
        timer?.fireDate = NSDate.init() as Date
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let offset = scrollView.contentOffset.x
        let page : NSInteger = NSInteger(offset / width)
        var pageNumber : NSInteger = indexOfCurrentImage + page - 1
        if pageNumber < 0 {
            pageNumber = imageArray.count - 1
        }
        else if pageNumber == imageArray.count {
            pageNumber = 0
        }
        
        indexOfCurrentImage = pageNumber
        setScrollViewWithImage()
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        self.scrollViewDidEndDecelerating(self.contentScrollView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentScrollView.setContentOffset(CGPoint(x: width, y: 0), animated: false)
        
    }
}

@objc
protocol CycleViewDelegate : NSObjectProtocol {
    func show(index : Int)
}
