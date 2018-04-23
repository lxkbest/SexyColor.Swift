//
//  GuideViewController.swift
//  SexyColor.Swift
//
//  Created by xiongkai on 2017/8/4.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//

import UIKit

let GuideCellIdentifier:String = "GuideCell"

class GuideViewController: UIViewController {
    
    var collectionView: UICollectionView?
    var pageControl: UIPageControl?
    var isShowBtn: Bool = true
    let images = ["guide_40_1","guide_40_2","guide_40_3","guide_40_4"]


    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.setStatusBarHidden(false, with: .none)
        setCollectionView()
        setPageControl()

        // Do any additional setup after loading the view.
    }

    func setCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = ScreenBounds.size
        layout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: ScreenBounds, collectionViewLayout: layout)
        collectionView?.dataSource = self
        collectionView?.delegate = self
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.isPagingEnabled = true
        collectionView?.bounces = false
        collectionView?.register(GuideCell.self, forCellWithReuseIdentifier: GuideCellIdentifier)
        self.view.addSubview(collectionView!)
        
    
    }
    
    func  setPageControl() {
        let frame = CGRect(x: 0, y: ScreenHeight - 30, width: ScreenWidth, height: 20)
        pageControl = UIPageControl(frame: frame)
        pageControl?.currentPage = 0
        pageControl?.numberOfPages = images.count
        pageControl?.isHidden = true
        self.view.addSubview(pageControl!)
    }
    
}

extension GuideViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GuideCellIdentifier, for: indexPath) as? GuideCell
        cell?.image = UIImage(named: images[indexPath.row])
        if indexPath.row == images.count - 1 {
            cell?.setHiddenBtn(false)
        }
        return cell!
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x == CGFloat(images.count - 1) * ScreenWidth {
            let cell = collectionView?.cellForItem(at: IndexPath(row: images.count - 1, section: 0)) as? GuideCell
            cell?.setHiddenBtn(false)
            isShowBtn = false
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x != CGFloat(images.count - 1) * ScreenWidth &&
            !isShowBtn &&
            scrollView.contentOffset.x > CGFloat(images.count - 2) * ScreenWidth {
            
            let cell = collectionView?.cellForItem(at: IndexPath(row: images.count - 1, section: 0)) as? GuideCell
            cell?.setHiddenBtn(true)
            isShowBtn = true
        }
        pageControl?.currentPage = Int(scrollView.contentOffset.x / ScreenWidth + 0.5)
    }


}
