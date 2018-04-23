//
//  CommodityDetailsDetailsViewController.swift
//  SexyColor.Swift
//
//  Created by kayzhang on 2017/8/31.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//商品详情-详情

import UIKit
import MJRefresh
import Kingfisher
import KingfisherWebP

class CommodityDetailsDetailsViewController: BaseViewController {

    fileprivate var model : GoodsDetailsImageModel?
    fileprivate var attrModel : GoodsAttrModel?
    var tableView : UITableView!
    fileprivate var open : Bool! = false
    weak var delegate : CommodityDetailsDelegate?
    
    var isRefreshe : Bool! = false {
        didSet {
            let header = MJRefreshDIYHeader()
            header.setRefreshingTarget(self, refreshingAction: #selector(headerRefresh))
            header.setTitle("下拉，返回宝贝详情", for: .idle)
            header.setTitle("释放，返回宝贝详情", for: .pulling)
            header.setTitle("释放，返回宝贝详情", for: .refreshing)
            tableView.mj_header = header
        }
    }
    
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
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = GlobalColor
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        
        tableView.register(OpenMoreCell.self, forCellReuseIdentifier: "OpenMoreCell")
        
        tableView.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight - NavigationH - 45)
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
            GoodsDetailsImageData.loadCommodity(completion: { [weak self] (model) in
                self!.model = model.data
                self?.tableView.reloadData()
            })
            GoodsAttrData.loadCommodity(completion: { [weak self] (model) in
                self?.attrModel = model.data
                self?.tableView.reloadData()
            })
        }
    }
    func headerRefresh() {
        if delegate != nil {
            if delegate!.responds(to: #selector(CommodityDetailsDelegate.backToFirstPage)) {
                delegate?.backToFirstPage()
            }
        }
        tableView.mj_header.endRefreshing()
    }
}

extension CommodityDetailsDetailsViewController : UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if attrModel != nil && section == 0 {
            if (attrModel?.parameter?.count)! > 4  && !open {
                return 5
            }
            else {
                return (attrModel?.parameter?.count)!
            }
        }
        if model != nil && section == 1 {
            return (model?.url_list?.count)!
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        
        if indexPath.section == 0 {
            
            if indexPath.row == 4 && !open {//点击展开cell
                cell = tableView.dequeueReusableCell(withIdentifier: "OpenMoreCell", for: indexPath) as? OpenMoreCell
                (cell as! OpenMoreCell).label.text = "点击查看给多参数"
            }
            else {
                
                cell = tableView.dequeueReusableCell(withIdentifier: "arrtCell")
                if cell == nil {
                    cell = UITableViewCell(style: .default, reuseIdentifier: "arrtCell")
                    cell?.selectionStyle = .none
                }
                
                let attriMuStr = NSMutableAttributedString(string: (attrModel?.parameter?[indexPath.row].attr_name)!, attributes: [NSForegroundColorAttributeName : UIColor.lightGray])
                let attriStr = NSAttributedString(string: NSString(format: "  %@", (attrModel?.parameter?[indexPath.row].attr_value)!) as String)
                attriMuStr.append(attriStr)
                
                cell?.textLabel?.attributedText = attriMuStr
                cell?.textLabel?.font = UIFont.systemFont(ofSize: 13)
            }
        }
        else {
            cell = tableView.dequeueReusableCell(withIdentifier: "imageCell")
            if cell == nil {
                cell = UITableViewCell(style: .default, reuseIdentifier: "imageCell")
                cell?.selectionStyle = .none
                let _ = UIImageView.sexy_create(cell!)
                    .sexy_layout { (make) in
                        make.top.left.bottom.equalTo(cell!)
                        make.width.equalTo(ScreenWidth)
                    }
                    .sexy_config { (imageView) in
                        imageView.contentMode = .scaleAspectFill
                        imageView.tag = 1
                }
            }
            
            let url = URL(string: (model?.url_list![indexPath.row].img_url)!)
            
            let imageView : UIImageView = cell?.viewWithTag(1) as! UIImageView
            imageView.kf.setImage(with: url,
                                  placeholder: UIImage(named: "loadingbkg"),
                                  options: [.processor(WebPProcessor.default),
                                            .cacheSerializer(WebPSerializer.default)])
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 35
        }
        else {
            let height = model?.url_list![indexPath.row].img_height
            let with = model?.url_list![indexPath.row].img_with
            var cellHeight = CGFloat(height!) * ScreenWidth / CGFloat(with!)
            cellHeight = round(cellHeight)
            return cellHeight
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 4 && !open {
            open = true
            let indexSet = NSIndexSet(index: 0)
            tableView.reloadSections(indexSet as IndexSet, with: .none)
        }
    }
}

@objc
protocol CommodityDetailsDelegate : NSObjectProtocol {
    func backToFirstPage()
}
