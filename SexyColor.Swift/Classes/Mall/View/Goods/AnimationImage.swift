//
//  AnimationImage.swift
//  SexyColor.Swift
//
//  Created by kayzhang on 2017/9/14.
//  Copyright © 2017年 薛凯凯圆滚滚. All rights reserved.
//

import UIKit

class AnimationImage: UIImageView {

    var path : UIBezierPath!
    
    override func draw(_ rect: CGRect) {
        path.stroke()
        path.fill()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addLayer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addLayer() {
        path = UIBezierPath()
        path.lineWidth = 5.0
        path.lineCapStyle = .round
        path.lineJoinStyle = .round
        path.move(to: CGPoint(x: self.frame.origin.x, y: self.frame.origin.y))
        path.addQuadCurve(to: CGPoint(x: ScreenWidth - 70, y: 0), controlPoint: CGPoint(x: 0, y: ScreenHeight / 2))
        
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.fromValue = 0
        rotationAnimation.toValue = Double.pi
        rotationAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = 0.7
        scaleAnimation.toValue = 1
        scaleAnimation.repeatCount = 3
        scaleAnimation.duration = 0.25
        scaleAnimation.autoreverses = true
        scaleAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        
        let pathAnimation = CAKeyframeAnimation(keyPath: "position")
        var t = CGAffineTransform(scaleX: 1.0,y: 1.0)
        pathAnimation.path = path.cgPath.copy(using: &t)!
        
        let animaGroup = CAAnimationGroup()
        animaGroup.duration = 0.7
        animaGroup.isRemovedOnCompletion = false
        animaGroup.fillMode = kCAFillModeForwards
        animaGroup.animations = [rotationAnimation, scaleAnimation, pathAnimation]
        animaGroup.delegate = self
        
        self.layer.add(animaGroup, forKey: nil)
        self.setNeedsDisplay()
    }
}

extension AnimationImage : CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        self.removeFromSuperview()
    }
}


