//
//  BMOrderPayRecordView.swift
//  SwiftTest
//  订单详情——支付记录
//  Created by 张琳 on 2017/8/25.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit

class BMOrderPayRecordView: UIView {

    @IBOutlet weak var titleLabel: UILabel!  //标题
    @IBOutlet weak var payRecordLabel: UILabel!  //支付记录
    @IBOutlet weak var payPriceLabel: UILabel!  //需支付价格
    @IBOutlet weak var payButton: UIButton!  //立即支付按钮
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.payButton.layer.cornerRadius = 3
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.titleLabel.addBorderLayer(color: UIColor.colorWithHexString(hex: BMBorderColor), size: BMBorderSize, boderType: BorderType.bottom)
    }

}
