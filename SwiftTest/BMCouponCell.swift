//
//  BMCouponCell.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/8/14.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit
import SwiftyJSON

class BMCouponCell: UITableViewCell {

    @IBOutlet weak var newsLabel: UILabel!  //NEW
    @IBOutlet weak var priceLabel: UILabel! //优惠券价格
    @IBOutlet weak var conditionLabel: UILabel! //优惠券使用条件
    @IBOutlet weak var nameLabel: UILabel! //优惠券名字
    @IBOutlet weak var timeLabel: UILabel! //优惠券有效期
    @IBOutlet weak var suggestProductsLabel: UILabel!  //优惠券支持商品
    @IBOutlet weak var suggestShopsLabel: UILabel! //优惠券支持门店
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.newsLabel.layer.borderWidth = BMBorderSize
        self.newsLabel.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7).cgColor
        

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func updateWithCoupons(coupon:JSON){
        
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
            self.conditionLabel.text = "满\(usePrice)元可用"
        }else{
            self.conditionLabel.text = "--"
        }
        
        if let parvalue = parvalue{
            self.priceLabel.attributedText = NSMutableAttributedString.setLabelText(text: "￥\(parvalue)", frontFontSize: BMSmallTitleFontSize, frontColor: UIColor.white, frontRange: NSRange(location: 0, length: 1), behindTextFontSize: nil, behindColor: nil, behindRange: nil)
        }else{
            self.priceLabel.text = "--"
        }
        
        if let useStartTime = useStartTime , let useEndTime = useEndTime{
            let starTime = timeFormattingWithStamp(timeStamp: useStartTime, format: "YYYY-MM-DD")
            let endTime = timeFormattingWithStamp(timeStamp: useEndTime, format: "YYYY-MM-DD")
            self.timeLabel.text = "有效期 \(starTime) 至 \(endTime)"
        }else{
            self.timeLabel.text = "有效期 --"
        }
        
        var finalProductStr:String = "1.支持商品：--"
        var finalShopStr:String = "2.支持门店：--"
        
        if let itemId = itemId , itemId == "0"{
            finalProductStr = "1.支持商品：不限制"
        }
        
        if let itemName = itemName, itemName != ""{
            
            let finalName:String = itemName.characters.split(separator: ",").map(String.init).joined(separator: "、")
            finalProductStr = "1.支持商品：\(finalName)"
        }
        
        
        if let shopCode = shopCode , shopCode == "0"{
            finalShopStr = "2.支持门店：不限制"
        }
        
        if let shopName = shopName , shopName != ""{
            let finalName:String = shopName.characters.split(separator: ",").map(String.init).joined(separator: "、")
            finalShopStr = "2.支持门店：\(finalName)"
        }
        
        self.suggestProductsLabel.text = finalProductStr
        self.suggestShopsLabel.text = finalShopStr
        
        
    }
    
}
