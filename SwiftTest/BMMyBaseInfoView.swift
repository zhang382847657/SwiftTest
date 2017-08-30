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
    @IBOutlet weak var sexView: InforPickerView!  //性别视图
    @IBOutlet weak var birthdayView: InforPickerView!  //生日视图
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.nameView.titile = "姓名"
        self.nameView.valueText = nil
        self.nameView.placeholder = "请输入姓名"
        
        self.phoneView.titile = "手机号"
        self.phoneView.valueText = "15037104407"
        self.phoneView.placeholder = "请输入手机号"
        
        self.sexView.titile = "性别"
        self.sexView.valueText = "女"
        
        self.birthdayView.titile = "生日"
        self.birthdayView.valueText = "2014-07-08"
        
        
        self.sexView.clickClosure = { //性别视图点击回调
            ()->Void in
            dPrint(item: "hahahahahahaahah")
        }
        
        self.birthdayView.clickClosure = { //生日视图点击回调
            ()->Void in
            dPrint(item: "hahahahahahaahah")
        }
        
        
    }
    
    
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.nameView.addBorderLayer(color: UIColor(hex:BMBorderColor), size: BMBorderSize, boderType: BorderType.bottom)
        self.phoneView.addBorderLayer(color: UIColor(hex:BMBorderColor), size: BMBorderSize, boderType: BorderType.bottom)
        self.sexView.addBorderLayer(color: UIColor(hex:BMBorderColor), size: BMBorderSize, boderType: BorderType.bottom)
    }

}
