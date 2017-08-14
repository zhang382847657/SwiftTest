//
//  BMCardsCell.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/8/10.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit
import SwiftyJSON

class BMCardsCell: UITableViewCell {

    @IBOutlet weak var cardView: UIView! //卡包视图
    @IBOutlet weak var backgroundImageView: UIImageView!  //卡包水印背景图片
    @IBOutlet weak var nameLabel: UILabel!  //名称
    @IBOutlet weak var timeLabel: UILabel!  //有效期
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layoutIfNeeded()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        self.cardView.corner(byRoundingCorners: [.topLeft,.topRight], radii: 5) //设置左上角右上角的圆角
    }

   
    
    //套餐卡
    func updateWithComboCard(comboCard:JSON){
        
        self.cardView.backgroundColor = UIColor.colorWithHexString(hex: BMThemeColor)
        self.backgroundImageView.image = UIImage(named:"tckbj_kb")
        
        let name:String? = comboCard["name"].string
        let expireTime:Int? = comboCard["expireTime"].int
        
        if let name = name{
            self.nameLabel.text = name
        }else{
            self.nameLabel.text = "暂无套餐卡名字"
        }
        
        if let expireTime = expireTime{
            self.timeLabel.text = "有效期 至 \(timeFormattingWithStamp(timeStamp: expireTime, format: "YYYY-MM-DD"))"
        }else{
            self.timeLabel.text = "有效期 无限期"
        }
        
    }
    
    //储值卡
    func updateWithStoreCard(storeCard:JSON){
        
        self.cardView.backgroundColor = UIColor.colorWithHexString(hex: BMThemeColorOrange)
        self.backgroundImageView.image = UIImage(named:"czkbj_kb")
        
        let kindName:String? = storeCard["kindName"].string
        let termState:Int? = storeCard["termState"].int
        let termStartTime:Int? = storeCard["termStartTime"].int
        let vaildDays:Int? = storeCard["vaildDays"].int
        let termEndTime:Int? = storeCard["termEndTime"].int
        
        if let kindName = kindName{
            self.nameLabel.text = kindName
        }else{
            self.nameLabel.text = "暂无储值卡名字"
        }
        
        if let termState = termState{
            if termState == 0{
                self.timeLabel.text = "有效期 无限期"
            }else if termState == 1{
                if let termStartTime = termStartTime, let vaildDays = vaildDays{
                    self.timeLabel.text = "有效期 至"
                }else{
                    self.timeLabel.text = ""
                }
                
            }else if termState == 2{
                if let termStartTime = termStartTime, let termEndTime = termEndTime{
                    self.nameLabel.text = "有效期 \(timeFormattingWithStamp(timeStamp: termStartTime, format: "YYYY-MM-DD")) 至 \(timeFormattingWithStamp(timeStamp: termEndTime, format: "YYYY-MM-DD"))"
                }else{
                    self.timeLabel.text = ""
                }
            }else{
                self.timeLabel.text = ""
            }
        }else{
            self.timeLabel.text = ""
        }
        
    }
    
    //会员卡
    func updateWithMemberCard(memberCard:JSON){
        
        self.backgroundImageView.image = UIImage(named:"hykbj_kb")
        
        let typeName:String? = memberCard["typeName"].string
        let beginTime:Int? = memberCard["beginTime"].int
        let expTime:Int? = memberCard["expTime"].int
        let sort:Int? = memberCard["sort"].int
        
        if let typeName = typeName{
            self.nameLabel.text = typeName
        }else{
            self.nameLabel.text = "暂无会员卡名字"
        }
        
        if let _ = beginTime, let expTime = expTime{
            self.timeLabel.text = "有效期 至 \(timeFormattingWithStamp(timeStamp: expTime, format: "YYYY-MM-DD"))"
        }else{
            self.timeLabel.text = "有效期 无限期"
        }
        
        if let sort = sort{
            self.cardView.backgroundColor = UIColor.colorWithHexString(hex: Config.vipBackgroundColor(sort: sort))
        }else{
            self.cardView.backgroundColor = UIColor.colorWithHexString(hex: Config.vipBackgroundColor(sort: 0))
        }
        
    }
    
}
