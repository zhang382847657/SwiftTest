//
//  Dictionary+Extension.swift
//  SwiftTest
//  字典的扩展
//  Created by 张琳 on 2017/8/23.
//  Copyright © 2017年 张琳. All rights reserved.
//

import Foundation

extension Dictionary{
    
    
    /**
     *  两个字典进行合并
     * @params dic 需要合并的字典
     */
    mutating func contactWith(dic:Dictionary){
        
        for (key, value) in dic {
            self[key] = value
        }
    }
}
