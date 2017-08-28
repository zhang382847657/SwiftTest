//
//  BMOrderDetailBottomView.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/8/25.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit
import SwiftyJSON

//订单取消闭包
typealias TradeCancelClosure = () -> Void

class BMOrderDetailBottomView: UIView {
    
    @IBOutlet weak var tradeNoLabel: UILabel!  //订单编号
    @IBOutlet weak var timeLabel: UILabel!  //创建时间
    @IBOutlet weak var cancelBtn: UIButton!  //取消订单按钮
    
    var tradeCancelClosure: TradeCancelClosure? //订单取消闭包

    func updateWithOrder(order:JSON){
        
        let tradeNo:String = order["tradeNo"].stringValue
        let ctime:Int? = order["ctime"].int
        let status:Int? = order["status"].int
        let cateId:Int? = order["cateId"].int
        let complainNo:String? = order["complainNo"].string
        let payState:Int? = order["payState"].int
        let cmidFee:Float? = order["cmidFee"].float
        let flowStatus:String? = order["flowStatus"].string
        
        var canCancel:Bool = false //是否可以取消订单
        
        self.tradeNoLabel.text = "订单编号：\(tradeNo)"
        
        if let ctime = ctime{
            self.timeLabel.text = "创建时间：\(timeFormattingWithStamp(timeStamp: ctime, format: "YYYY-MM-DD HH:mm:ss"))"
        }else{
            self.timeLabel.text = "创建时间：--"
        }
        
        if let status = status , status != 9 && status != 8 , let cateId = cateId{
            
            if cateId == 2{ //保洁单
                
                if complainNo == nil{
                    if let payState = payState, payState == 0, let flowStatus = flowStatus{  //未付款并且金额不为0,并且状态不为已完成的才可以取消
                        
                        if (cmidFee == nil || cmidFee == 0) && (flowStatus == "pending_complete" || flowStatus == "complete"){
                            canCancel = false
                        }else{
                            if flowStatus != "complete" {
                                canCancel = true
                            }
                        }
                        
                    }
                    
                    if flowStatus == "pending_complete" || flowStatus == "complete" { //已派工或者已完成
                        canCancel = true
                    }
                }
                
            }else if cateId == 1{ //家政单
                
                if let flowStatus = flowStatus , flowStatus == "pending_take_trade" || flowStatus == "pending_choice_aunt" || flowStatus == "pending_interview" || flowStatus == "pending_signed"{
                    canCancel = true
                }
                
            }

        }
        
        self.cancelBtn.isHidden = !canCancel
        
    }

    //取消订单按钮点击事件
    @IBAction func cancelClick(_ sender: UIButton) {
        
        if let tradeCancelClosure = self.tradeCancelClosure{
            tradeCancelClosure()
        }
    }
}
