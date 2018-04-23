//
//  OrderListViewController.swift
//  SexyColor.Swift
//
//  Created by xiongkai on 2017/9/14.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//  订单列表

import UIKit

class OrderListViewController: EmptyViewController {

    fileprivate var tableView : UITableView!

    var model : OrderListModel? {
        didSet {
            if let data = model?.order_list {
                if data.count <= 0 {
                    showEmpty()
                } else {
                    hideEmpty()
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        super.setEmptyEnum(emptyEnum: .order)
        title = "订单列表"
        baseView.refreshClosure = { [weak self] in
            self!.loadNewData()
        }
        
        setUI()
        loadNewData()
    }

    fileprivate func setUI() {

        tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.showsVerticalScrollIndicator = true
        tableView.showsHorizontalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = GlobalColor
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.snp.edges)
        }
    }
    
    func showEmpty() {
        tableView.isHidden = true
    }
    
    func hideEmpty() {
        tableView.isHidden = false
    }
    
    fileprivate func loadNewData() {
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
            OrderListData.loadOrderList(completion: { [weak self] (model) in
                self!.model = model.data
                self!.tableView.reloadData()
            })
        }
    }
    
}

extension OrderListViewController : UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.order_list?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "\(OrderListCell.self)")
        if cell == nil {
            cell = OrderListCell(style: .default, reuseIdentifier: "\(OrderListCell.self)")
        }
        (cell as! OrderListCell).orderListData = model?.order_list?[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let orderSN = model?.order_list?[indexPath.row].order_sn
        let vc = OrderDetailViewController()
        vc.orderSN = orderSN
        navigationController?.pushViewController(vc, animated: true)
        
    }
}
