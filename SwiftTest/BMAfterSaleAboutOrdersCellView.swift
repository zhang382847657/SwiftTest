//
//  BMAfterSaleAboutOrdersCellView.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/8/24.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit
import SwiftyJSON

class BMAfterSaleAboutOrdersCellView: UIView {

    @IBOutlet weak var circleView: UIView! //圆点视图
    @IBOutlet weak var lineView: UIView! //竖线视图
    @IBOutlet weak var serviceNoLabel: UILabel! //订单编号
    @IBOutlet weak var timeLabel: UILabel! //时间
    @IBOutlet weak var bottomView: UIView! //底部横线
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.circleView.layer.cornerRadius = self.circleView.bounds.size.width/2.0
    }
    
    
    func updateWithAboutOrder(order:JSON){
        
        let tradeNo:String? = order["tradeNo"].string
        let ctime:Int? = order["ctime"].int
        
        if let tradeNo = tradeNo{
            self.serviceNoLabel.text = "订单编号：\(tradeNo)"
        }else{
            self.serviceNoLabel.text = "订单编号：--"
        }
        
        if let ctime = ctime{
            self.timeLabel.text = timeFormattingWithStamp(timeStamp: ctime, format: "YYYY-MM-DD HH:mm:ss")
        }else{
            self.timeLabel.text = "--"
        }
        
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.bottomView.addBorderLayer(color: UIColor.colorWithHexString(hex: BMBorderColor), size: BMBorderSize, boderType: BorderType.bottom)
    }

}
