//
//  BMCache.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/7/28.
//  Copyright © 2017年 张琳. All rights reserved.
//

import Foundation

import SwiftyUserDefaults


class BMCache: NSObject {
    internal static let instance = BMCache()

    //必须保证init方法的私有性，只有这样，才能保证单例是真正唯一的，避免外部对象通过访问init方法创建单例类的其他实例。由于Swift中的所有对象都是由公共的初始化方法创建的，我们需要重写自己的init方法，并设置其为私有的。
    private override init(){
        print("create 单例")
        
//       Defaults[.phone] = "15037104407"
        
    }
    
}
