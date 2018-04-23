//
//  OrderDetailViewController.swift
//  SexyColor.Swift
//
//  Created by xiongkai on 2017/9/14.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//  订单详情

import UIKit

class OrderDetailViewController: BaseViewController {

    var orderSN: String?
    fileprivate var tableView : UITableView!
    fileprivate let reuseIdentifier = "\(OrderDetailAddressCell.self)"
    fileprivate var model : OrderDetailModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        loadNewData()
    }

    fileprivate func setUI() {
        
        tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.showsVerticalScrollIndicator = true
        tableView.showsHorizontalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = GlobalColor
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.contentInset = UIEdgeInsetsMake(0, 0, NavigationH, 0)
        
        tableView.register(OrderDetailAddressCell.self, forCellReuseIdentifier: "\(OrderDetailAddressCell.self)")
        tableView.register(OrderDetailInfoCell.self, forCellReuseIdentifier: "\(OrderDetailInfoCell.self)")
        tableView.register(OrderDetailGoodsCell.self, forCellReuseIdentifier: "\(OrderDetailGoodsCell.self)")
        tableView.register(OrderDetailCashierCell.self, forCellReuseIdentifier: "\(OrderDetailCashierCell.self)")
        
        view.addSubview(tableView)
        
        
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.snp.edges)
        }
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
            OrderDetailData.loadOrderDetail(completion: { [weak self] (model) in
                self!.model = model.data
                self!.tableView.reloadData()
            }, sn: self.orderSN!)
        }
    }

}

extension OrderDetailViewController : UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 2 {
            return model?.order_goods?.count ?? 0
        } else {
            if let _ = model?.order_info {
                return 1
            } else {
                return 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(OrderDetailAddressCell.self)", for: indexPath) as! OrderDetailAddressCell
            cell.tupleData = (userName: model?.order_info?.consignee, tel: model?.order_info?.order_tel, address: model?.order_info?.order_address)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(OrderDetailInfoCell.self)", for: indexPath) as! OrderDetailInfoCell
            cell.tupleData = (time: model?.order_info?.add_time, sn: model?.order_info?.order_sn, method: model?.order_info?.pay_id)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(OrderDetailGoodsCell.self)", for: indexPath) as! OrderDetailGoodsCell
            cell.goodsData = model?.order_goods?[indexPath.row]
            return cell
        default:
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 90
        case 1:
            return 80
        case 2:
            return 80
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let info = model?.order_info  {
            if section == 1 {
                let containerView: UIView = UIView(frame: CGRect(x: 0, y: 10, width: ScreenWidth, height: 50))
                containerView.backgroundColor = UIColor.white
                
                let lineView: UIView = UIView(frame: CGRect(x: 0, y: 50, width: ScreenWidth, height: 1))
                lineView.backgroundColor = GlobalColor
                
                let titleLabel = UILabel(frame: CGRect(x: 10, y: 0, width: 100, height: 10))
                titleLabel.center.y = 50 * 0.5
                titleLabel.font = UIFont.systemFont(ofSize: 14)
                titleLabel.textAlignment = .left
                
                let stateLabel = UILabel(frame: CGRect(x: ScreenWidth - 10 - 100, y: 0, width: 100, height: 10))
                stateLabel.center.y = 50 * 0.5
                stateLabel.font = UIFont.systemFont(ofSize: 14)
                stateLabel.textAlignment = .right

                titleLabel.text = "订单信息"
                stateLabel.text = info.order_status
                containerView.addSubview(lineView)
                containerView.addSubview(titleLabel)
                containerView.addSubview(stateLabel)
                
                return containerView
                
            } else if section == 2 {
            
                let containerView: UIView = UIView(frame: CGRect(x: 0, y: 10, width: ScreenWidth, height: 50))
                containerView.backgroundColor = UIColor.white
                
                let lineView: UIView = UIView(frame: CGRect(x: 0, y: 50, width: ScreenWidth, height: 1))
                lineView.backgroundColor = GlobalColor
                
                let titleLabel = UILabel(frame: CGRect(x: 10, y: 0, width: 100, height: 10))
                titleLabel.center.y = 50 * 0.5
                titleLabel.font = UIFont.systemFont(ofSize: 14)
                titleLabel.textAlignment = .left
                
                let stateLabel = UILabel(frame: CGRect(x: ScreenWidth - 10 - 100, y: 0, width: 100, height: 10))
                stateLabel.center.y = 50 * 0.5
                stateLabel.font = UIFont.systemFont(ofSize: 14)
                stateLabel.textAlignment = .right
                
                titleLabel.text = "商品清单"
                stateLabel.text = "共\(model!.order_goods!.count)件"
                containerView.addSubview(lineView)
                containerView.addSubview(titleLabel)
                containerView.addSubview(stateLabel)
                return containerView
            }
        }
        
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 10
        }
        return 60
    }
}
