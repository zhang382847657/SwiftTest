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
            
            let dataSource = [["key":"男","value":0],["key":"女","value":1]]
            let pickerView:BMPickerView = BMPickerView(singleColData: dataSource, defaultSelectedValue: ["key":"女","value":1], doneAction: { (result:Dictionary<String, Any>) in
                
                let sexValue:String = result["key"] as! String
                self.sexView.valueText = sexValue
                
            })
            
            pickerView.show()
        }
        
        
        self.birthdayView.clickClosure = { //生日视图点击回调
            ()->Void in
            
            let datePicker:BMPickerView = BMPickerView(dateWithMinimumDate: "1900-01-01", maximumDate: nil, datePickerMode: .date, dateFormatter: "YYYY-MM-DD", defaultSelectedValue: self.birthdayView.valueText, doneAction: { (result:String) in
                
                self.birthdayView.valueText = result
            })
            datePicker.show()
            
        }
        
//        self.birthdayView.clickClosure = { //生日视图点击回调
//            ()->Void in
//            
//            let dataSource = [[["key":"男","value":0],["key":"女","value":1]],[["key":"大一","value":0],["key":"大二","value":1],["key":"大三","value":2]],[["key":"高中","value":0],["key":"小学","value":1]]]
//            let pickerView:BMPickerView = BMPickerView(multipleColData: dataSource, defaultSelectedValue: [["key":"女","value":1],["key":"大三","value":2],["key":"高中","value":0]], doneAction: { (result:Array<Dictionary<String, Any>>) in
//                
//                let oneString:String = result[0]["key"] as! String
//                let twoString:String = result[1]["key"] as! String
//                let threeString:String = result[2]["key"] as! String
//                
//                
//                let birthdayValue:String = "\(oneString)\(twoString)\(threeString)"
//                self.birthdayView.valueText = birthdayValue
//                
//            })
//            pickerView.show()
//            
//        }
        
        
    }
    
    
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.nameView.addBorderLayer(color: UIColor(hex:BMBorderColor), size: BMBorderSize, boderType: BorderType.bottom)
        self.phoneView.addBorderLayer(color: UIColor(hex:BMBorderColor), size: BMBorderSize, boderType: BorderType.bottom)
        self.sexView.addBorderLayer(color: UIColor(hex:BMBorderColor), size: BMBorderSize, boderType: BorderType.bottom)
    }

}
