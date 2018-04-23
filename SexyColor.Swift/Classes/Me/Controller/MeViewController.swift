//
//  MeViewController.swift
//  SexyColor.Swift
//
//  Created by xiongkai on 2017/8/4.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//

import UIKit
import SnapKit

let MeHeadCellId:String = "MeHeadCellId"
let MeCommonCellId:String = "MeCommonCellId"

class MeViewController: BaseViewController {

    fileprivate var tableView : UITableView!
    
    fileprivate let commonMenus1 = [0:(title: "优惠券",imageName: "User_youhuiquan"), 1:(title: "账户管理",imageName: "User_zhanghu"), 2:(title: "VIP客服",imageName: "User_kefus")]
    
    fileprivate let commonMenus2 = [0:(title: "隐私保护",imageName: "User_lock"), 1:(title: "3G/4G下显示高清大图",imageName: "User_4G"), 2:(title: "清除缓存",imageName: "User_clears")]
    
    fileprivate let commonMenus3 = [0:(title: "应用推荐",imageName: "User_apptuijian"), 1:(title: "其他",imageName: "User_other")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        InitUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    

    
    override func viewWillDisappear(_ animated: Bool) {
        let viewControllers = self.navigationController?.viewControllers
        if viewControllers != nil {
            if viewControllers!.count > 1 && viewControllers![viewControllers!.count - 2] is MeViewController {
                navigationController?.setNavigationBarHidden(false, animated: animated)
            }
        }
        
        super.viewWillDisappear(animated)
    }
    

    func InitUI() {
        tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.showsVerticalScrollIndicator = true
        tableView.showsHorizontalScrollIndicator = true
        tableView.backgroundColor = GlobalColor
        tableView.separatorColor = UIColor.colorWithHexString(hex: "FAF0E6")
        tableView.tableFooterView = UIView()
        
        let frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight)
        let backgroundView = UIView(frame: frame)
        backgroundView.backgroundColor = UIColor.white
        tableView.tableHeaderView = backgroundView
        tableView.contentInset = UIEdgeInsetsMake(-ScreenHeight, 0, 0, 0)
        
        
        view.addSubview(tableView)
        
        tableView.register(MeHeadCell.self, forCellReuseIdentifier: MeHeadCellId)
        tableView.register(MeCommonCell.self, forCellReuseIdentifier: MeCommonCellId)
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(view)
            make.leading.equalTo(view)
            make.trailing.equalTo(view)
            make.bottom.equalTo(view)
        }
        
       
        tableView.addSubview(backgroundView)
    }
    
    func clearCache(_ cell: MeCommonCell) {
        let alertVc =  UIAlertController(title: "提示", message: "是否清除缓存？", preferredStyle: .alert)
        let actionCancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let actionOK = UIAlertAction(title: "确认", style: .default) { (alert) in
            FileManage.cleanFolder(CachePath) {() -> () in
                let time = DispatchTime.now() + Double(Int64(1.0 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
                DispatchQueue.main.asyncAfter(deadline: time, execute: {
                    cell.smallText.text = "0.00M"
                })
                
            }
        }
        alertVc.addAction(actionCancel)
        alertVc.addAction(actionOK)
        self.present(alertVc, animated: true, completion: nil)
    }
}

extension MeViewController : MeHotMenuDelegate {
    
    func hotMenuClick(index: Int) {
        switch index {
            case 0:
                print("第一个")
            case 1:
                print("第二个")
            case 2:
                print("第三个")
            case 3:
                let vc = OrderListViewController()
                navigationController?.pushViewController(vc, animated: true)
            default:
                break
        }
    }
}

extension MeViewController : PrivacyDelegate {
    func isOpenPrivacy(isOpen: Bool, indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! MeCommonCell
        if isOpen {
            cell.customState = true
        } else {
            cell.customState = false
        }
        
    }
}



extension MeViewController : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return commonMenus1.count
        } else if section == 2 {
            return commonMenus2.count
        } else if section == 3 {
            return commonMenus3.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        if indexPath.section == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: MeHeadCellId, for: indexPath) as? MeHeadCell
            cell?.selectionStyle = .none
            (cell as! MeHeadCell).delegate = self
            (cell as! MeHeadCell).headrData = MeHeadModel(img: "http://i2.fuimg.com/605441/850d3007bf20edc8.jpg", name: "薛凯凯圆滚滚", level: 1, isLoginState: false, isSignState: false)
        } else if indexPath.section == 1 {
            cell = tableView.dequeueReusableCell(withIdentifier: MeCommonCellId, for: indexPath)
            cell?.imageView?.image = UIImage(named: (commonMenus1[indexPath.row]?.imageName)!)
            cell?.textLabel?.text = commonMenus1[indexPath.row]?.title
            cell?.textLabel?.font = UIFont.systemFont(ofSize: 15)
            (cell as! MeCommonCell).smallText.text = "80趣豆"
            
        } else if indexPath.section == 2 {
            cell = tableView.dequeueReusableCell(withIdentifier: MeCommonCellId, for: indexPath)
            cell?.imageView?.image = UIImage(named: (commonMenus2[indexPath.row]?.imageName)!)
            cell?.textLabel?.text = commonMenus2[indexPath.row]?.title
            cell?.textLabel?.font = UIFont.systemFont(ofSize: 15)
            if indexPath.row != 2 {
                (cell as! MeCommonCell).smallText.text = "已关闭"
            } else {
                (cell as! MeCommonCell).smallText.text = String().appendingFormat("%.2fM", FileManage.folderSize(CachePath)).cleanDecimalPointZear()
            }
            
        } else if indexPath.section == 3 {
            cell = tableView.dequeueReusableCell(withIdentifier: MeCommonCellId, for: indexPath)
            cell?.imageView?.image = UIImage(named: (commonMenus3[indexPath.row]?.imageName)!)
            cell?.textLabel?.text = commonMenus3[indexPath.row]?.title
            cell?.textLabel?.font = UIFont.systemFont(ofSize: 15)

        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 260
        } else {
            return 44
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = GlobalColor
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 2 {
            let tupleMenus = commonMenus2[indexPath.row]
            let cell = tableView.cellForRow(at: indexPath) as! MeCommonCell
            switch tupleMenus!.title {
            case "隐私保护":
                let vc = PrivacyViewController()
                vc.indexPath = indexPath
                vc.delegate = self
                navigationController?.pushViewController(vc, animated: true)
                break
            case "3G/4G下显示高清大图":
                cell.customState = !(cell.customState)
            default: //清除缓存
                clearCache(cell)
            }
        }
        
    }
    
}
