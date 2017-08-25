//
//  BMOrderPriceView.swift
//  SwiftTest
//  订单详情——价格视图
//  Created by 张琳 on 2017/8/25.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit

class BMOrderPriceView: UIView {

    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.addBorderLayer(color: UIColor.colorWithHexString(hex: BMBorderColor), size: BMBorderSize, boderType: BorderType.top)
    }

}
