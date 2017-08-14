//
//  BMCardUsageLogCellView.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/8/14.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit
import SwiftyJSON

class BMCardUsageLogCellView: UIView {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var payLabel: UILabel!
    @IBOutlet weak var numberLabel: UIButton!
   
    
    func updateWithLog(log:JSON){
        let payTime:Int? = log["payTime"].int
        let payMoney:Float? = log["payMoney"].float
        let tradeNo:String? = log["tradeNo"].string
        
        if let payTime = payTime{
            self.timeLabel.text = timeFormattingWithStamp(timeStamp: payTime, format: "YYYY-MM-DD HH:mm:ss")
            
        }else{
            self.timeLabel.text = "暂无交易时间"
        }
        
        if let payMoney = payMoney{
            self.payLabel.text = "\(payMoney)元"
        }else{
            self.payLabel.text = "暂无交易金额"
        }
        
        if let tradeNo = tradeNo{
            self.numberLabel.setTitle(tradeNo, for: .normal)
        }else{
            self.numberLabel.setTitle("暂无交易编号", for: .normal)
        }
    }
    
    
    //交易编号点击事件
    @IBAction func tradeNoClick(_ sender: UIButton) {
    }

}
