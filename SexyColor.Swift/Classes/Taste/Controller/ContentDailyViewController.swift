//
//  DailyViewController.swift
//  SexyColor.Swift
//
//  Created by xiongkai on 2017/9/7.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//  日报

import UIKit
import RxSwift
import Moya
import MJRefresh

class ContentDailyViewController: BaseViewController {

    fileprivate let reuseIdentifier = "\(ContentDailyCell.self)"
    private var tableView: UITableView!
    private var isFirstLoad: Bool = true
    private var isHUDExist: Bool = false
    fileprivate let provider = RxMoyaProvider<ApiManager>()
    fileprivate let dispose = DisposeBag()
    
    var model : DailyModel? {
        didSet {

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setRefresh()
        loadNewData()
        setStates()
    }
 
    func setUI() {
        let frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight)
        tableView = UITableView(frame: frame, style: .plain)
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = AthensGrayColor
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.contentInset = UIEdgeInsetsMake(0, 0, NavigationH + TabbarH, 0)
        tableView.register(ContentDailyCell.self, forCellReuseIdentifier: reuseIdentifier)
        view.addSubview(tableView)
    }
    
    func setStates() {
        isFirstLoad = false
    }
    
    func setRefresh() {
        tableView.mj_header = SCRefreshHeader(refreshingTarget: self, refreshingAction: #selector(loadNewData))
        tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(loadMoreData))
        tableView.mj_footer.isHidden = true

    }

    func loadNewData() {
        if isFirstLoad {
            ProgressHUD.show()
            isFirstLoad = false
        }
        if AppDelegate.netWorkState == .notReachable {
            ProgressHUD.dismiss()
            showBaseView()
            return
        }
        hideBaseView()
        
        let delay = DispatchTime.now() + .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: delay) {
            ProgressHUD.dismiss()
            DailyData.loadDaily(completion: { [weak self] (model) in
                self!.model = model.data
                self!.tableView.reloadData()
                self!.tableView.mj_header.endRefreshing()
                self!.tableView.mj_footer.isHidden = false
            })
        }

    }
    
    func loadMoreData() {
        let delay = DispatchTime.now() + .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: delay) {
            ProgressHUD.dismiss()
            DailyData.loadDaily(completion: { [weak self] (model) in
                if model.data!.c_page_next! <= model.data!.c_total! {
                    for item in model.data!.list! {
                        self!.model?.list?.append(item)
                    }
                    self!.tableView.reloadData()
                    self!.tableView.mj_footer.endRefreshing()
                } else {
                    
                }
                
                
                
                
                
            })
        }
    }
    
}


extension ContentDailyViewController : UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.list?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ContentDailyCell
        cell.DailyData = model?.list?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        

        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
    
}
