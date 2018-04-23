//
//  GoodsListController.swift
//  SexyColor.Swift
//
//  Created by kayzhang on 2017/9/11.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//

import UIKit
import MJRefresh

class GoodsListController: BaseViewController {

    var titleField : UITextField!
    fileprivate var changeBtn : UIButton!
    fileprivate var tagChoiceData : Array<Int>! = [-1, -1, -1]
    var attributeView : GoodsChioceAttributeView!
    var collectionView : UICollectionView!
    var model : GoodsListModel?
    
    override func viewWillDisappear(_ animated: Bool) {
        let occlusionView = self.navigationController?.view.viewWithTag(1000)
        occlusionView?.removeFromSuperview()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNav()
        setSubViews()
        loadNewData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    MARK : - 自定义私有方法
    func setNav() {
        let titleViews = UIView.init(frame: CGRect.init(x: 0, y: 0, width: ScreenWidth, height: 30))
        titleField = UITextField.sexy_create(titleViews)
        .sexy_layout { (make) in
            make.top.left.right.bottom.equalTo(titleViews)
        }
        .sexy_config { (textField) in
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
            imageView.contentMode = .scaleAspectFit
            imageView.image = UIImage(named: "list_topSearch")
            
            textField.leftView = imageView
            textField.leftViewMode = .always
            textField.delegate = self
            textField.isEnabled = false
            textField.borderStyle = .roundedRect
        }
        self.navigationItem.titleView = titleViews
        
        changeBtn = UIButton(frame: CGRect.init(x: 0, y: 0, width: 44, height: 44))
        let image = UIImage(named:"list_ModeBig")?.withRenderingMode(.alwaysOriginal)
        changeBtn.setImage(image, for: .normal)
        changeBtn.addTarget(self, action:#selector(change(btn:)), for:.touchUpInside)
        let changeItem = UIBarButtonItem(customView: changeBtn)
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil,
                                     action: nil)
        spacer.width = -20
        
        self.navigationItem.rightBarButtonItems = [spacer, changeItem]
    }
    
    func setSubViews() {
        
        let choiceView = GoodsListChoiceView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 44))
        choiceView.delegate = self
        view.addSubview(choiceView)
        
        attributeView = GoodsChioceAttributeView(frame: CGRect(x: 0, y: 44, width: ScreenWidth, height: 0))
        attributeView.delegate = self
        view.addSubview(attributeView)
        
        
        let layout = UICollectionViewFlowLayout()
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 44, width: ScreenWidth, height: view.height - NavigationH - 44), collectionViewLayout: layout)
        collectionView.backgroundColor = GlobalColor
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        
        collectionView.register(GoodsListCollectionViewCell.self, forCellWithReuseIdentifier: "GoodsListCollectionViewCell")
        collectionView.register(GoodsGridCollectionViewCell.self, forCellWithReuseIdentifier: "GoodsGridCollectionViewCell")
        
        collectionView.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(footerRefresh))
        collectionView.mj_footer.isHidden = true
        
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
            GoodsListData.loadCommodity(completion: { [weak self] (model) in
                self!.model = model.data
                self?.collectionView.reloadData()
                self?.collectionView.mj_footer.isHidden = false
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
            GoodsListData.loadCommodity(completion: { [weak self] (model) in
                for item in model.data!.goods_list! {
                    self!.model?.goods_list?.append(item)
                }
                self?.collectionView.reloadData()
                self?.collectionView.mj_footer.endRefreshing()
            })
        }
    }
    
//    MARK : - 按钮点击处理
    func change(btn : UIButton) {
        btn.isSelected = !btn.isSelected
        
        var image : UIImage!
        if btn.isSelected {
            image =  UIImage(named:"list_ModeList")?.withRenderingMode(.alwaysOriginal)
        }
        else {
            image =  UIImage(named:"list_ModeBig")?.withRenderingMode(.alwaysOriginal)
        }
        
        changeBtn.setImage(image, for: .normal)
        
        collectionView.reloadData()
    }
    
    func hideenChice() {
        let showView : GoodsListChoiceMenuView = self.view.viewWithTag(999) as! GoodsListChoiceMenuView
        showView.hideenChice()
    }
}
// MARK: - 代理
extension GoodsListController : UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == titleField {
//            MARK : - 界面跳转处理
            print("跳转搜索界面")
            return false
        }
        return true
    }
}

extension GoodsListController : UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if model != nil {
            return (model?.goods_list?.count)!
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell : UICollectionViewCell?
        
        if changeBtn.isSelected {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GoodsGridCollectionViewCell", for: indexPath) as? GoodsGridCollectionViewCell
            (cell as! GoodsGridCollectionViewCell).GoodsGridCellData = model?.goods_list?[indexPath.row]
        }
        else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GoodsListCollectionViewCell", for: indexPath) as? GoodsListCollectionViewCell
            (cell as! GoodsListCollectionViewCell).GoodsListCellData = model?.goods_list?[indexPath.row]
        }
        
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let secondView = MenuSilderViewController()
        (secondView as MenuSilderViewController).GoodsId = "123"
        self.navigationController?.pushViewController(secondView, animated: true)
    }
}

extension GoodsListController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if changeBtn.isSelected {
            return CGSize(width: ScreenWidth / 2 - 3, height: (ScreenWidth / 2 - 3) * 1.5)
        }
        else {
            return CGSize(width: ScreenWidth, height: 120)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if changeBtn.isSelected {
            return 5
        }
        else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if changeBtn.isSelected {
            return 5
        }
        else {
            return 0
        }
    }
}

extension GoodsListController : GoodsListChoiceDelegate {
    func show() {
        let showView = GoodsListChoiceMenuView()
        showView.tagChoiceData = tagChoiceData
        showView.delegate = self
        showView.frame = CGRect(x: 0, y: 44, width: ScreenWidth, height: view.height - 44)
        showView.layer.masksToBounds = true
        showView.GoodsListChoiceMenuData = model?.screening
        showView.tag = 999
        showView.showMenu(view: (self.view)!)
        
        let occlusionView = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: NavigationH + 44))
        occlusionView.tag = 1000
        self.navigationController?.view.addSubview(occlusionView)
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideenChice))
        occlusionView.addGestureRecognizer(tap)
    }
}

extension GoodsListController : GoodsChioceAttributeDelegate {
    func removeAll() {
        tagChoiceData = [-1, -1, -1]
    }

    func remove(tag: Int, index: Int) {
        tagChoiceData[index] = -1
    }

    func changeHeight(height: CGFloat) {
        attributeView.height = height
        collectionView.y = attributeView.frame.maxY
        collectionView.height = view.height - 44 - height
    }
    
}

extension GoodsListController : GoodsListChoiceMenuDelegate {
    func choice(data: Array<Int>) {
        tagChoiceData = data
        let strArray : NSMutableArray = []
        if data[0] != -1 {
            let name = model?.screening?.brands?[data[0]].brand_name
            let data = GoodsChioceAttributeArray(name: name!, index: 0)
            strArray.add(data)
        }
        if data[1] != -1 {
            let name = model?.screening?.characteristic?[data[1]].name
            let data = GoodsChioceAttributeArray(name: name!, index: 1)
            strArray.add(data)
        }
        if data[2] != -1 {
            let name = model?.screening?.price_grade?[data[2]].price_range
            let data = GoodsChioceAttributeArray(name: name!, index: 2)
            strArray.add(data)
        }
        attributeView.data = strArray as? [GoodsChioceAttributeArray]
    }
    
    func hidden() {
        let occlusionView = self.navigationController?.view.viewWithTag(1000)
        occlusionView?.removeFromSuperview()
    }
}
