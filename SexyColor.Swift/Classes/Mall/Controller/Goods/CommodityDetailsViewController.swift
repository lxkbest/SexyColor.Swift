//
//  CommodityDetailsViewController.swift
//  SexyColor.Swift
//
//  Created by kayzhang on 2017/8/24.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//商品详情-商品

import UIKit

class CommodityDetailsViewController: BaseViewController {
    
    var httpOver : ((_ isCollection : Int) -> ())?
    
    fileprivate var tableView : UITableView!//私有可变
    
    fileprivate var titleLabel : UILabel!
    fileprivate var viewController : CommodityDetailsDetailsViewController!
    
    weak var delegate : CommodityDetailsViewDelegate?
    
    var model : GoodsDetailsModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        InitUI()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func InitUI () {
        view.backgroundColor = UIColor.white
        setTableView()
        setTetailsTableView()
        loadNewData()
    }
    
    func setTableView() {
        tableView = UITableView(frame: CGRect.zero, style: .plain)
        
        tableView.register(CommodityDetailsNameCell.self, forCellReuseIdentifier: "CommodityDetailsNameCell")
        tableView.register(CommodityDetailsAddressCell.self, forCellReuseIdentifier: "CommodityDetailsAddressCell")
        tableView.register(MemberPromptCell.self, forCellReuseIdentifier: "MemberPromptCell")
        tableView.register(CommodityDetailsCharacteristicCell.self, forCellReuseIdentifier: "CommodityDetailsCharacteristicCell")
        tableView.register(CommodityDetailsDiscountPackageCell.self, forCellReuseIdentifier: "CommodityDetailsDiscountPackageCell")
        tableView.register(CommodityDetailsCommodityEvaluationCell.self, forCellReuseIdentifier: "CommodityDetailsCommodityEvaluationCell")
        tableView.register(CommodityDetailsRecommendCell.self, forCellReuseIdentifier: "CommodityDetailsRecommendCell")
        tableView.register(OpenMoreCell.self, forCellReuseIdentifier: "OpenMoreCell")
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.showsHorizontalScrollIndicator = false
        tableView.backgroundColor = GlobalColor
        tableView.separatorColor = UIColor.colorWithHexString(hex: "FAF0E6")
        tableView.separatorInset = UIEdgeInsetsMake(-ScreenHeight, 0, 0, 0)
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .none

        view.addSubview(tableView)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.frame = CGRect(x: 0, y: 0, width: view.width, height: view.height - NavigationH - 45)
    }
    
    func setTetailsTableView() {
        viewController = CommodityDetailsDetailsViewController()
        self.addChildViewController(viewController)
        viewController.view.frame = CGRect(x: 0, y: view.height, width: view.width, height: view.height)
        
        self.view.addSubview(viewController.view)
        viewController.isRefreshe = true
        viewController.delegate = self
        viewController.didMove(toParentViewController: self)
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
            GoodsDetailsData.loadCommodity(completion: { [weak self] (model) in
                self!.model = model.data
                self!.tableView.reloadData()
                self!.setHeaderWithFooter()
                
                if self?.httpOver != nil {
                    self?.httpOver!((self!.model?.goods_info?.is_collection)!)
                }
            })
        }
    }
    
    func setHeaderWithFooter() {
        
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: Int(ScreenWidth), height: 50))
        
        let _ = UILabel.sexy_create(footerView)
            .sexy_layout { (make) in
                make.centerX.centerY.equalTo(footerView)
            }
            .sexy_config { (label) in
                label.font = UIFont.systemFont(ofSize: 15)
                label.text = "继续拖动，查看图文详情"
                label.textAlignment = .center
        }
        
        tableView.tableFooterView = footerView
        
        let imageView : CycleView  = CycleView(frame: CGRect(x: 0, y: -ScreenWidth, width: ScreenWidth, height: ScreenWidth))
        imageView.delegate = self
        imageView.imageArray = (model?.goods_gallery)!
        imageView.tag = 101
        imageView.clipsToBounds = true
        tableView.addSubview(imageView)
        tableView.contentInset = UIEdgeInsetsMake(ScreenWidth, 0, 0, 0);
        tableView.setContentOffset(CGPoint(x: 0, y: -ScreenWidth), animated: false)
    }
    
    func goToDetailAnimation() {
        UIView.animate(withDuration: AnimationDuration) {
            self.tableView.frame.origin.y = -self.view.frame.size.height
            self.viewController.view.y = 0
        }
    }
    
    func backToFirstPageAnimation() {
        UIView.animate(withDuration: AnimationDuration) {
            self.tableView.frame.origin.y = 0
            self.viewController.view.y = self.view.frame.size.height
        }
    }

}


extension CommodityDetailsViewController : UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        if model?.goods_info == nil {
            return 0
        }
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        else if section == 1 {
            return 3
        }
        else if section == 2 && model?.package_info != nil {
            return 1
        }
        else if section == 3 && model?.comment_list != nil {
            return 3
        }
        else if section == 4 && model?.recommend_goods != nil {
            return 2
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 2 && indexPath.section == 3 {
            if delegate != nil {
                if delegate!.responds(to: #selector(CommodityDetailsViewDelegate.pushCommentView)) {
                    delegate?.pushCommentView()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect.init(x: 0, y: 0, width: ScreenWidth, height: 10));
        view.backgroundColor = UIColor.clear
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 2 && model?.package_info == nil {
            return 0
        }
        else if section == 3 && model?.comment_list == nil {
            return 0
        }
        else if section == 4 {
            return 0
        }
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        if indexPath.section == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "CommodityDetailsNameCell", for: indexPath) as? CommodityDetailsNameCell
            (cell as! CommodityDetailsNameCell).detailsNameData = model?.goods_info
            
        }
        else if indexPath.section == 1 {
            if indexPath.row == 0 {//送货地址
                cell = tableView.dequeueReusableCell(withIdentifier: "CommodityDetailsAddressCell", for: indexPath) as? CommodityDetailsAddressCell
                (cell as! CommodityDetailsAddressCell).detailsAddressData = CommodityDetailsAddressModel(forAddress: "重庆市", toAddress: "北京市朝阳区", time: "09月27日（周日）")
            }
            else if indexPath.row == 1 {//会员优惠提示
                cell = tableView.dequeueReusableCell(withIdentifier: "MemberPromptCell", for: indexPath) as? MemberPromptCell
                
                var titleStr = ""
                if model?.goods_info?.user_reduction != nil {
                    titleStr = (model?.goods_info?.user_reduction)! + "，"
                }
                if model?.goods_info?.user_reduction != nil {
                    titleStr = titleStr + "送" + String(format: "%d", (model?.goods_info?.pay_points)!) + "趣豆"
                }
                if model?.goods_info?.payment_reduction != nil {
                    titleStr = titleStr + "，" + (model?.goods_info?.payment_reduction)!
                }
                
                (cell as! MemberPromptCell).titleStr = titleStr as NSString
            }
            else {//货到付款之类的提示
                cell = tableView.dequeueReusableCell(withIdentifier: "CommodityDetailsCharacteristicCell", for:indexPath) as? CommodityDetailsCharacteristicCell
                (cell as! CommodityDetailsCharacteristicCell).titleArray = ["正品保证", "私密配送", "支持货到付款"]
            }
        }
        else if indexPath.section == 2 {//优惠套餐
            cell = tableView.dequeueReusableCell(withIdentifier: "CommodityDetailsDiscountPackageCell", for: indexPath) as? CommodityDetailsDiscountPackageCell
            (cell as! CommodityDetailsDiscountPackageCell).discountPackageData = model?.package_info
        }
        else if indexPath.section == 3 {//产品评价
            if indexPath.row == 0 {
                cell = tableView.dequeueReusableCell(withIdentifier: "cell")
                cell?.selectionStyle = .none
                cell?.textLabel?.font = UIFont.systemFont(ofSize: 14)
                let str = NSString(format: "商品评价(%d)", (model?.comment_count)!)
                cell?.textLabel?.text = str as String
            }
            else if indexPath.row == 1 {
                cell = tableView.dequeueReusableCell(withIdentifier: "CommodityDetailsCommodityEvaluationCell", for: indexPath) as? CommodityDetailsCommodityEvaluationCell
                (cell as! CommodityDetailsCommodityEvaluationCell).CommodityEvaluationData = model?.comment_list![0]
            }
            else {
                cell = tableView.dequeueReusableCell(withIdentifier: "OpenMoreCell", for: indexPath) as? OpenMoreCell
                (cell as! OpenMoreCell).label.text = "查看全部评价"
                (cell as! OpenMoreCell).label.font = UIFont.systemFont(ofSize: 13)
            }
            
        }
        else if indexPath.section == 4 {
            if indexPath.row == 0 {
                cell = tableView.dequeueReusableCell(withIdentifier: "cell")
                cell?.selectionStyle = .none
                cell?.textLabel?.font = UIFont.systemFont(ofSize: 14)
                cell?.textLabel?.text = "相关推荐"
            }
            else {
                cell = tableView.dequeueReusableCell(withIdentifier: "CommodityDetailsRecommendCell", for: indexPath) as? CommodityDetailsRecommendCell
                (cell as! CommodityDetailsRecommendCell).RecommendGoodsData = model?.recommend_goods
            }
        }
        return cell!
    }
    
}

extension CommodityDetailsViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let point = scrollView.contentOffset
        if point.y < -ScreenWidth {
            let imageView : CycleView = tableView.viewWithTag(101) as! CycleView
            var rect = imageView.frame
            rect.origin.y = point.y
            rect.size.height = -point.y
            imageView.frame = rect
            imageView.changeFrame = rect
        }
        else if point.y == -ScreenWidth {
            let imageView : CycleView = tableView.viewWithTag(101) as! CycleView
            imageView.changeFrame = CGRect.zero
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let valueNum = scrollView.contentSize.height - scrollView.frame.size.height
        if (offsetY - valueNum) > 0 {
            goToDetailAnimation()
            if delegate != nil {
                if delegate!.responds(to: #selector(CommodityDetailsViewDelegate.setTitlteState(isHidden:))) {
                    delegate!.setTitlteState(isHidden: true)
                }
            }
        }
    }
}

extension CommodityDetailsViewController : CycleViewDelegate {
    func show(index: Int) {
        let photoBrowser = PhotoBrowser()
        let images = model?.goods_gallery
        photoBrowser.images = images! as NSArray
        photoBrowser.currentIndex = index
        photoBrowser.show()
    }
}

extension CommodityDetailsViewController : CommodityDetailsDelegate {
    func backToFirstPage() {
        backToFirstPageAnimation()
        if delegate != nil {
            if delegate!.responds(to: #selector(CommodityDetailsViewDelegate.setTitlteState(isHidden:))) {
                delegate!.setTitlteState(isHidden: false)
            }
        }
    }
}

@objc
protocol CommodityDetailsViewDelegate : NSObjectProtocol {
    func setTitlteState(isHidden : Bool)
    func pushCommentView()
}




