//
//  NSMutableAttributedString+Extension.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/8/17.
//  Copyright © 2017年 张琳. All rights reserved.
//

import Foundation
import UIKit

extension NSMutableAttributedString{
    
    
    /**
     * 给一段文字设置不同的样式 
     * @params text 文字内容
     * @params frontFontSize 前边文字大小
     * @params frontColor 前边文字颜色
     * @params frontRange 前边文字范围
     * @params hehindTextFontSize 后边文字大小
     * @params behindColor 后边文字颜色
     * @params behindRange 后边文字范围
     * return NSMutableAttributedString 返回文字属性
     */
    static func setLabelText(text:String?, frontFontSize:CGFloat? ,frontColor:UIColor?,frontRange:NSRange?,behindTextFontSize:CGFloat?,behindColor:UIColor?,behindRange:NSRange?) -> NSMutableAttributedString?{
        
        if let text = text , text != ""{
            
            let attributeString:NSMutableAttributedString = NSMutableAttributedString(string: text)
            
            if let frontRange = frontRange{
                
                if let frontFontSize = frontFontSize{
                    attributeString.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: frontFontSize), range: frontRange)
                }
                
                if let frontColor = frontColor{
                    attributeString.addAttribute(NSForegroundColorAttributeName, value: frontColor, range: frontRange)
                }
                
            }
            
            if let behindRange = behindRange{
                
                if let behindTextFontSize = behindTextFontSize{
                    attributeString.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: behindTextFontSize), range: behindRange)
                }
                
                if let behindColor = behindColor{
                    attributeString.addAttribute(NSForegroundColorAttributeName, value: behindColor, range: behindRange)
                }
                
            }
            
            return attributeString
            
            
        }else{
            return nil
        }
        
    }
    
    
}
