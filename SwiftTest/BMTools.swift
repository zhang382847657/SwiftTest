//
//  BMTools.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/7/21.
//  Copyright © 2017年 张琳. All rights reserved.
//

import Foundation
import UIKit



/**
 * 设置行间距
 * param: string  内容
 * param: lineSpace  行间距
 * return: NSAttributedString
 */

func getAttributeStringWithString(_ string: String,lineSpace:CGFloat) -> NSAttributedString{
    
    let attributedString = NSMutableAttributedString(string: string)
    let paragraphStye = NSMutableParagraphStyle()
    
    //调整行间距
    paragraphStye.lineSpacing = lineSpace
    let rang = NSMakeRange(0, CFStringGetLength(string as CFString!))
    attributedString .addAttribute(NSParagraphStyleAttributeName, value: paragraphStye, range: rang)
    return attributedString
    
}


/**
 * 时间戳转时间
 * param: timeStamp  时间戳
 * param: format  格式  YYMMDD
 * return: String  格式化好的时间字符串
 */
func timeFormattingWithStamp(timeStamp:Int,format:String) -> String{
    

    //转换为时间
    let date = NSDate(timeIntervalSince1970: TimeInterval(timeStamp/1000))
    
    //格式化输出
    let dformatter = DateFormatter()
    dformatter.dateFormat = format
    
    return dformatter.string(from: date as Date)
   
}
