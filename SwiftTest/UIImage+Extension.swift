//
//  UIImage+Extension.swift
//  SwiftTest
//  UIImage的扩展
//  Created by 张琳 on 2017/8/3.
//  Copyright © 2017年 张琳. All rights reserved.
//


import UIKit

extension UIImage {
    
    
    // MARK: - 自定义的方法
    
    /**
     *  改变UIImage的颜色
     *  param : tint   填充的颜色值
     *  param : blendMode  混合模式
     *  return : UIImage
     */
    
    func tint(color: UIColor, blendMode: CGBlendMode) -> UIImage
    {
        
        let drawRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        color.setFill()
        UIRectFill(drawRect)
        draw(in: drawRect, blendMode: blendMode, alpha: 1.0)
        let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return tintedImage!
    }
    
}

