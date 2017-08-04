//
//  View.swift
//  SwiftTest
//  UIView的扩展
//  Created by 张琳 on 2017/6/24.
//  Copyright © 2017年 张琳. All rights reserved.
//

import Foundation
import UIKit

enum BorderType:NSInteger{
    
    case top,left,bottom,right
    
}
extension UIView{
    
    // MARK: - 重写父类的方法
    
    
    //////////以下三个方法是给UIView添加点击效果  更改背景色////////////////
//    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        
//        self.backgroundColor = UIColor.groupTableViewBackground
//    }
//
//    open override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
//        UIView.animate(withDuration: 0.15, animations: { () -> Void in
//            self.backgroundColor = UIColor.clear
//        })
//    }
//    
//    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        
//        UIView.animate(withDuration: 0.15, animations: { () -> Void in
//            self.backgroundColor = UIColor.clear
//        })
//    }

    
    // MARK: - 自定义的方法

    /**
     *  为视图指定的四个边加上边框
     * param:color  边框颜色
     * param: size  边框大小
     * param: borderTypes 边框方向数组  用枚举值表示子元素
     */
    func addBorder(color: UIColor?, size: CGFloat, borderTypes:Array<Int>){
        
        var currentColor:UIColor?
        
        if let _ = color{
            currentColor = color
        }else{
            currentColor = UIColor.black
        }
        
        for borderType in borderTypes{
            let bt = borderType
            self.addBorderLayer(color: currentColor!, size: size, boderType: BorderType(rawValue: bt)!)
        }
        
    }
    
    /**
     *  为视图某一个边加上边框
     * param:color  边框颜色
     * param: size  边框大小
     * param: borderType 边框方向  用枚举值表示
     */
    
    func addBorderLayer(color: UIColor, size: CGFloat, boderType: BorderType){
        
        let layer:CALayer = CALayer()
        layer.backgroundColor = color.cgColor
        self.layer.addSublayer(layer)
        
        switch boderType{
            
        case .top:
            layer.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: size)
        case .left:
            layer.frame = CGRect(x: 0, y: 0, width: size, height: self.frame.height)
            
        case .bottom:
            layer.frame = CGRect(x: 0, y: self.frame.height - size, width: self.frame.width, height: size)
            
        case .right:
            layer.frame = CGRect(x: self.frame.width - size,  y: 0, width: size, height: self.frame.height)
        
        }
        
    }
    
    /**
     *  加载xib
     * param:nibName  xib的文件名
     * return UIView  返回xib对应的视图
     */
    
    static func loadViewFromNib(nibName:String) -> UIView? {
        
        let nibView = Bundle.main.loadNibNamed(nibName, owner: nil, options: nil)
        
        if let view = nibView?.first as? UIView{
            return view
        }
        return nil
    }
    
    /**
     * 得到视图所在的ViewController
     * param:view  当前的view
     * return UIViewController
     */
    func getViewController() -> UIViewController? {
        var next:UIView? = self
        repeat{
            if let nextResponder = next?.next , nextResponder.isKind(of: UIViewController.self){
                return nextResponder as? UIViewController
            }
            next = next?.superview
        }while next != nil
        return nil
    }
}
