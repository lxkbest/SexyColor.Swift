//
//  PhotoBrowser.swift
//  SexyColor.Swift
//
//  Created by kayzhang on 2017/9/7.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//

import UIKit

class PhotoBrowser: UIView {
    
    fileprivate var collectionView : UICollectionView!
    var pageControl : UIPageControl!//开放用于修改颜色
    
    var images : NSArray = [] {
        didSet {
            collectionView.reloadData()
            pageControl.numberOfPages = images.count
        }
    }
    
    var currentIndex : Int! = 0 {
        didSet {
            collectionView.setContentOffset(CGPoint(x: ScreenWidth * CGFloat(currentIndex), y: 0), animated: false)
            pageControl.currentPage = currentIndex
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
        
        self.backgroundColor = UIColor.black
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight), collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(PhotoBrowserCell.self, forCellWithReuseIdentifier: "PhotoBrowserCell")
        self.addSubview(collectionView)
        
        pageControl = UIPageControl(frame: CGRect(x: 0, y: ScreenHeight - 30, width: 5, height: 30))
        pageControl.isUserInteractionEnabled = false
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPageIndicatorTintColor = UIColor.red
        self.addSubview(pageControl)
    }
    
    func show() {
        let window = UIApplication.shared.keyWindow
        self.frame = (window?.bounds)!
        window?.addSubview(self)
    }
}

extension PhotoBrowser : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : PhotoBrowserCell = collectionView .dequeueReusableCell(withReuseIdentifier: "PhotoBrowserCell", for: indexPath) as! PhotoBrowserCell
        if cell.photoImage.imageDelegate == nil {
            cell.photoImage.imageDelegate = self
        }
        cell.photoImage.imageUrl = images[indexPath.item] as! String
        cell.photoImage.zoomScale = 1.0;
        
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let PhotoCell = cell as! PhotoBrowserCell
        PhotoCell.photoImage.zoomScale = 1.0
    }
    
}

extension PhotoBrowser : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.bounds.size
    }
}

extension PhotoBrowser : UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {//设置page
        let offsetX = scrollView.contentOffset.x / scrollView.width
        pageControl.currentPage = Int(offsetX)
    }
}

extension PhotoBrowser : PhotoBrowserImageDelegate {
    func singleClickWithPhoto(photo: PhotoBrowserImage) {
//        UIView.animate(withDuration: AnimationDuration, animations: {
//            self.alpha = 0.3
//        }, completion: { (_) in
//            self.removeFromSuperview()
//        })
        self.removeFromSuperview()
    }
}

