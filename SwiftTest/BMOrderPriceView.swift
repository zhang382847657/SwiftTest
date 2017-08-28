//
//  BMOrderPriceView.swift
//  SwiftTest
//  订单详情——价格视图
//  Created by 张琳 on 2017/8/25.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit
import SwiftyJSON

class BMOrderPriceView: UIView {

    @IBOutlet weak var sumPriceLabel: UILabel! //合计
    @IBOutlet weak var memberPreferencesLabel: UILabel! //会员优惠
    @IBOutlet weak var couponLabel: UILabel!  //优惠券
    @IBOutlet weak var payPriceLabel: UILabel!  //需支付
    
    
    
    /**
     *  更新合计价格、优惠券
     */
    func updateSumPriceWithOrder(order:JSON){
        
        let goodsTradeList:Array? = order["goodsTradeList"].array
        let cmidFee:Float? = order["cmidFee"].float
        let payCash:Float? = order["payCash"].float
        
        
        
        var sumPrice:Float = 0 //合计的价格
        var couponPrice:Float = 0 //优惠的价格
        var payCashPrice:Float = 0 //需支付的价格
        
        if let goodsTradeList = goodsTradeList{
            for goods in goodsTradeList{
                
                let salePrice:Float? = goods["salePrice"].float
                
                if let salePrice = salePrice{
                    
                    sumPrice += salePrice
                }
                
            }
        }
        
        if let cmidFee = cmidFee , let payCash = payCash{
            couponPrice = cmidFee - payCash
            payCashPrice = payCash
        }
        
        self.sumPriceLabel.text = "￥\(sumPrice)"
        self.couponLabel.text = "-￥\(couponPrice)"
        self.payPriceLabel.text = "需支付￥\(payCashPrice)"
        
    }
    
    
    /**
     *  更新会员优惠
     */
    func updateMemberPreferences(data:JSON){
        
        let array:Array<JSON>? = data.array
        
        var finalPrice:Float = 0  //最终显示的优惠价格
        var priceList:Array<Float> = []
        
        if let array = array , array.count > 0{
            
            for item in array{
                let disType:Int? = item["disType"].int
                if let disType = disType, disType == 2{
                    
                    let originalPrice:Float? = item["originalPrice"].float
                    let actualPrice:Float? = item["actualPrice"].float
                    
                    if let originalPrice = originalPrice, let actualPrice = actualPrice{
                        priceList.append(originalPrice - actualPrice)
                    }
                }
            }
            
            for price in priceList {
                finalPrice += price
            }
            
        }
        
        self.memberPreferencesLabel.text = "-￥\(finalPrice)"
        
    }
    
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.addBorderLayer(color: UIColor.colorWithHexString(hex: BMBorderColor), size: BMBorderSize, boderType: BorderType.top)
    }

}
