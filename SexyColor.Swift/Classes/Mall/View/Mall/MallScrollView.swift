//
//  MallScrollView.swift
//  SexyColor.Swift
//
//  Created by xiongkai on 2017/9/11.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//

import UIKit


class MallScrollView: UICollectionReusableView {


    fileprivate var maxCount = 10
    fileprivate var currentImageView: UIImageView!
    fileprivate var scrollView: UIScrollView!
    fileprivate var pageControl: UIPageControl!
    fileprivate var timer: Timer?
    fileprivate var topAdClosure: ((_ index: Int) -> Void)?
    
    var minFrame : CGRect = CGRect.zero {
        didSet {
            if minFrame != CGRect.zero {
                scrollView.frame.origin.y = minFrame.origin.y
                scrollView.frame.size.height = minFrame.height
                currentImageView.frame.origin.y = minFrame.origin.y
                currentImageView.frame.size.height = minFrame.height
            }
            
        }
    }
    var maxFrame : CGRect = CGRect.zero {
        didSet {
            if maxFrame != CGRect.zero {
                scrollView.frame.size.height = maxFrame.height
                currentImageView.frame.size.height = maxFrame.height
            }
            
        }
    }

    var topAdData: [TopAds]? {
        didSet {
            stopTimer()
            if let data = topAdData {
                if data.count > 0 {
                    maxCount = data.count>=maxCount ? maxCount : data.count
                    pageControl.numberOfPages = maxCount
                    pageControl.currentPage = 0
                    startTimer()
                    setUpdate()
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setScrollView()
        setPageControl()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        scrollView.frame = bounds
        scrollView.contentSize = CGSize(width: scrollView.width * CGFloat(maxCount) , height: 0)
        for i in 0..<maxCount {
            let imageView = scrollView.subviews[i] as! UIImageView
            imageView.frame = CGRect(x: CGFloat(i) * scrollView.width, y: 0, width: scrollView.width, height: scrollView.height)
        }
        pageControl.frame = CGRect(x: (scrollView.width - 100) * 0.5, y: scrollView.height * 0.85, width: 100, height: 20)
        setUpdate()
    }
    
    func setScrollView() {
        scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.bounces = true
        scrollView.delegate = self
        addSubview(scrollView)
        
        for _ in 0..<maxCount {
            let imageView = UIImageView()
            imageView.isUserInteractionEnabled = true
            imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(scrollViewClick(tap:))))
            scrollView.addSubview(imageView)
        }
    }
    
    func setPageControl() {
        pageControl = UIPageControl()
        pageControl.hidesForSinglePage = true
        addSubview(pageControl)
    }
    
    func startTimer() {
        timer = Timer(timeInterval: 3, target: self, selector: #selector(setNext), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .commonModes)
    }
    
    func stopTimer() {
        if timer != nil {
            timer!.invalidate()
            timer = nil
        }
    }
    
    func setNext() {
        scrollView.setContentOffset(CGPoint(x: 2 * scrollView.size.width, y: 0), animated: true)
    }
    
    func scrollViewClick(tap: UIGestureRecognizer) {
        if topAdClosure != nil {
            topAdClosure!(tap.view!.tag)
        }
    }
    
    func setUpdate() {
        for i in 0..<scrollView.subviews.count {
            let imageView = scrollView.subviews[i] as! UIImageView
            var index = pageControl.currentPage
            
            if i == 0 {
                index -= 1
            } else if 2 == i {
                index += 1
            }
            
            if index < 0 {
                index = pageControl.numberOfPages - 1
            } else if index >= pageControl.numberOfPages {
                index = 0
            }
            

            
            imageView.tag = index
            currentImageView = imageView
            if let data = topAdData {
                if data.count > 0 {
                    let img = data[index].img_url!
                    let url = URL(string: img)
                    imageView.kf.setImage(with: url)
                }
            }
            
        }
        scrollView.contentOffset = CGPoint(x: scrollView.width, y: 0)
    }
    
}

extension MallScrollView : UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var page: Int = 0
        var minDistance: CGFloat = CGFloat(MAXFLOAT)
        for i in 0..<scrollView.subviews.count {
            let imageView = scrollView.subviews[i] as! UIImageView
            let distance:CGFloat = abs(imageView.x - scrollView.contentOffset.x)
            if distance < minDistance {
                minDistance = distance
                page = imageView.tag
            }
        }
        pageControl.currentPage = page
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        stopTimer()
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        startTimer()
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        setUpdate()
    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        setUpdate()
    }
}

