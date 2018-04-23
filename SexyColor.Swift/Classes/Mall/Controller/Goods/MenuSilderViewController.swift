//
//  MenuSilderViewController.swift
//  SexyColor.Swift
//
//  Created by kayzhang on 2017/8/29.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//商品详情

import UIKit

class MenuSilderViewController: BaseViewController {

    fileprivate let muneHeight = 45
    
    var contentArray : NSArray! = [CommodityDetailsViewController(), CommodityDetailsDetailsViewController(), CommodityDetailsCommentViewController()]
    var titleViews : UIView!
    var menu : UIView!//菜单
    var titleLabel : UILabel!
    var contentScrollView : UIScrollView!//视图
    var payModel: GoodsAttrModel?
    
    var GoodsId : String? {
        didSet {
            setNavTitleView()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        var occlusionView = self.navigationController?.view.viewWithTag(1008)
        occlusionView?.removeFromSuperview()
        occlusionView = self.navigationController?.view.viewWithTag(1009)
        occlusionView?.removeFromSuperview()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNav()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setNav() {
        let moreBtn = UIButton(frame: CGRect.init(x: 0, y: 0, width: 44, height: 44))
        var image = UIImage(named:"more_setup")?.withRenderingMode(.alwaysOriginal)
        moreBtn.setImage(image, for: .normal)
        moreBtn.addTarget(self, action:#selector(more), for:.touchUpInside)
        let moreItem = UIBarButtonItem(customView: moreBtn)
        
        let cartBtn = UIButton(frame: CGRect.init(x: 0, y: 0, width: 44, height: 44))
        image = UIImage(named:"Nav_car")?.withRenderingMode(.alwaysOriginal)
        cartBtn.setImage(image, for: .normal)
        cartBtn.addTarget(self, action:#selector(cart), for:.touchUpInside)
        cartBtn.showRedWithValue(offsetX: 5, offsetY: 0.25, number: "3")
        let cartItem = UIBarButtonItem(customView: cartBtn)
        
        //按钮间的空隙
        let gap = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil,
                                  action: nil)
        gap.width = 0
        
        //用于消除右边边空隙，要不然按钮顶不到最边上
        let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil,
                                     action: nil)
        spacer.width = -20
        
        self.navigationItem.rightBarButtonItems = [spacer, moreItem, gap, cartItem]
        
        let btn = UIButton(frame: CGRect.init(x: 0, y: 0, width: 44, height: 44))
        image = UIImage(named:"")?.withRenderingMode(.alwaysOriginal)
        btn.setImage(image, for: .normal)
        let item = UIBarButtonItem(customView: btn)
        
        self.navigationItem.leftBarButtonItems = [gap, item]
        
        view.backgroundColor = GlobalColor
    }

    func setNavTitleView() {
        titleViews = UIView.init(frame: CGRect.init(x: 0, y: 0, width: ScreenWidth, height: 44))
        titleViews.layer.masksToBounds = true
        
        //添加上边的几个按钮
        menu = MenuSliderView.sexy_create(titleViews)
            .sexy_layout({ (make) in
                make.top.left.right.bottom.equalTo(titleViews)
            })
        (menu as! MenuSliderView).delegate = self
        
        titleLabel = UILabel.sexy_create(titleViews)
            .sexy_layout({ (make) in
                make.top.equalTo(menu.snp.bottom)
                make.left.right.equalTo(titleViews)
                make.height.equalTo(menu)
            })
            .sexy_config({ (label) in
                label.text = "商品详情"
                label.textAlignment = .center
            })
        
        self.navigationItem.titleView = titleViews
        
        contentScrollView = UIScrollView.sexy_create(view)
            .sexy_layout({ (make) in
                make.top.left.right.equalTo(view)
                make.bottom.equalTo(view).offset(-muneHeight)
            })
            .sexy_config({ (scrollView) in
                scrollView.backgroundColor = UIColor.white
                scrollView.contentSize = CGSize(width: NSInteger(self.view.frame.size.width) * 3, height: 0)
                scrollView.isPagingEnabled = true
                scrollView.delegate = self
                scrollView.showsHorizontalScrollIndicator = true
                
                let screenEdgeGesOut = UIScreenEdgePanGestureRecognizer(target: self, action: nil)
                screenEdgeGesOut.edges = .left
                screenEdgeGesOut.delegate = self
                scrollView.addGestureRecognizer(screenEdgeGesOut)
            })
        
        scrollViewDidEndDecelerating(contentScrollView)
    }
    
    func more() {
        let showView = MoreMuneView()
        showView.moreChoice = { [weak self] (row) in
            switch row {
            case 0:
                self?.navigationController?.popToRootViewController(animated: true)
                break
            case 1:
                self?.navigationController?.pushViewController(GoodsListController(), animated: true)
                break
            case 2:
                print("在线客服")
                break
            case 3:
                print("浏览历史")
                break
            default:
                break
            }
        }
        
        showView.remove = { [weak self]  in
            self?.removeocclusionView(tag : 1008)
        }
        
        showView.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: view.height)
        showView.tag = 998
        showView.showMenu(view: (self.view)!)
        addHideenView(tag: showView.tag)
    }

    func cart() {
        self.navigationController?.pushViewController(ShopcartViewController(), animated: true)
    }

    func setMenu(isCollection : Int) {
        let payMenu = UIView
            .sexy_create(view)
            .sexy_layout { (make) in
                make.bottom.left.right.equalTo(view)
                make.height.equalTo(muneHeight)
        }
        .sexy_config { (view) in
            view.backgroundColor = UIColor.white
        }
        
        let _ = UIView.sexy_create(payMenu)
            .sexy_layout { (make) in
                make.top.left.right.equalTo(payMenu)
                make.height.equalTo(1)
            }
            .sexy_config { (view) in
                view.backgroundColor = AthensGrayColor
        }
        
        let serviceBtn = UIButton.sexy_create(payMenu)//客服
            .sexy_layout { (make) in
                make.top.bottom.left.equalTo(payMenu)
                make.width.equalTo(payMenu).multipliedBy(0.15)
            }
            .sexy_config { (btn) in
                btn.setTitle("客服", for: .normal)
                btn.titleLabel?.font = UIFont.systemFont(ofSize: 10)
                btn.setTitleColor(UIColor.lightGray, for: .normal)
                btn.setImage(UIImage.init(named: "goods_ikefu"), for: .normal)
                btn.addTarget(self, action: #selector(service), for: .touchUpInside)
        }
        setButton(btn: serviceBtn)
        
        let _ = UIView.sexy_create(payMenu)
            .sexy_layout { (make) in
                make.top.bottom.equalTo(payMenu)
                make.width.equalTo(1)
                make.left.equalTo(serviceBtn.snp.right)
            }
            .sexy_config { (view) in
                view.backgroundColor = AthensGrayColor
        }
        
        let collectionBtn = UIButton.sexy_create(payMenu)//收藏
            .sexy_layout { (make) in
                make.left.equalTo(serviceBtn.snp.right)
                make.top.bottom.equalTo(payMenu)
                make.width.equalTo(serviceBtn)
            }
            .sexy_config { (btn) in
                btn.setTitle("收藏", for: .normal)
                btn.titleLabel?.font = UIFont.systemFont(ofSize: 10)
                btn.setTitleColor(UIColor.lightGray, for: .normal)
                btn.addTarget(self, action: #selector(collection(btn:)), for: .touchUpInside)
                btn.setImage(UIImage.init(named: "Goods_addfav_on"), for: .selected)
                btn.setImage(UIImage.init(named: "goods_ifav"), for: .normal)
                btn.isSelected = isCollection == 1 ? true : false
        }
        setButton(btn: collectionBtn)
        
        let cartBtn = UIButton.sexy_create(payMenu)//加入购物车
            .sexy_layout { (make) in
                make.top.bottom.equalTo(payMenu)
                make.left.equalTo(collectionBtn.snp.right)
                make.width.equalTo(payMenu).multipliedBy(0.35)
            }
            .sexy_config { (btn) in
                btn.setTitle("加入购物车", for: .normal)
                btn.backgroundColor = UIColor.orange
                btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
                btn.tag = 1
                btn.addTarget(self, action: #selector(showChoice(btn:)), for: .touchUpInside)
        }
        
        let _ = UIButton.sexy_create(payMenu)//立即购买
            .sexy_layout { (make) in
                make.top.right.bottom.equalTo(payMenu)
                make.left.equalTo(cartBtn.snp.right)
            }
            .sexy_config { (btn) in
                btn.addTarget(self, action: #selector(showChoice(btn:)), for: .touchUpInside)
                btn.setTitle("立即购买", for: .normal)
                btn.backgroundColor = UIColor.red
                btn.tag = 2
                btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        }
    }
    
    func service() {
        
    }
    
    func collection(btn : UIButton) {
        ProgressHUD.show()
        if AppDelegate.netWorkState == .notReachable {
            if btn.isSelected {
                ProgressHUD.showWithStatus("取消收藏失败", isShow: false)
            }
            else {
                ProgressHUD.showWithStatus("收藏失败", isShow: false)
            }
            ProgressHUD.dismiss()
            return
        }
        
        let delay = DispatchTime.now() + .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: delay) {
            if btn.isSelected {
                ProgressHUD.showWithStatus("取消收藏成功", isShow: false)
            }
            else {
                ProgressHUD.showWithStatus("收藏成功", isShow: false)
            }
            ProgressHUD.dismiss()
            btn.isSelected = !btn.isSelected
        }
    }
    
    func textSize(text : String , font : UIFont , maxSize : CGSize) -> CGSize{
        return text.boundingRect(with: maxSize, options: [.usesLineFragmentOrigin], attributes: [NSFontAttributeName : font], context: nil).size
    }
    
    func setButton(btn : UIButton) {
        let spacing = 2
        let imageSize : CGSize = (btn.imageView?.frame.size)!
        var titleSize : CGSize = (btn.titleLabel?.frame.size)!
        let textMaxSize : CGSize = CGSize(width: 240, height: CGFloat(MAXFLOAT))
        let textSize : CGSize = self.textSize(text:(btn.titleLabel?.text)! , font: (btn.titleLabel?.font)!, maxSize: textMaxSize)
        let frameSize : CGSize = CGSize.init(width: Int(ceilf(Float(textSize.width))), height: Int(ceilf(Float(textSize.height))))
        
        if titleSize.width + 0.5 < frameSize.width {
            titleSize.width = frameSize.width
        }
        let totalHeight = imageSize.height + titleSize.height + CGFloat(spacing)
        
        btn.imageEdgeInsets = UIEdgeInsetsMake(-(totalHeight - imageSize.height), CGFloat(spacing), CGFloat(spacing), -titleSize.width)
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, -imageSize.width, -(totalHeight - titleSize.height), 0);
    }
    
    func showChoice(btn : UIButton) {
        
        if payModel == nil {
            ProgressHUD.show()
            if AppDelegate.netWorkState == .notReachable {
                ProgressHUD.dismiss()
                return
            }
            let delay = DispatchTime.now() + .seconds(1)
            DispatchQueue.main.asyncAfter(deadline: delay) {
                ProgressHUD.dismiss()
                GoodsAttrData.loadCommodity(completion: { [weak self] (model) in
                    self?.payModel = model.data
                    self?.pushChoice(data: model.data!, tag : btn.tag)
                })
            }
        }
        else {
            pushChoice(data: payModel!, tag : btn.tag)
        }
        
    }
    
    func pushChoice(data : GoodsAttrModel, tag : Int) {
        let showView = payMenuView()
        showView.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: view.height)
        showView.choiceData = data.standard?.standard_list
        showView.delegate = self
        showView.tag = 999
        showView.showMenu(view: (self.view)!, tag : tag)
        addHideenView(tag: showView.tag)
    }
    
    func addHideenView(tag : Int) {
        let occlusionView = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: NavigationH))
        occlusionView.tag = tag + 10
        self.navigationController?.view.addSubview(occlusionView)
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideenChice(gestureRecognizer:)))
        occlusionView.addGestureRecognizer(tap)
    }
    
    func hideenChice(gestureRecognizer : UITapGestureRecognizer) {
        let occlusionView = gestureRecognizer.view
        switch occlusionView!.tag - 10 {
        case 998:
            let showView : MoreMuneView = self.view.viewWithTag(occlusionView!.tag - 10) as! MoreMuneView
            showView.hideenChice()
            break
        case 999:
            let showView : payMenuView = self.view.viewWithTag(occlusionView!.tag - 10) as! payMenuView
            showView.hideenChice()
            break
        default:
            break
        }
        
    }
}


extension MenuSilderViewController : MenuSliderViewDelegate {
    
    func touchMenu (tag: NSInteger) {//菜单点击
        
        contentScrollView.setContentOffset(CGPoint.init(x: NSInteger(self.view.frame.size.width) * tag, y: 0), animated: true)
        
        let viewController = contentArray[tag]
        
        if ((viewController as! UIViewController).parent != self) {
            
            self.addChildViewController(viewController as! UIViewController)
            
            if (viewController is CommodityDetailsViewController) {
                
                (viewController as! CommodityDetailsViewController).delegate = self
                (viewController as! CommodityDetailsViewController).httpOver =
                    { [weak self] (isCollection) in
                        self?.setMenu(isCollection : isCollection)
                }
            }
            (viewController as! UIViewController).view.x = CGFloat(NSInteger(self.view.frame.size.width) * tag)
            contentScrollView.addSubview((viewController as! UIViewController).view)
            (viewController as! UIViewController).didMove(toParentViewController: self)

        }
    }
}

extension MenuSilderViewController : UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if (gestureRecognizer is UIPanGestureRecognizer) && (otherGestureRecognizer is UIScreenEdgePanGestureRecognizer) && (contentScrollView.contentOffset.x < 30) {
            return true;
        }
        else {
            return  false;
        }
    }
}

extension MenuSilderViewController : CommodityDetailsViewDelegate {
    func setTitlteState(isHidden: Bool) {
        if isHidden {
            self.contentScrollView.isScrollEnabled = false
            UIView.animate(withDuration: AnimationDuration) {
                
                self.menu.snp.remakeConstraints({ (make) in
                    make.top.equalTo(self.titleViews).offset(-NavigationH)
                    make.left.right.equalTo(self.titleViews)
                    make.bottom.equalTo(self.titleViews.snp.top)
                })
                self.titleLabel.snp.remakeConstraints({ (make) in
                    make.top.left.right.bottom.equalTo(self.titleViews)
                })
                self.titleViews.layoutIfNeeded()
            }

        }
        else {
            self.contentScrollView.isScrollEnabled = true
            UIView.animate(withDuration: AnimationDuration) {
                self.menu.snp.remakeConstraints({ (make) in
                    make.top.left.right.bottom.equalTo(self.titleViews)
                })
                self.titleLabel.snp.remakeConstraints({ (make) in
                    make.top.equalTo(self.titleViews.snp.bottom)
                    make.left.right.height.equalTo(self.titleViews)
                })
                self.titleViews.layoutIfNeeded()
            }

        }
    }
    
    func pushCommentView() {
        let actionTag = menu.viewWithTag(102)
        (menu as! MenuSliderView) .changeOfPage(sender: actionTag as! UIButton)
    }
    
    func removeocclusionView(tag : Int) {
        let occlusionView = self.navigationController?.view.viewWithTag(tag)
        occlusionView?.removeFromSuperview()
    }
}

extension MenuSilderViewController : UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {//滚动中
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {//滚动停止
        let offsetX = scrollView.contentOffset.x / view.frame.size.width
        let actionTag = menu.viewWithTag(Int(offsetX) + 100)
        (menu as! MenuSliderView) .changeOfPage(sender: actionTag as! UIButton)
    }
}

extension MenuSilderViewController : PayMenuDelegate {
    func remove() {
        removeocclusionView(tag : 1009)
    }
    
    func pay(tag : Int, chioce : Int) {
        let data = payModel?.standard?.standard_list?[chioce]
//        print("加入购物车数据")
        switch tag {
        case 1:
            let imageView = AnimationImage(frame: CGRect(x: ScreenWidth / 2, y: ScreenHeight - NavigationH - TabbarH, width: 25, height: 25))
            let url = URL(string: (data?.attr_pic)!)!
            imageView.kf.setImage(with: url,
                                  placeholder: UIImage(named: "loadingbkg"),
                                  options: [.transition(.fade(1))],
                                  progressBlock: nil,
                                  completionHandler: nil)
            view.addSubview(imageView)
            break
        case 2:
            self.navigationController?.pushViewController(ShopcartViewController(), animated: true)
            break
        default:
            break
        }
    }
}
