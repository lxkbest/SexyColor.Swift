//
//  CommodityDetailsRecommendCell.swift
//  SexyColor.Swift
//
//  Created by kayzhang on 2017/8/30.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//商品详情相关推荐

import UIKit

class CommodityDetailsRecommendCell: UITableViewCell {

//    fileprivate var collectionView : UICollectionView!
    fileprivate var collectionView : UICollectionView!
    
    var RecommendGoodsData : [RecommendGoods]? {
        didSet {
            if RecommendGoodsData != nil {
                collectionView.reloadData()
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setSubViews() {
        let layout = UICollectionViewFlowLayout()
        
        let sizeWidth = (ScreenWidth - Margin * 4) / 3
        let sizeHeight = ceilf(Float(sizeWidth + 50))
        
        layout.itemSize = CGSize(width:sizeWidth, height:CGFloat(sizeHeight))
        layout.scrollDirection = .horizontal
        //列间距,行间距,偏移
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10)
        
        collectionView = UICollectionView.init(frame: self.contentView.bounds, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.clear
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier:"imageCell")
        self.contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalTo(self.contentView)
            make.height.equalTo(CGFloat(sizeHeight))
            make.width.equalTo(ScreenWidth)
        }
        collectionView.register(GoodsCollectionViewCell.self, forCellWithReuseIdentifier:"GoodsCollectionViewCell")
    }
}


extension CommodityDetailsRecommendCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    //分区个数
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //自定义cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GoodsCollectionViewCell", for: indexPath) as! GoodsCollectionViewCell
        
        cell.GoodsData = RecommendGoodsData?[indexPath.row]
        
        return cell
    }
    
}
