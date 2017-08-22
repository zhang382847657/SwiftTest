//
//  BMVipCardCell.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/8/21.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit
import SwiftyJSON

class BMVipCardCell: UICollectionViewCell {

    @IBOutlet weak var nameLabel: UILabel!  //会员卡名字
    @IBOutlet weak var timeLabel: UILabel!  //会员卡有效期
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 5
    }
    
    func updateWithVip(vip:JSON){
        
        let name:String? = vip["name"].string
        let expTime:Int? = vip["expTime"].int
        let beginTime:Int? = vip["beginTime"].int
        let sort:Int? = vip["sort"].int
        
        if let name = name{
            self.nameLabel.text = name
        }else{
            self.nameLabel.text = "暂无会员卡名字"
        }
        
        if let expTime = expTime, let _ = beginTime{
            self.timeLabel.text = "有效期 至\(timeFormattingWithStamp(timeStamp: expTime, format: "YYYY-MM-DD"))"
        }else{
            self.timeLabel.text = "有效期 无限期"
        }
        
        
        self.backgroundColor = UIColor.colorWithHexString(hex: Config.vipBackgroundColor(sort: sort))
        
    }

}
