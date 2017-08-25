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

    
    @IBOutlet weak var circleImageView: UIImageView!
    @IBOutlet weak var lineView: UIView! //竖线视图
    @IBOutlet weak var serviceNoLabel: UILabel! //订单编号
    @IBOutlet weak var timeLabel: UILabel! //时间
    @IBOutlet weak var bottomView: UIView! //底部横线
    var isShowBottomLine:Bool = false //是否显示底部横线
    
    
    
    /**
     *  更新视图内容
     *  @params orders 相关订单数组
     *  @params index  当前订单所在数组下标
     */
    func updateWithAboutOrder(orders:Array<JSON>, index:Int){
        
        let tradeNo:String? = orders[index]["tradeNo"].string
        let ctime:Int? = orders[index]["ctime"].int
        
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
        
        var color:UIColor = UIColor.colorWithHexString(hex: BMThemeColor) //最终显示的颜色
        var isHidden:Bool = true //竖线是否显示
        var circleImageString:String = "order_circle_blue" //小圆点图片
        
        if index == 0{
            isHidden = orders.count == 1 ? true : false
            self.isShowBottomLine = orders.count == 1 ? false : true
            color = UIColor.colorWithHexString(hex: BMThemeColor)
            circleImageString = "order_circle_blue"
        }else{
            isHidden = index == orders.count - 1 ? true : false
            self.isShowBottomLine = index == orders.count - 1 ? false : true
            color = UIColor.colorWithHexString(hex: BMSmallTitleColor)
            circleImageString = "order_circle_gray"
        }
        
        self.serviceNoLabel.textColor = color
        self.timeLabel.textColor = color
        self.circleImageView.image = UIImage(named: circleImageString)
        self.lineView.isHidden = isHidden
        
    }
    
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if self.isShowBottomLine {
            self.bottomView.addBorderLayer(color: UIColor.colorWithHexString(hex: BMBorderColor), size: BMBorderSize, boderType: BorderType.top)
        }
        
    }

}
