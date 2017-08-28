//
//  BMOrderPayRecordView.swift
//  SwiftTest
//  订单详情——支付记录
//  Created by 张琳 on 2017/8/25.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit
import SwiftyJSON

class BMOrderPayRecordView: UIView {

    @IBOutlet weak var titleLabel: UILabel!  //标题
    @IBOutlet weak var payRecordLabel: UILabel!  //支付记录
    @IBOutlet weak var payPriceLabel: UILabel!  //需支付价格
    @IBOutlet weak var payButton: UIButton!  //立即支付按钮
    @IBOutlet weak var payBtnHeightConstraint: NSLayoutConstraint!  //立即支付按钮高度约束
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.payButton.layer.cornerRadius = 3
    }
    
    
    /**
     *  更新支付记录
     *  @params  records 支付记录
     */
    func updateWithPayRecords(records:JSON){
        let array:Array<JSON>? = records.array
        
        var finalString:String = ""
        
        if let array = array{
            
            for value in array{
                let addTime:Int? = value["addTime"].int
                let payType:String? = value["payType"].string
                let payMoney:Float? = value["payMoney"].float
                
                if let addTime = addTime, let payType = payType, let payMoney = payMoney{
                    
                    finalString += "您在 \(timeFormattingWithStamp(timeStamp: addTime, format: "YYYY-MM-DD HH:mm:ss")) \(payType) \(payMoney)元) \n"
                    
                }
            }
            
        }
        
        if finalString != "" {
            self.payRecordLabel.text = finalString
        }else{
            self.payRecordLabel.text = nil
        }
    }
    
    
    /**
     *  更新需支付价格、立即支付按钮
     *  @params  order 订单
     */
    func updateWithPayPrice(order:JSON){
        let receivedEmpFee:Float? = order["receivedEmpFee"].float
        let payCash:Float? = order["payCash"].float
        let status:Int? = order["status"].int
        
        var finalPrice:Float = 0
        var showPriceString:String = "您需支付："
        
        if let receivedEmpFee = receivedEmpFee, let payCash = payCash{
            
            finalPrice = payCash - receivedEmpFee
            
            if receivedEmpFee > 0{
                showPriceString = "您仍需支付："
            }else{
                showPriceString = "您需支付："
            }
        }
        
        self.payPriceLabel.text = "\(showPriceString)￥\(finalPrice)"
        
        
        if let status = status, status != 9 && status != 8 , finalPrice > 0 {
            self.payButton.isHidden = false
        }else{
            self.payButton.isHidden = true
            self.payBtnHeightConstraint.constant = 0
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.titleLabel.addBorderLayer(color: UIColor.colorWithHexString(hex: BMBorderColor), size: BMBorderSize, boderType: BorderType.bottom)
    }

}
