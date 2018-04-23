//
//  UIImage+Extension.swift
//  ColorMoon
//
//  Created by xiongkai on 16/9/6.
//  Copyright © 2016年 薛凯凯圆滚滚. All rights reserved.
//  UIImage扩展 

import UIKit
import Foundation


extension UIImage {

    /**
     根据颜色绘制一张图片
     */
    class func imageWithColor(_ color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContextWithOptions(rect.size, true, 0)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    /**
     按尺寸裁剪图片大小
     */
    class func imageClipToNewImage(_ image: UIImage, newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(newSize)
        image.draw(in: CGRect(origin: CGPoint.zero, size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    /**
     将传入的图片裁剪成带边缘的原型图片
     */
    class func imageWithClipImage(_ image: UIImage, borderWidth: CGFloat, borderColor: UIColor) -> UIImage {
        let imageWH = image.size.width
        let ovalWH = imageWH + 2 * borderWidth
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: ovalWH, height: ovalWH), false, 0)
        let path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: ovalWH, height: ovalWH))
        borderColor.set()
        path.fill()
        
        let clipPath = UIBezierPath(ovalIn: CGRect(x: borderWidth, y: borderWidth, width: imageWH, height: imageWH))
        clipPath.addClip()
        image.draw(at: CGPoint(x: borderWidth, y: borderWidth))
        
        let clipImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return clipImage!
    }
    
    /**
     将传入的图片裁剪成圆形图片
     */
    func imageClipOvalImage() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, 0.0)
        let ctx = UIGraphicsGetCurrentContext()
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        ctx?.addEllipse(in: rect)
        
        ctx?.clip()
        self.draw(in: rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    func imageToSize(_ targetSize: CGSize) -> UIImage? {
        let soureceImage = self
        var newImage:UIImage? = nil
        let imageSize = soureceImage.size
        let width = imageSize.width
        let height = imageSize.height
        let targetWidth = targetSize.width
        
        let targetHeight = targetSize.height
        var scaleFactor:CGFloat = 0.0
        var scaledWidth = targetWidth
        var scaledHeight = targetHeight
        var thumbnailPoint:CGPoint = CGPoint(x: 0.0,y: 0.0)
        if imageSize.equalTo(targetSize) == false {
            let widthFactor = targetWidth / width
            let heightFactor = targetHeight / height
            if (widthFactor < heightFactor) {
                scaleFactor = widthFactor
            }
            else {
                scaleFactor = heightFactor;
            }
            scaledWidth  = width * scaleFactor;
            scaledHeight = height * scaleFactor;
            if (widthFactor < heightFactor) {
                
                thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
            } else if (widthFactor > heightFactor) {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
        }
        UIGraphicsBeginImageContext(targetSize);
        var thumbnailRect = CGRect.zero;
        thumbnailRect.origin = thumbnailPoint
        thumbnailRect.size.width  = scaledWidth
        thumbnailRect.size.height = scaledHeight
        
        
        soureceImage.draw(in: thumbnailRect)
        
        newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        if newImage == nil {
            print("could not scale image")
        }
        return newImage ;
        
    }
}
