//
//  BMStoreCardBuyCell.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/7/22.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit
import SwiftyJSON

typealias GiftEquityClickClosure = () -> Void

class BMStoreCardBuyCell: UICollectionViewCell {

    @IBOutlet weak var nameLable: UILabel!  //储值卡名称
    @IBOutlet weak var namePriceLabel: UILabel! //面值
    @IBOutlet weak var dataLabel: UILabel!   //有效期
    @IBOutlet weak var priceLabel: UILabel!  //现价
    @IBOutlet weak var primeCostLabel: UILabel! //原价
    
    var giftEquityClickClosure: GiftEquityClickClosure? //赠送权益点击回调
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.layer.cornerRadius = 10
        self.contentView.clipsToBounds = true
        // Initialization code
    }
    
    func uploadUIWithStoreCard (storeCard:JSON){
        
        let name = storeCard["kindName"].string  //储值卡名称
        let namePrice = storeCard["parvalue"].float //面值
        let termState = storeCard["termState"].int
        let vaildDays = storeCard["vaildDays"].int
        let termStartTime = storeCard["termStartTime"].int
        let termEndTime = storeCard["termEndTime"].int
        let price = storeCard["price"].float //现价
        let parvalue = storeCard["parvalue"].float //原价
        
        if let name = name{
            nameLable.text = name
        }else{
            nameLable.text = "暂无储值卡名称"
        }
        
        if let namePrice = namePrice{
            namePriceLabel.text = "面值￥\(namePrice)"
        }else{
            namePriceLabel.text = "暂无面值价格"
        }
        
        if let termState = termState{
            
            switch termState {
            case 0:
                dataLabel.text = "有效期 无限期"
            case 1:
                dataLabel.text = "有效期 \(vaildDays!)天"
            case 2:
                dataLabel.text = "有效期 无限期"
            default:
                dataLabel.text = "有效期 \(timeFormattingWithStamp(timeStamp: String(termStartTime!), format: "YYYY-MM-DD")) 至 \(timeFormattingWithStamp(timeStamp: String(termEndTime!), format: "YYYY-MM-DD"))"
            }
        }else{
            dataLabel.text = "有效期有误"
        }
        
        
        if let price = price{
            priceLabel.text = "￥\(price)"
        }else {
            priceLabel.text = "暂无价格"
        }
        
        if let parvalue = parvalue{
            
            // TODO:  删除线效果没有弄出来
            let lineStr = NSAttributedString(string: "原价￥\(parvalue)",attributes: [NSStrikethroughStyleAttributeName:NSUnderlineStyle.styleSingle.rawValue])
            
            primeCostLabel.attributedText = lineStr
        }else{
            primeCostLabel.text = "暂无原价"
        }
        
        
    }

    
    //赠送权益点击事件
    @IBAction func giftEquityClick(_ sender: UIButton) {
        if let _ = self.giftEquityClickClosure {
            self.giftEquityClickClosure!()
        }
    }
    
}
