//
//  ShopcartViewController.swift
//  SexyColor.Swift
//
//  Created by xiongkai on 2017/8/4.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//  购物车

import UIKit

class ShopcartViewController: EmptyViewController {

    fileprivate var tableView : UITableView!
    fileprivate let reuseIdentifier = "\(ShopcartCell.self)"
    fileprivate var isFirstLeves = true
    fileprivate var containerView : UIView!
    fileprivate var allCheckBtn : UIButton!
    fileprivate var totlePriceLabel : UILabel!
    fileprivate var cashierBtn : UIButton!
    
    var model : ShopCartModel? {
        didSet {
            if let data = model?.carts_list {
                if data.count <= 0 {
                    showEmpty()
                } else {
                    hideEmpty()
                }
            }
        }
    }
    
    private var totlePrice: Double = 0.00
    private var totleCount: Int = 0
    
    override func viewDidLoad() {
        navigationController?.title = "购物车"
        super.viewDidLoad()
        baseView.refreshClosure = { [weak self] in
            self!.loadNewData()
        }
        super.setEmptyEnum(emptyEnum: .cart)
        setUI()
        setContainer()
        loadNewData()
    }
    
    func setUI() {
        
        if navigationController!.childViewControllers.count > 1 {
            isFirstLeves = false
        }
        
        var tableViewHeight:CGFloat = ScreenHeight - TabbarH
        if !isFirstLeves {
            tableViewHeight = ScreenHeight
        }
        let frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: tableViewHeight)

        tableView = UITableView(frame: frame, style: .plain)
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = AthensGrayColor
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.contentInset = UIEdgeInsetsMake(0, 0, NavigationH * 2, 0)
        tableView.register(ShopcartCell.self, forCellReuseIdentifier: reuseIdentifier)
        view.addSubview(tableView)
    }
    
    func setContainer() {
        var ViewY = ScreenHeight - TabbarH - NavigationH * 2
        if !isFirstLeves {
            ViewY = ScreenHeight - NavigationH * 2
        }

        
        containerView = UIView(frame: CGRect(x: 0, y: ViewY, width: ScreenWidth, height: NavigationH))
        containerView.backgroundColor = UIColor.white
        view.addSubview(containerView)

        
        allCheckBtn = UIButton.sexy_create(containerView)
            .sexy_layout({ (make) in
                make.leading.equalTo(containerView).offset(Margin)
                make.centerY.equalTo(containerView)
                make.width.height.greaterThanOrEqualTo(22)
            })
            .sexy_config({ (btn) in
                btn.setImage(UIImage(named: "radio"), for: .normal)
                btn.setImage(UIImage(named: "radio_selected"), for: .selected)
                btn.setTitle("全选", for: .normal)
                btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
                btn.setTitleColor(UIColor.black, for: .normal)
                btn.addTarget(self, action: #selector(checkAll(sender:)), for: .touchUpInside)
            })
        
        totlePriceLabel = UILabel.sexy_create(containerView)
            .sexy_layout({ (make) in
                make.leading.equalTo(allCheckBtn.snp.trailing).offset(Margin)
                make.centerY.equalTo(containerView)
                make.width.height.greaterThanOrEqualTo(30)
            })
            .sexy_config({ (label) in
                label.textColor = UIColor.red
                label.font = UIFont.systemFont(ofSize: 15)
            })
        
        cashierBtn = UIButton.sexy_create(containerView)
            .sexy_layout({ (make) in
                make.trailing.equalTo(containerView).offset(-Margin)
                make.top.equalTo(containerView).offset(Margin)
                make.bottom.equalTo(containerView).offset(-Margin)
                make.width.equalTo(120)
            })
            .sexy_config({ (btn) in
                btn.setBackgroundImage(UIImage(named: "buttonLongRed"), for: .normal)
                btn.setBackgroundImage(UIImage(named: "cancel_btn_bg"), for: .selected)
                btn.setTitle("去结算", for: .normal)
                btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            })
        
        containerView.isHidden = true
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
            ShopCartData.loadCarts(completion: { [weak self] (model) in
                self!.model = model.data
                self!.tableView.reloadData()
                self!.allCheckBtn.isSelected = true
                self!.totalAll()
                self!.containerView.isHidden = false
            })
        }
    }
    
    func checkAll(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            for i in 0..<model!.carts_list!.count {
                model!.carts_list![i].is_check = true
            }
        } else {
            for i in 0..<model!.carts_list!.count {
                model!.carts_list![i].is_check = false
            }
        }
        totalAll()
        tableView.reloadData()
    }
    
    func totalAll() {
        for item in model!.carts_list! {
            if item.is_check! {
                totlePrice += Double(item.app_price!) * Double(item.goods_number!)
                totleCount += 1
            }
        }
        if totleCount > 0 {
            cashierBtn.isEnabled = true
        } else {
            cashierBtn.isEnabled = false
        }
        cashierBtn.setTitle("去结算(\(totleCount))", for: .normal)
        totlePriceLabel.text = "总金额:\(totlePrice.toString())"
        
        totlePrice = 0.00
        totleCount = 0
    }
    
    func showEmpty() {
        tableView.isHidden = true
        containerView.isHidden = true
    }
    
    func hideEmpty() {
        tableView.isHidden = false
        containerView.isHidden = false
    }
}

extension ShopcartViewController : ShopcartDelegate {

    func checkGoods(_ cell: ShopcartCell) {
        if cell.CartsListData!.is_expiry! {
            cell.CartsListData?.is_check = !cell.CartsListData!.is_check!
            let list = model!.carts_list!
            for i in 0...list.count - 1 {
                if list[i].goods_id! == cell.CartsListData?.goods_id! {
                    model!.carts_list![i] = cell.CartsListData!
                }
            }
            totalAll()
        }
    }
    
    func numberGoods(cell: ShopcartCell, number: Int, operation: Int) {
        guard number > 0 else {
            //提示错误
            return
        }
        
        let shopOperation = ShopcartOperration(rawValue: operation)
        if shopOperation == ShopcartOperration.plus {
            ProgressHUD.show()
            let delay = DispatchTime.now() + .seconds(1)
            DispatchQueue.main.asyncAfter(deadline: delay) {
                ProgressHUD.dismiss()
                ShopCartData.plusCarts(number: number, completion: { [weak self] in
                    cell.CartsListData!.goods_number = number
                    let list = self!.model!.carts_list!
                    for i in 0...list.count - 1 {
                        if list[i].goods_id! == cell.CartsListData?.goods_id! {
                            self!.model!.carts_list![i] = cell.CartsListData!
                        }
                    }
                    self!.totalAll()
                })
            }
        } else if shopOperation == ShopcartOperration.reduce {
            ProgressHUD.show()
            let delay = DispatchTime.now() + .seconds(1)
            DispatchQueue.main.asyncAfter(deadline: delay) {
                ProgressHUD.dismiss()
                ShopCartData.reduceCarts(number: number, completion: { [weak self] in
                    cell.CartsListData!.goods_number = number
                    let list = self!.model!.carts_list!
                    for i in 0...list.count - 1 {
                        if list[i].goods_id! == cell.CartsListData?.goods_id! {
                            self!.model!.carts_list![i] = cell.CartsListData!
                        }
                    }
                    self!.totalAll()
                })
            }
        }
    }
    
    func removeGoods(_ cell: ShopcartCell) {
        ProgressHUD.show()
        let delay = DispatchTime.now() + .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: delay) {
            ProgressHUD.dismiss()
            ShopCartData.removeCarts { [weak self] in
                let list = self!.model!.carts_list!
                for i in 0...list.count - 1 {
                    if list[i].goods_id! == cell.CartsListData?.goods_id! {
                        self!.model!.carts_list!.remove(at: i)
                    }
                }
                self!.totalAll()
                self!.tableView.reloadData()
            }
        }
    }
    
}

extension ShopcartViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.carts_list?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ShopcartCell
        cell.delegate = self
        cell.CartsListData = model?.carts_list?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
}
