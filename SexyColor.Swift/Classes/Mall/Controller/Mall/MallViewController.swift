//
//  MallViewController.swift
//  SexyColor.Swift
//
//  Created by xiongkai on 2017/8/4.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//  商城

import UIKit

class MallViewController: BaseViewController {
    
    private var collectionView: UICollectionView!
    private var isShow : Bool = true
    
    fileprivate var scroll: MallNewScrollView!
    
    fileprivate var bgView : UIView!
    fileprivate var imageView: UIImageView!
    fileprivate var colorState: UIColor?
    fileprivate var colorSet: UIColor = UIColor.red
    fileprivate var msgTitle: String?
    fileprivate var widthSet: CGFloat = 0
    
    var model: MallModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNav()
        setUI()
        loadNewData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isTranslucent = true
        
        navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController!.navigationBar.shadowImage = UIImage()
        if colorState != nil {
            navigationController?.navigationBar.lt_setBackgroundColor(colorState)
        } else {
            navigationController?.navigationBar.lt_setBackgroundColor(colorSet.withAlphaComponent(0))
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = nil
        
        if navigationController?.navigationBar.overlay != nil {
            colorState = navigationController?.navigationBar.overlay.backgroundColor
        }
        
        
        let colorWith = UIColor.white
        navigationController?.navigationBar.lt_setBackgroundColor(colorWith.withAlphaComponent(1))
        navigationController?.navigationBar.isTranslucent = false
    }
    
    func setNavLeftClick() {

        let vc = ClassifyViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func setNav() {
        

        bgView = UIView()
        bgView.frame = CGRect(x: 0, y: 0, width: ScreenWidth - 100, height: 30)
        bgView.backgroundColor = UIColor.white
        bgView.layer.cornerRadius = 2
        bgView.layer.masksToBounds = true
        bgView.isUserInteractionEnabled = true
        navigationItem.titleView = bgView
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "分类", titleColor: UIColor.white, imageName: "Topl_fenlei", highlImageName: "Topl_fenlei", targer: self, action: #selector(setNavLeftClick), edge: UIEdgeInsets(top: 0, left: -30, bottom: 0, right: 0))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "客服", titleColor: UIColor.white, imageName: "Topr_kefu", highlImageName: "Topr_kefu", targer: self, action: #selector(setNavLeftClick) , edge: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -30))
        
        imageView = UIImageView.sexy_create(bgView)
            .sexy_layout({ (make) in
                make.centerY.equalTo(bgView)
                make.left.equalTo(bgView).offset(5)
                make.width.height.equalTo(24)
            }).sexy_config({ (imageView) in
                imageView.image = UIImage(named: "list_topSearch")
            })
        
        let _ = UILabel.sexy_create(bgView)
            .sexy_layout { (make) in
                make.left.equalTo(imageView.snp.right).offset(5)
                make.centerY.equalTo(bgView)
            }.sexy_config { (label) in
                label.text = "搜索您感兴趣的商品"
                label.font = UIFont.systemFont(ofSize: 12)
                label.textColor = UIColor.lightGray
            }
    }
    
    func setUI() {
        automaticallyAdjustsScrollViewInsets = false
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        collectionView = UICollectionView(frame: ScreenBounds, collectionViewLayout: layout)
        collectionView.backgroundColor = GlobalColor
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0)
        
        collectionView.register(MallOtherCell.self, forCellWithReuseIdentifier: "\(MallOtherCell.self)")
        collectionView.register(MallProductCell.self, forCellWithReuseIdentifier: "\(MallProductCell.self)")
        
        collectionView.register(MallScrollView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "\(MallScrollView.self)")
        
        collectionView.register(MallHotView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "\(MallHotView.self)")
        
        collectionView.register(MallTitleView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "\(MallTitleView.self)")
        
        view.addSubview(collectionView)
        
        let frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: 250)
        scroll = MallNewScrollView(frame: frame)
        view.addSubview(scroll)
    }
    
    func loadNewData() {
        
        ProgressHUD.show()
        if AppDelegate.netWorkState == .notReachable {
            ProgressHUD.dismiss()
            showBaseView()
            return
        }
        hideBaseView()
        let delay = DispatchTime.now() + .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: delay) {
            ProgressHUD.dismiss()
            MallData.loadMall(completion: { [weak self] (model) in
                self!.model = model.data
                self!.msgTitle = "必败单品"
                self!.scroll.topAdData = model.data?.top_ads
                self!.collectionView.reloadData()
            })
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let alpha =  1 - ((120 + 64 - offsetY) / 64)
        if offsetY > 120 {
           navigationController?.navigationBar.lt_setBackgroundColor(colorSet.withAlphaComponent(alpha))
        } else {
           navigationController?.navigationBar.lt_setBackgroundColor(colorSet.withAlphaComponent(0))
        }
        
        if offsetY <= widthSet {
            let maxFrame = CGRect(x: ScreenWidth, y: 0 , width: ScreenWidth , height: -offsetY + 250)
            scroll.frame.origin.y =  0
            scroll.frame.size.width = ScreenWidth
            scroll.frame.origin.x = 0
            scroll.frame.size.height = -offsetY + 250
            scroll.maxFrame = maxFrame
        } else {
            let minFrame = CGRect(x: 0, y: 0 , width: ScreenWidth , height: -offsetY)
            scroll.frame.origin.y = -offsetY
            scroll.minFrame = minFrame
        }
    }
}

extension MallViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 0
        } else if section == 1 {
            return 0
        } else if section == 2 {
            return model?.other_recommend_list?.count ?? 0
        } else if section == 3 {
            return model?.product_recommendation?.count ?? 0
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 2 {
            let otherCell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(MallOtherCell.self)", for: indexPath) as! MallOtherCell
            otherCell.lineColor = UIColor.randomColor()
            otherCell.otherData = model!.other_recommend_list![indexPath.item]
            otherCell.moreClosure = { [weak self] in
                let vc = GoodsListController()
                self!.navigationController?.pushViewController(vc, animated: true)
            }
            otherCell.goodsClosure = { [weak self] (linkUrl) in
                let vc = MenuSilderViewController()
                vc.GoodsId = linkUrl
                self!.navigationController?.pushViewController(vc, animated: true)
            }
            return otherCell
        } else if indexPath.section == 3 {
            let productCell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(MallProductCell.self)", for: indexPath) as! MallProductCell
            productCell.productData = model!.product_recommendation![indexPath.item]
            return productCell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 3 {
            let data = model?.product_recommendation?[indexPath.item]
            if data != nil {
                let vc = MenuSilderViewController()
                vc.GoodsId = String(describing: data!.goods_id)
                navigationController?.pushViewController(vc, animated: true)
            }

        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            if indexPath.section == 0 {
                let mallScrollView = collectionView .dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "\(MallScrollView.self)", for: indexPath) as! MallScrollView
                mallScrollView.topAdData = model?.top_ads
                return mallScrollView
 
            } else if indexPath.section == 1 {
                let mallHotView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "\(MallHotView.self)", for: indexPath) as! MallHotView
                mallHotView.hotListData = model?.hot_list
                mallHotView.hotListClosure = { [weak self] (index) in
                    let vc = GoodsListController()
                    self!.navigationController?.pushViewController(vc, animated: true)
                }
                return mallHotView
 
            } else if indexPath.section == 3 {
                let mallTitleView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "\(MallTitleView.self)", for: indexPath)
                    as! MallTitleView
                mallTitleView.msgData = msgTitle
                return mallTitleView
            }
            
        }
        return UICollectionReusableView()
    }
}

extension MallViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var itemSize = CGSize.zero
        if indexPath.section == 2 {
            itemSize = CGSize(width: ScreenWidth, height: 330)
        } else if indexPath.section == 3 {
            itemSize = CGSize(width: ScreenWidth * 0.5 - 1, height: ScreenWidth * 0.5 + 60)
        }
        return itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        var itemSize = CGSize.zero
        if section == 0 {
            itemSize = CGSize(width: 0, height: 250)
        } else if section == 1 {
            itemSize = CGSize(width: 0, height: 160)
        } else if section == 3 {
            itemSize = CGSize(width: 0, height: 30)
        }
        return itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if section == 3 {
            return 2
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if section == 3 {
            return 2
        }
        return 0
    }
}


