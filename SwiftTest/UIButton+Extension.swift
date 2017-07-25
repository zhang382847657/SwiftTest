//
//  UIButton+Extension.swift
//  SwiftTest
//  UIButton的扩展
//  Created by 张琳 on 2017/7/19.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit

extension UIButton {
    
    
    // MARK: - 自定义的方法
    
    /**
     *  设置按钮图片文字的位置
     *  @param : image   图标
     *  @param : title   文字
     *  @param : titlePosition  文字的位置  枚举类型
     *  @param : additionalSpacing  文字与图标的间距
     *  @parma : state   按钮状态
     */
    
    @objc func set(image anImage: UIImage?,title: String,titlePosition: UIViewContentMode,additionalSpacing: CGFloat,state: UIControlState) {
        
        self.imageView?.contentMode = .center
        self.setImage(anImage, for: state)
        
        positionLabelRespectToImage(title: title,position: titlePosition, spacing: additionalSpacing)
        
        self.titleLabel?.contentMode = .center
        self.setTitle(title, for: state)
    }
    
    private func positionLabelRespectToImage(title: String, position: UIViewContentMode, spacing: CGFloat) {
        
        let imageSize = self.imageRect(forContentRect: self.frame)
        let titleFont  = self.titleLabel?.font!
        let titleSize = title.size(attributes: [NSFontAttributeName: titleFont!])
        
        var titleInsets: UIEdgeInsets
        var imageInsets: UIEdgeInsets
        
        switch (position){
        case .top:
            titleInsets = UIEdgeInsets(top: -(imageSize.height + titleSize.height + spacing), left: -(imageSize.width), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -titleSize.width)
        case .bottom:
            titleInsets = UIEdgeInsets(top: (imageSize.height + titleSize.height + spacing), left: -(imageSize.width), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -titleSize.width)
        case .left: titleInsets = UIEdgeInsets(top: 0, left: -(imageSize.width * 2), bottom:0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -(titleSize.width * 2 + spacing))
        case .right: titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -spacing)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        default: titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        
        self.titleEdgeInsets = titleInsets
        self.imageEdgeInsets = imageInsets
    }
}
