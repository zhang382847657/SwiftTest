//
//  BMMyBaseInfoView.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/8/28.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit

class BMMyBaseInfoView: UIView {

    @IBOutlet weak var nameView: InputView!  //姓名视图
    @IBOutlet weak var phoneView: InputView!  //手机号视图
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.nameView.titile = "姓名"
        self.nameView.valueText = nil
        self.nameView.placeholder = "请输入姓名"
        
        
        self.phoneView.titile = "手机号"
        self.phoneView.valueText = "15037104407"
        self.phoneView.placeholder = "请输入手机号"
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.nameView.addBorderLayer(color: UIColor.colorWithHexString(hex: BMBorderColor), size: BMBorderSize, boderType: BorderType.bottom)
    }

}
