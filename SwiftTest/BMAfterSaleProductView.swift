//
//  BMAfterSaleProductView.swift
//  SwiftTest
//  售后单——商品信息
//  Created by 张琳 on 2017/8/24.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit
import SwiftyJSON

class BMAfterSaleProductView: UIView {

    @IBOutlet weak var imageView: UIImageView! //商品图标
    @IBOutlet weak var productNameLabel: UILabel! //商品名字
    @IBOutlet weak var priceLabel: UILabel! //商品价格
    @IBOutlet weak var formatLabel: UILabel! //商品规格
    @IBOutlet weak var timeLabel: UILabel! //时间
    
    
    func updateWithAfterSale(afterSale:JSON){
        let serviceType:Int? = afterSale["serviceType"].int
        let productName:String? = afterSale["productName"].string
        let servicePrice:Float? = afterSale["servicePrice"].float
        let serviceStartDate:Int? = afterSale["serviceStartDate"].int
        let serviceJsonParams:String? = afterSale["serviceJsonParams"].string
        let servicePriceUnit:String? = afterSale["servicePriceUnit"].string
        
        
        
        self.imageView.image = UIImage(named: Config.productByItemId(itemId: serviceType)["icon"]!)
        
        if let productName = productName{
            self.productNameLabel.text = productName
        }else{
            self.productNameLabel.text = "--"
        }
        
        if let servicePrice = servicePrice{
            self.priceLabel.text = "￥\(servicePrice)"
        }else{
            self.priceLabel.text = "￥0"
        }
        
        if let serviceJsonParams = serviceJsonParams, let servicePriceUnit = servicePriceUnit{
            let newServiceJsonParams:JSON = JSON(parseJSON: serviceJsonParams)
            let newServicePriceUnit:JSON = JSON(parseJSON: servicePriceUnit)
            let tradeServiceItemList:Array<JSON>? = newServiceJsonParams["tradeServiceItemList"].array
            var serviceContent:String = ""
            if let tradeServiceItemList = tradeServiceItemList{
                for i in 0..<tradeServiceItemList.count{
                    if i == 0 && tradeServiceItemList.count > 1{
                        serviceContent = tradeServiceItemList[i]["itemName"].stringValue
                    }else if i == 0 && tradeServiceItemList.count == 1{
                        serviceContent = "\(tradeServiceItemList[i]["itemName"].stringValue)/"
                    }else if i == tradeServiceItemList.count - 1{
                        serviceContent += "、\(tradeServiceItemList[i]["itemName"].stringValue)/"
                    }else{
                        serviceContent += "、\(tradeServiceItemList[i]["itemName"].stringValue)"
                    }
                }
            }
            
            let unitName:String? = newServicePriceUnit["unitName"].string
            let unit:Int = newServicePriceUnit["unit"].intValue
            
            serviceContent += "\(unit)"
            
            var finalUnitName:String = ""
            if let unitName = unitName{
                if unitName == "月"{
                    finalUnitName = "个月"
                }else{
                    finalUnitName = unitName
                }
                serviceContent += finalUnitName
            }
            
            
            self.formatLabel.text = serviceContent
            
        }else{
            self.formatLabel.text = "--"
        }
        
        if let serviceStartDate = serviceStartDate{
            self.timeLabel.text = timeFormattingWithStamp(timeStamp: serviceStartDate, format: "YYYY-MM-DD HH:mm:ss")
        }else{
            self.timeLabel.text = "--"
        }
    }

}
