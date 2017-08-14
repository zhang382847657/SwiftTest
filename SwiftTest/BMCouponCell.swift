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

    @IBOutlet weak var newsLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var suggestProductsLabel: UILabel!
    @IBOutlet weak var suggestShopsLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.newsLabel.layer.borderWidth = BMBorderSize
        self.newsLabel.layer.borderColor = UIColor.colorWithHexString(hex: BMBorderColor).cgColor

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func updateWithCoupons(coupon:JSON){
        
        let title:String? = coupon["title"].string
        
        if let title = title{
            self.nameLabel.text = title
        }else{
            self.nameLabel.text = "暂无优惠券名称"
        }
    }
    
}
