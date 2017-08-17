//
//  BMCouponDetailView.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/8/16.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit
import SwiftyJSON

//优惠券关闭按钮闭包
typealias CouponDetailCloseClickClosure = () -> Void

class BMCouponDetailView: UIView {
 
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var priceLabel: UILabel! //优惠券价格
    @IBOutlet weak var nameLabel: UILabel!  //优惠券名字
    
    @IBOutlet weak var oneLabel: UILabel!  //单笔支付
    @IBOutlet weak var twoLabel: UILabel!  //有效期
    @IBOutlet weak var threeLabel: UILabel! //支持商品
    @IBOutlet weak var fourLabel: UILabel! //支持门店
    
    var couponDetailCloseClickClosure: CouponDetailCloseClickClosure? //优惠券关闭按钮的闭包
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.layer.masksToBounds = true
        self.contentView.layer.cornerRadius = 6
    }
    
    
    func updateWithCoupon(coupon:JSON){
        let title:String? = coupon["title"].string
        let useStartTime:Int? = coupon["useStartTime"].int
        let useEndTime:Int? = coupon["useEndTime"].int
        let itemId:String? = coupon["itemId"].string
        let itemName:String? = coupon["itemName"].string
        let usePrice:Float? = coupon["usePrice"].float
        let shopCode:String? = coupon["shopCode"].string
        let shopName:String? = coupon["shopName"].string
        let parvalue:Float? = coupon["parvalue"].float
        
        if let title = title{
            self.nameLabel.text = title
        }else{
            self.nameLabel.text = "暂无优惠券名称"
        }
        
        if let usePrice = usePrice{
            self.oneLabel.text = "1.单笔满\(usePrice)元可用"
        }else{
            self.oneLabel.text = "1.单笔满--元可用"
        }
        
        if let parvalue = parvalue{
            self.priceLabel.attributedText = NSMutableAttributedString.setLabelText(text: "￥\(parvalue)", frontFontSize: BMSmallTitleFontSize, frontColor: UIColor.white, frontRange: NSRange(location: 0, length: 1), behindTextFontSize: nil, behindColor: nil, behindRange: nil)
        }else{
            self.priceLabel.text = "--"
        }
        
        if let useStartTime = useStartTime , let useEndTime = useEndTime{
            let starTime = timeFormattingWithStamp(timeStamp: useStartTime, format: "YYYY-MM-DD")
            let endTime = timeFormattingWithStamp(timeStamp: useEndTime, format: "YYYY-MM-DD")
            self.twoLabel.text = "2.有效期 \(starTime) 至 \(endTime)"
        }else{
            self.twoLabel.text = "2.有效期 --"
        }
        
        var finalProductStr:String = "3.支持商品：--"
        var finalShopStr:String = "4.支持门店：--"
        
        if let itemId = itemId , itemId == "0"{
            finalProductStr = "3.支持商品：不限制"
        }
        
        if let itemName = itemName, itemName != ""{
            
            let finalName:String = itemName.characters.split(separator: ",").map(String.init).joined(separator: "、")
            finalProductStr = "3.支持商品：\(finalName)"
        }
        
        
        if let shopCode = shopCode , shopCode == "0"{
            finalShopStr = "4.支持门店：不限制"
        }
        
        if let shopName = shopName , shopName != ""{
            let finalName:String = shopName.characters.split(separator: ",").map(String.init).joined(separator: "、")
            finalShopStr = "4.支持门店：\(finalName)"
        }
        
        self.threeLabel.text = finalProductStr
        self.fourLabel.text = finalShopStr
    }
   
    
    //关闭点击事件
    @IBAction func coloseClick(_ sender: UIButton) {
        
        if let couponDetailCloseClickClosure = self.couponDetailCloseClickClosure{
            couponDetailCloseClickClosure()
        }
    }

}
