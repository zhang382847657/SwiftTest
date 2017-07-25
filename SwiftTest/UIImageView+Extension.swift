//
//  UIImageView+Extension.swift
//  SwiftTest
//  UIImageView的扩展
//  Created by 张琳 on 2017/6/26.
//  Copyright © 2017年 张琳. All rights reserved.
//

import Foundation
import UIKit


extension UIImageView{
    
    // MARK: - 重写父类的方法
    
    
    //////////以下三个方法是给UIView添加点击效果  更改背景色////////////////
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.backgroundColor?.withAlphaComponent(0.6)
    }
    
    open override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.15, animations: { () -> Void in
            self.backgroundColor?.withAlphaComponent(1.0)
        })
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        UIView.animate(withDuration: 0.15, animations: { () -> Void in
            self.backgroundColor?.withAlphaComponent(1.0)
        })
    }
}
