//
//  BMAfterSaleHeaderView.swift
//  SwiftTest
//  售后单——头部视图
//  Created by 张琳 on 2017/8/24.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit
import SwiftyJSON

class BMAfterSaleHeaderView: UIView {

    @IBOutlet weak var priceLabel: UILabel! //中介费
    @IBOutlet weak var timeLabel: UILabel!  //质保结束时间
    
    
    /**
     * 更新数据
     */
    func updateWithAfterSale(afterSale:JSON){
        
        let serviceEndDate:Int? = afterSale["serviceEndDate"].int
        let cmidFee:Float? = afterSale["cmidFee"].float
        let orderType:Int = afterSale["orderType"].intValue
        
        if let cmidFee = cmidFee{
            self.priceLabel.text = "中介费：￥\(cmidFee)"
        }else{
            self.priceLabel.text = "中介费：￥0"
        }
        
        var name:String = ""
        if orderType == 1 { //服务
            name = "服务"
        }else if orderType == 2{  //质保
            name = "质保"
        }
        
        if let serviceEndDate = serviceEndDate{
            self.timeLabel.text = "\(name)结束时间：\(timeFormattingWithStamp(timeStamp: serviceEndDate, format: "YYYY-MM-DD"))"
        }else{
            self.timeLabel.text = "\(name)结束时间：--"
        }
        
    }
    

}
