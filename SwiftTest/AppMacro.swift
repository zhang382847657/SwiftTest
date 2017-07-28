//
//  AppMacro.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/6/22.
//  Copyright © 2017年 张琳. All rights reserved.
//

import Foundation
import UIKit


let kScreenHeight = UIScreen.main.bounds.size.height  //屏幕高度
let kScreenWidth = UIScreen.main.bounds.size.width    //屏幕宽度
let BMHOST = "https://jz.qianmi.com"   //斑马请求地址
let BMDUSERCODE = "D00017"             //D用户编号



let BMThemeColor = "#00B4FF" //斑马主题颜色——蓝色
let BMThemeColorOrange = "#FF7140" //斑马主题颜色——橘色
let BMBacgroundColor = "#F5F6F5"  //斑马背景色
let BMBorderColor = "#dcdcdc"  //斑马边框颜色


let BMTitleColor = "#333333"  //斑马标题颜色
let BMSubTitleColor = "#666666"  //斑马副标题颜色
let BMSmallTitleColor = "#999999"  //斑马小标题颜色


let BMTitleFontSize:CGFloat = 16.0 //斑马标题字体大小
let BMSubTitleFontSize:CGFloat = 14.0  //斑马副标题字体大小
let BMSmallTitleFontSize:CGFloat = 12.0 //斑马小标题字体大小

let BMBorderSize:CGFloat = 0.5 //斑马边框大小



/**
 * 重写print方法，提高性能，只在debug模式下在控制台输出
 */
func dPrint( item:@autoclosure () -> Any) {
    #if DEBUG
    print(item())
    #endif
}



