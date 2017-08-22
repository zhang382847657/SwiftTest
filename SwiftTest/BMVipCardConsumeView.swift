//
//  BMVipCardConsumeView.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/8/21.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit
import SwiftyJSON

class BMVipCardConsumeView: UIView {

    @IBOutlet weak var nameLabel: UIButton!  //会员卡名字
    @IBOutlet weak var subTitleLabel: UILabel!  //副标题
 
    @IBOutlet weak var leftTitleLabel: UILabel!  //左侧支付金额标题
    @IBOutlet weak var leftPriceLable: UILabel!  //左侧支付金额

    @IBOutlet weak var rightTitleLabel: UILabel!  //右侧购买标题
    @IBOutlet weak var rightPriceLabel: UILabel!  //右侧购买金额
    
    
    /**
     *   更新消费视图
     *   card 当前滚动到的会员卡
     *   myCard 我目前的会员卡
     *   payCash 总消费金额
     *   storeCash  总储值卡金额
     */
    func updateWithCard(card:JSON , myCard:JSON ,payCash:Float, storeCash:Float){
        
        let name:String = myCard["typeName"].stringValue //我的会员卡名字
        let cardSort:Int? = card["sort"].int  //当前滚动到的会员卡的等级
        let currentSort:Int? = myCard["sort"].int  //我目前的会员卡等级
        let cardPayCash:Float? = card["payCash"].float  //当前滚动到的会员卡消费金额
        let cardStoreCash:Float? = card["storeCash"].float  //当前滚动到的会员卡储值金额
        
        self.nameLabel.setTitle(name, for: .normal)
        
        
        if let cardSort = cardSort, let currentSort = currentSort{
            
            if cardSort <= currentSort{
                self.leftTitleLabel.text = "累积支付金额"
                self.rightTitleLabel.text = "累积购买储值卡"
                self.leftPriceLable.text = "￥\(payCash)"
                self.rightPriceLabel.text = "￥\(storeCash)"
                self.subTitleLabel.text = "恭喜，您已是尊贵的\(name)会员"
            }else{
                self.leftTitleLabel.text = "继续支付金额"
                self.rightTitleLabel.text = "继续购买储值卡"
                
                if let cardPayCash = cardPayCash{
                    self.leftPriceLable.text = "￥\(cardPayCash-payCash)"
                }else{
                    self.leftPriceLable.text = "￥0"
                }
                
                if let cardStoreCash = cardStoreCash{
                    self.rightPriceLabel.text = "￥\(cardStoreCash-storeCash)"
                }else{
                    self.rightPriceLabel.text = "￥0"
                }
                
                self.subTitleLabel.text = "您可以通过以下方式获得"
            }
            
        }else{
            
            self.leftTitleLabel.text = "--"
            self.rightTitleLabel.text = "--"
            self.leftPriceLable.text = "￥0"
            self.rightPriceLabel.text = "￥0"
            self.subTitleLabel.text = "--"
        }
        
    }
}
