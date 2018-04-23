//
//  CommodityDetailsCommodityEvaluationCell.swift
//  SexyColor.Swift
//
//  Created by kayzhang on 2017/8/28.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//商品详情商品评价cell

import UIKit
import Kingfisher
import KingfisherWebP

class CommodityDetailsCommodityEvaluationCell: UITableViewCell {

    fileprivate var headerImageView: UIImageView!//头像
    fileprivate var nameLabel : UILabel!//名称
    fileprivate var vipLabel : UILabel!//Vip
    fileprivate var evaluationLabel : UILabel!//评论
    fileprivate var addressLabel : UILabel!//地址
    fileprivate var collectionView : UICollectionView!//9宫格
    
    var imageViewData: NSArray! = []
    
    var CommodityEvaluationData : CommentList? {
        didSet {
            if let data = self.CommodityEvaluationData {//头像
                let url = URL(string: data.avatar!)
                headerImageView.kf.setImage(with: url,
                                            placeholder: UIImage(named: "loadingbkg"),
                                            options: [.processor(WebPProcessor.default),
                                                      .cacheSerializer(WebPSerializer.default)])
                
                nameLabel.text = data.user_name! + "  "
                
                vipLabel.text = " " + data.rank_name! + " "
                
                addressLabel.text = data.region!
                
                evaluationLabel.text = data.user_comment!
                
                if data.comment_img_list!.count > 0 {//有图片

                    let size = (ScreenWidth - 4 * Margin) / 3
                    
                    let rows = data.comment_img_list!.count / 3 + data.comment_img_list!.count % 3 > 0 ? 1 : 0
                    
                    var height = CGFloat(rows) * size + CGFloat(rows - 1) * Margin
                    height = round(height)
                    
                    imageViewData = data.comment_img_list! as NSArray
                    collectionView.snp.remakeConstraints { (make) in
                        make.top.equalTo(evaluationLabel.snp.bottom).offset(Margin)
                        make.right.equalTo(contentView).offset(-Margin)
                        make.left.equalTo(contentView).offset(Margin)
                        let height = make.height.equalTo(height).constraint
                        height.layoutConstraints.first?.priority = UILayoutPriorityDefaultLow
                        make.bottom.right.equalTo(contentView).offset(-Margin)
                    }
                    collectionView.reloadData()
                }
                else {
                    collectionView.snp.remakeConstraints { (make) in
                        make.top.equalTo(evaluationLabel.snp.bottom)
                        make.left.equalTo(contentView).offset(Margin)
                        make.height.equalTo(0)
                        make.bottom.right.equalTo(contentView).offset(-Margin)
                    }
                    collectionView.reloadData()
                }
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

    func setSubViews () {
        headerImageView = UIImageView//头像
        .sexy_create(contentView)
        .sexy_layout({ (make) in
            make.top.left.equalTo(contentView).offset(Margin)
            make.width.height.equalTo(3 * Margin)
        })
        .sexy_config({ (imageView) in
            imageView.backgroundColor = UIColor.red
            imageView.layer.cornerRadius = 15
            imageView.layer.masksToBounds = true
        })

        nameLabel = UILabel//名称
        .sexy_create(contentView)
        .sexy_layout({ (make) in
            make.centerY.equalTo(headerImageView)
            make.left.equalTo(headerImageView.snp.right).offset(Margin)
            make.width.equalTo(4 * Margin).priority(750)
        })
        .sexy_config({ (label) in
            label.font = UIFont.systemFont(ofSize: 13)
            label.textColor = UIColor.lightGray
        })
        
        vipLabel = UILabel//VIP
        .sexy_create(contentView)
        .sexy_layout({ (make) in
            make.top.equalTo(nameLabel)
            make.left.equalTo(nameLabel.snp.right)
            make.width.equalTo(4 * Margin).priority(750)
        })
        .sexy_config({ (label) in
            label.font = UIFont.systemFont(ofSize: 13)
            label.textColor = UIColor.red
            label.layer.borderWidth = 1
            label.layer.borderColor = UIColor.red.cgColor
        })
        
        addressLabel = UILabel//地址
        .sexy_create(contentView)
        .sexy_layout({ (make) in
            make.top.equalTo(nameLabel)
            make.left.equalTo(vipLabel.snp.right).offset(0.5 * Margin)
            make.right.equalTo(contentView).offset(-Margin)
        })
        .sexy_config({ (label) in
            label.font = UIFont.systemFont(ofSize: 13)
            label.textColor = UIColor.lightGray
            label.textAlignment = NSTextAlignment.right
        })
        
        evaluationLabel = UILabel//评论
        .sexy_create(contentView)
        .sexy_layout({ (make) in
            make.top.equalTo(headerImageView.snp.bottom).offset(Margin)
            make.left.equalTo(headerImageView)
            make.right.equalTo(contentView).offset(-Margin)
        })
        .sexy_config({ (label) in
            label.numberOfLines = 0
            label.font = UIFont.systemFont(ofSize: 15)
            label.preferredMaxLayoutWidth = ScreenWidth - Margin * 2
        })
        
        let layout = UICollectionViewFlowLayout()
        var size = (ScreenWidth - 4 * Margin) / 3
        size = round(size)
        
        layout.itemSize = CGSize(width:size, height:size)
        
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        
        collectionView = UICollectionView.init(frame: self.contentView.bounds, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = UIColor.white
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier:"imageCell")
        self.contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(evaluationLabel.snp.bottom).offset(Margin)
            make.left.equalTo(contentView).offset(Margin)
            make.height.equalTo(378)
            make.bottom.right.equalTo(contentView).offset(-Margin)
        }

    }
    
}

extension CommodityDetailsCommodityEvaluationCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if imageViewData.count % 3 != 0 {
            return (imageViewData.count / 3 + 1) * 3
        }
        return imageViewData.count
    }
    
    //分区个数
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //自定义cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath)
        let imageView = UIImageView
        .sexy_create(cell)
        .sexy_layout { (make) in
            make.top.left.right.bottom.equalTo(cell)
        }
        .sexy_config { (imageView) in
            imageView.contentMode = .scaleToFill
        }
        
        var url = URL.init(string: "")
        if indexPath.row < imageViewData.count {
            url = URL(string: imageViewData[indexPath.row] as! String)
        }
        
        imageView.kf.setImage(with: url,
                              placeholder: UIImage(named: "loadingbkg"),
                              options: [.transition(.fade(1))],
                              progressBlock: nil,
                              completionHandler: nil)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photoBrowser = PhotoBrowser()
        let images = imageViewData
        photoBrowser.images = images! as NSArray
        photoBrowser.currentIndex = indexPath.item
        photoBrowser.show()
    }
    
}
