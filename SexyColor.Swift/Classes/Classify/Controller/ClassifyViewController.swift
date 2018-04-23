//
//  ClassifyViewController.swift
//  SexyColor.Swift
//
//  Created by xiongkai on 2017/8/4.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//  商品分类

import UIKit

class ClassifyViewController: BaseViewController {

    var collView : UICollectionView!
    var layout = UICollectionViewFlowLayout()
    fileprivate let reuseIdentifier = "\(ClassifyCollViewCell.self)"
 
    var model : ClassifyModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        baseView.refreshClosure = { [weak self] in
            self!.loadNewData()
        }
        navigationController?.title = "所有商品分类"
        setUI()
        loadNewData()
    }
    
    func setUI() {
       
        var rect = self.view.frame
        let itemW =  layout.fixSlit(rect: &rect, colCount: 5)
        let itemH: CGFloat = 80.0
        
        
        layout.itemSize = CGSize(width: itemW, height: itemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.headerReferenceSize = CGSize(width: view.width, height: 40)
        collView = UICollectionView(frame: rect, collectionViewLayout: layout)
        collView.dataSource = self
        collView.delegate = self
        collView.backgroundColor = GlobalColor
        collView.alwaysBounceVertical = true
        
        if navigationController!.childViewControllers.count > 1 {
            collView.contentInset = UIEdgeInsetsMake(0, 0, TabbarH, 0)
        } else {
            collView.contentInset = UIEdgeInsetsMake(0, 0, NavigationH + TabbarH, 0)
        }

        
        
        collView.register(ClassifyCollViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collView.register(ClassifyHeadReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "\(ClassifyHeadReusableView.self)")

        view.addSubview(collView)

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
            ClassifyData.loadClassify(completion: { [weak self] (model) in
                self!.model = model.data
                var i = 0
                for var item in self!.model!.category_list! {
                    while (item.sub_category?.count)! % 5 != 0 {
                        item.sub_category!.append(SubCategory())
                        self!.model!.category_list![i] = item
                    }
                    i = i + 1
                }
                self!.collView.reloadData()
            })
        }
    }

    
    
}


extension ClassifyViewController : UICollectionViewDataSource, UICollectionViewDelegate {

    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return model?.category_list?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model?.category_list?[section].sub_category?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ClassifyCollViewCell
        let data = model?.category_list?[indexPath.section].sub_category?[indexPath.item]
        cell.SubCategoryData = data
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "\(ClassifyHeadReusableView.self)", for: indexPath) as! ClassifyHeadReusableView
        headView.headTitle = model?.category_list?[indexPath.section].cat_name
        return headView
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let data = model?.category_list?[indexPath.section].sub_category?[indexPath.item]
        if data?.cat_name != nil {
            let secondView = GoodsListController()
            self.navigationController?.pushViewController(secondView, animated: true)
        }
    }
    
}
 
