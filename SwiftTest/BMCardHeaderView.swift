//
//  BMCardHeaderView.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/8/10.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit
import SwiftyJSON

class BMCardHeaderView: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var bottomTitleLabel: UILabel!
    @IBOutlet weak var bottomContentLabel: UILabel!
    @IBOutlet weak var markImageView: UIImageView! //水印图片
    @IBOutlet weak var topView: UIView! //背景视图
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 5
    }
    
    
    /*
     * 套餐卡
     * @param card 套餐卡
     * @param expireDescription 有效期
     */
    func updateUIWithComboCard(card:JSON, expireDescription:String){
        
        let cardName:String? = card["name"].string
        let cardItemBOs:Array? = card["cardItemBOs"].array
        
        
        if let cardName = cardName{
            self.titleLabel.text = cardName
        }else{
            self.titleLabel.text = "暂无套餐卡名字"
        }
        
        if let cardItemBOs = cardItemBOs{
            
            let packageCardItem:JSON = cardItemBOs[0]
            let unitName:String? = packageCardItem["unitName"].string
            let times:Int? = packageCardItem["times"].int
            let usedTimes:Int? = packageCardItem["usedTimes"].int
            
            if let unitName = unitName{
                
                if unitName == "次"{  //有规格商品
                    self.contentLabel.text = "\(packageCardItem["name"].string!)\(packageCardItem["goodsName"].string!)"
                }else{  //无规格商品
                    self.contentLabel.text = "\(packageCardItem["name"].string!)\(packageCardItem["itemNum"].int!)\(packageCardItem["unitName"].string!)"
                }
                
            }else{
                self.contentLabel.text = "--"
            }
            
            if let times = times{
                self.countLabel.text = "\(times)次"
                
                if let usedTimes = usedTimes{
                    self.bottomContentLabel.text = "\(times-usedTimes)次"
                }else{
                    self.bottomContentLabel.text = "--次"
                }
                
            }else{
                self.countLabel.text = "--次"
                self.bottomContentLabel.text = "--次"
            }
            
            
            
            
            
        }else{
            self.contentLabel.text = "--"
        }
        
        
        
        self.timeLabel.text = expireDescription
        self.bottomTitleLabel.text = "剩余次数"
        self.topView.backgroundColor = UIColor.colorWithHexString(hex: BMThemeColor)
        self.markImageView.image = UIImage(named: "package_card_detail_watermark")
        
        
        
    }
    
    /*
     * 储值卡
     * @param card 储值卡
     * @param expireDescription 有效期
     */
    func updateUIWithStoreCard(card:JSON, expireDescription:String){
        
        let kindName:String? = card["kindName"].string
        let parvalue:Float? = card["parvalue"].float
        let remainder:Float? = card["remainder"].float
        
        
        if let kindName = kindName{
            self.titleLabel.text = kindName
        }else{
            self.titleLabel.text = "暂无储值卡名字"
        }
        
        if let parvalue = parvalue{
            self.contentLabel.text = "面值 ￥\(parvalue)"
        }else{
            self.contentLabel.text = "暂无面值"
        }
        
        if let remainder = remainder{
            self.bottomContentLabel.text = "￥\(remainder)"
        }
        
        self.countLabel.text = ""
        self.timeLabel.text = expireDescription
        self.bottomTitleLabel.text = "剩余金额"
        self.topView.backgroundColor = UIColor.colorWithHexString(hex: BMThemeColorOrange)
        self.markImageView.image = UIImage(named: "store_card_detail_watermark")
    }

}
