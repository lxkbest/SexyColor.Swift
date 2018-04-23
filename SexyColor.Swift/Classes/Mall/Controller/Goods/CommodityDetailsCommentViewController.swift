//
//  CommodityDetailsCommentViewController.swift
//  SexyColor.Swift
//
//  Created by kayzhang on 2017/8/31.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//商品详情-评论

import UIKit
import MJRefresh

class CommodityDetailsCommentViewController: BaseViewController {
    
    
    fileprivate var tableView : UITableView!
    fileprivate var model : GoodsCommentModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        InitUI()
        loadNewData()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func InitUI() {
        
        tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.register(CommodityDetailsCommodityEvaluationCell.self, forCellReuseIdentifier: "CommodityDetailsCommodityEvaluationCell")
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = GlobalColor
        tableView.separatorColor = UIColor.colorWithHexString(hex: "FAF0E6")
        tableView.separatorInset = UIEdgeInsetsMake(-ScreenHeight, 0, 0, 0)
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(view)
            make.leading.equalTo(view)
            make.trailing.equalTo(view)
            make.bottom.equalTo(view).offset(-NavigationH - 45)
        }
        
        let header = MJRefreshGifHeader()
        header.setRefreshingTarget(self, refreshingAction: #selector(headerRefresh))
        var idleImages = [UIImage]()
        idleImages.append(UIImage(named:"loading_10")!)
        for i in 1...7 {
            idleImages.append(UIImage(named:"loading_\(i)")!)
        }
        header.setImages(idleImages, for: .idle)

        var pullingImages = [UIImage]()
        for i in 7...8 {
            pullingImages.append(UIImage(named:"loading_\(i)")!)
        }
        header.setImages(pullingImages, for: .pulling)
        
        //刷新状态下的图片集合(定时自动改变)
        var refreshingImages = [UIImage]()
        for i in 9...10 {
            refreshingImages.append(UIImage(named:"loading_\(i)")!)
        }
        header.setImages(refreshingImages, for: .refreshing)
        
        header.lastUpdatedTimeLabel.isHidden = true
        header.stateLabel.isHidden = true
        tableView.mj_header = header
        
        tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(footerRefresh))
        tableView.mj_footer.isHidden = true
    }
    
    
    
    func loadNewData() {
        ProgressHUD.show()
        if AppDelegate.netWorkState == .notReachable {
            ProgressHUD.dismiss()
            showBaseView()
            return
        }
        
        let delay = DispatchTime.now() + .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: delay) {
            ProgressHUD.dismiss()
            GoodsCommentData.loadCommodity(completion: { [weak self] (model) in
                self!.model = model.data
                self?.tableView.reloadData()
                self?.tableView.mj_footer.isHidden = false
            })
        }
    }
    
    func footerRefresh() {
        ProgressHUD.show()
        if AppDelegate.netWorkState == .notReachable {
            ProgressHUD.dismiss()
            showBaseView()
            return
        }
        
        let delay = DispatchTime.now() + .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: delay) {
            ProgressHUD.dismiss()
            GoodsCommentData.loadCommodity(completion: { [weak self] (model) in
                for item in model.data!.comment_list! {
                    self!.model?.comment_list?.append(item)
                }
                self?.tableView.reloadData()
                self?.tableView.mj_footer.endRefreshing()
            })
        }
    }
    
    // 顶部刷新
    func headerRefresh(){
        print("下拉刷新")
        // 结束刷新
        tableView.mj_header.endRefreshing()
    }
}

extension CommodityDetailsCommentViewController : UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if model != nil {
            return (model?.comment_list!.count)!
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        
        cell = tableView.dequeueReusableCell(withIdentifier: "CommodityDetailsCommodityEvaluationCell", for: indexPath) as? CommodityDetailsCommodityEvaluationCell
        (cell as! CommodityDetailsCommodityEvaluationCell).CommodityEvaluationData = model?.comment_list![indexPath.row]
        
        return cell!
    }
    
}


