//
//  MallOtherCell.swift
//  SexyColor.Swift
//
//  Created by xiongkai on 2017/9/11.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//

import UIKit

class MallOtherCell: UICollectionViewCell {
    
    var moreClosure: (() -> ())?
    var goodsClosure: ((_ linkUrl: String) -> ())?
    var lineColor: UIColor? {
        didSet {
            titleLabel.textColor = lineColor
        }
    }
    
    var otherData: OtherRecommendList? {
        didSet {
            if let data = otherData {
                titleLabel.text = data.main_title
                subtitleBtn.setTitle(data.subtitle, for: .normal)
                
                let url = URL(string: data.ad_list!.first!.img_url!)
                bannerImageView.kf.setImage(with: url)
                
                bigContainer.contentSize = CGSize(width: CGFloat(data.ad_list!.count - 1) * itemW, height: itemH)
                for i in 0..<data.ad_list!.count - 1 {
                    let frame = CGRect(x: CGFloat(i) * itemW, y: 0, width: itemW, height: itemH)
                    let view = MallGoodsView(frame: frame)
                    view.tag = i + 1
                    view.adListData = data.ad_list![i + 1]
                    view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(setGoodsClick)))
                    bigContainer.addSubview(view)
                }
            }
        }
    }
    
    var smallContainer : UIView!
    var lineViewLeft: UIView!
    var titleLabel: UILabel!
    var lineViewRight: UIView!
    var subtitleBtn: UIButton!
    
    var bannerImageView: UIImageView!
    var bigContainer: UIScrollView!
    
    let itemW: CGFloat = ScreenWidth / 3
    let itemH: CGFloat = 150
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layerLeft = CAGradientLayer()
        layerLeft.frame = lineViewLeft.bounds

        layerLeft.colors = [
            lineColor!.withAlphaComponent(0.0).cgColor,
            lineColor!.withAlphaComponent(0.1).cgColor,
            lineColor!.withAlphaComponent(1.0).cgColor]
        layerLeft.locations = [NSNumber(value: 0.0),NSNumber(value: 0.5),NSNumber(value: 1.0)]
        layerLeft.startPoint = CGPoint(x: 0, y: 0.5)
        layerLeft.endPoint = CGPoint(x: 1, y: 0.5)
        lineViewLeft.layer.addSublayer(layerLeft)
        
        let layerRight = CAGradientLayer()
        layerRight.frame = lineViewRight.bounds
        layerRight.colors = [
            lineColor!.withAlphaComponent(0.0).cgColor,
            lineColor!.withAlphaComponent(0.1).cgColor,
            lineColor!.withAlphaComponent(1.0).cgColor]
        layerRight.locations = [NSNumber(value: 0.0),NSNumber(value: 0.5),NSNumber(value: 1.0)]
        layerRight.startPoint = CGPoint(x: 1, y: 0.5)
        layerRight.endPoint = CGPoint(x: 0, y: 0.5)
        lineViewRight.layer.addSublayer(layerRight)

    }
    
    func setSubViews() {
        
        smallContainer = UIView.sexy_create(contentView)
            .sexy_layout({ (make) in
                make.top.equalTo(contentView)
                make.leading.equalTo(contentView)
                make.trailing.equalTo(contentView)
                make.height.equalTo(30)
            })
            .sexy_config({ (view) in
                view.backgroundColor = GlobalColor
            })
        
        titleLabel = UILabel.sexy_create(smallContainer)
            .sexy_layout({ (make) in
                make.center.equalTo(smallContainer)
                make.width.greaterThanOrEqualTo(20)
                make.height.equalTo(10)
            })
            .sexy_config({ (label) in
                label.font = UIFont.systemFont(ofSize: 12)
                label.textAlignment = .center
            })

        
        lineViewLeft = UIView.sexy_create(smallContainer)
            .sexy_layout({ (make) in
                make.centerY.equalTo(titleLabel)
                make.trailing.equalTo(titleLabel.snp.leading).offset(-5)
                make.width.equalTo(contentView).multipliedBy(0.1)
                make.height.equalTo(1)
            })
 

        
        lineViewRight = UIView.sexy_create(smallContainer)
            .sexy_layout({ (make) in
                make.centerY.equalTo(titleLabel)
                make.leading.equalTo(titleLabel.snp.trailing).offset(4)
                make.width.equalTo(contentView).multipliedBy(0.1)
                make.height.equalTo(1)
            })
 
        
        subtitleBtn = UIButton.sexy_create(smallContainer)
            .sexy_layout({ (make) in
                make.centerY.equalTo(titleLabel)
                make.trailing.equalTo(smallContainer).offset(-Margin)
                make.width.lessThanOrEqualTo(30)
                make.height.equalTo(10)
            })
            .sexy_config({ (btn) in
                btn.titleLabel?.font = UIFont.systemFont(ofSize: 10)
                btn.setImage(UIImage(named: "Home_morer"), for: .normal)
                btn.setTitleColor(UIColor.lightGray, for: .normal)
                btn.addTarget(self, action: #selector(setMoreClick), for: .touchUpInside)
            })
        
        bannerImageView = UIImageView.sexy_create(self)
            .sexy_layout({ (make) in
                make.top.equalTo(smallContainer.snp.bottom)
                make.leading.trailing.equalTo(smallContainer)
                make.height.equalTo(150)
            })
        
        bigContainer = UIScrollView.sexy_create(self)
            .sexy_layout({ (make) in
                make.top.equalTo(bannerImageView.snp.bottom)
                make.leading.trailing.equalTo(bannerImageView)
                make.height.equalTo(150)
            })
            .sexy_config({ (scrollView) in
                scrollView.backgroundColor = UIColor.white
            })
    }
    
    @objc fileprivate func setMoreClick() {
        if moreClosure != nil {
            moreClosure!()
        }
    }
    
    func setGoodsClick(tap: UITapGestureRecognizer) {
        if goodsClosure != nil {
            let linkUrl = otherData?.ad_list?[tap.view!.tag].link_url
            goodsClosure!(linkUrl!)
        }
    }
}
