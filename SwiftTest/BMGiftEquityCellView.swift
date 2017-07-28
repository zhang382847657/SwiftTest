//
//  BMGiftEquityCellView.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/7/25.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit
import SwiftyJSON

class BMGiftEquityCellView: UIView {

    @IBOutlet weak var nameLabel: UILabel! //优惠券名称
    @IBOutlet weak var countLabel: UILabel!  //优惠券数量
    @IBOutlet weak var dataLabel: UILabel!  //优惠券有效期
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addBorderLayer(color: UIColor.colorWithHexString(hex: BMBorderColor), size: BMBorderSize, boderType: .bottom)
        self.countLabel.addBorder(color: UIColor.colorWithHexString(hex: BMThemeColorOrange), size: BMBorderSize, borderTypes: [BorderType.top.rawValue,BorderType.bottom.rawValue,BorderType.left.rawValue,BorderType.right.rawValue])
    }
    
    
    func updataUIWithCoupon(coupon:JSON){
        
        let name = coupon["couponPublishBo"]["title"].string
        let count = coupon["num"].int
        
        
    
        let useStartTime = timeFormattingWithStamp(timeStamp: coupon["couponPublishBo"]["useStartTime"].int!, format: "YYYY-MM-DD")
        let useEndTime = timeFormattingWithStamp(timeStamp: coupon["couponPublishBo"]["useEndTime"].int!, format: "YYYY-MM-DD")
        
        if let name = name{
            self.nameLabel.text = name
        }else{
            self.nameLabel.text = "暂无优惠券名称"
        }
        
        if let count = count{
            self.countLabel.text = "\(count)张"
        }else{
            self.countLabel.text = "0张"
        }
        
        
        self.dataLabel.text = "有效期 \(useStartTime) 至 \(useEndTime)"
    }

}
