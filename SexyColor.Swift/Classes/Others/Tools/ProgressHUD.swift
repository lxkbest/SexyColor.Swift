//
//  ProgressHUD.swift
//  SexyColor.Swift
//
//  Created by xiongkai on 2017/8/22.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//

import UIKit


class ProgressHUD: UIView {
    
    fileprivate lazy var indicatorView:UIActivityIndicatorView = {
        $0.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        $0.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        return $0
    }(UIActivityIndicatorView())
    
    fileprivate lazy var hudView:UIView = {
        $0.backgroundColor = UIColor.black
        $0.alpha = 0.5
        $0.layer.cornerRadius = CornerRadius
        $0.layer.masksToBounds = true
        return $0
    }(UIView())
    
    fileprivate var statusLabel:UILabel = {
        $0.frame = CGRect(x: 0, y: 0, width: 50, height: 15)
        $0.font = UIFont.systemFont(ofSize: 13)
        $0.textColor = UIColor.white
        return $0
    }(UILabel())
    
    fileprivate lazy var overlayView:UIView = {
        $0.width = ScreenWidth
        $0.height = ScreenHeight
        $0.alpha = 0.5
        return $0
    }(UIView())
    
    
    fileprivate static let instance = ProgressHUD()
    static var sharedInstance : ProgressHUD {
        return instance
    }
    
    class func show() {
        sharedInstance.showWithStatus(nil)
    }
    
    class func dismiss() {
        sharedInstance.dismissView()
    }
    class func showWithStatus(_ status: String?) {
        sharedInstance.showWithStatus(status)
    }
    
    class func showWithStatus(_ status: String?, isShow: Bool) {
        sharedInstance.showWithStatus(status, isShow: isShow)
    }
    
    
    fileprivate func dismissView() {
        OperationQueue.main.addOperation { [weak self] in
            self!.indicatorView.stopAnimating()
            UIView.animate(withDuration: AnimationDuration, animations: {
                self!.overlayView.alpha = 0
            }, completion: { (_) in
                self!.overlayView.removeFromSuperview()
                self!.hudView.removeFromSuperview()
                self!.removeFromSuperview()
            })
        }
    }
    
    
    fileprivate func showWithStatus(_ status: String?, isShow: Bool = true) {
        weak var selfWeak = self
        updateView()
        OperationQueue.main.addOperation {
            selfWeak!.hudView.addSubview(self.indicatorView)
            selfWeak!.hudView.addSubview(self.statusLabel)
            selfWeak!.overlayView.alpha = 0.0
            selfWeak!.statusLabel.text = status
            selfWeak!.statusLabel.sizeToFit()
            selfWeak!.hudView.transform = selfWeak!.hudView.transform.scaledBy(x: 1.3, y: 1.3)
            selfWeak!.indicatorView.startAnimating()
            UIView.animate(withDuration: AnimationDuration, animations: {
                selfWeak!.hudView.transform = selfWeak!.hudView.transform.scaledBy(x: 1/1.3, y: 1/1.3);
                selfWeak!.overlayView.alpha = 1.0;
            })
            self.indicatorView.isHidden = !isShow
            selfWeak!.setNeedsDisplay()
        }
        
    }
    
    func updateView() {
        if overlayView.superview == nil {
            let winArr = UIApplication.shared.windows
            for win in winArr {
                let isWinScreen = win.screen == UIScreen.main
                let isWinVisible = !win.isHidden && win.alpha > 0.001
                let isWinNormalLevel = win.windowLevel == UIWindowLevelNormal
                if isWinScreen && isWinVisible && isWinNormalLevel {
                    win.addSubview(self.overlayView)
                    break
                }
            }
        } else {
            overlayView.superview?.bringSubview(toFront: overlayView)
        }
        
        if hudView.superview == nil {
            addSubview(hudView)
        }
        
        if superview ==  nil {
            overlayView.addSubview(self)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let indiFrame = indicatorView.frame
        let statusFrame = statusLabel.frame
        
        if !indicatorView.isHidden {
            
            let hudSize = CGSize(width: compareMAX(indiFrame.size.width,ww: statusFrame.size.width) + 30, height: indiFrame.size.height + statusFrame.size.height + 30)
            
            hudView.size = hudSize
            hudView.center = overlayView.center
            
            let indicatorCenterY = hudView.height / 2
//            if statusLabel.text.length > 0 {
//                indicatorCenterY = hudView.height / 2 - 10
//            }
            indicatorView.center = CGPoint(x: hudView.width / 2, y: indicatorCenterY)
            statusLabel.center = CGPoint(x: hudView.width / 2, y: hudView.height - statusLabel.height)
        } else {
            let hudSize = CGSize(width: (statusFrame.size.width) + 30,  height: statusFrame.size.height + 30)
            hudView.size = hudSize
            hudView.center = overlayView.center
            statusLabel.center = CGPoint(x: hudView.width / 2, y: hudView.height - statusLabel.height - 10)
        }
    }
    
}
