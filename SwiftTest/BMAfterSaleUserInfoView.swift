//
//  BMAfterSaleUserInfoView.swift
//  SwiftTest
//  售后单——雇主信息
//  Created by 张琳 on 2017/8/24.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit
import SwiftyJSON

class BMAfterSaleUserInfoView: UIView {

    @IBOutlet weak var nameLabel: UILabel!  //雇主姓名
    @IBOutlet weak var phoneLabel: UILabel! //雇主手机号
    @IBOutlet weak var addressLabel: UILabel!  //雇主地址
    
    
    
    func updateWithAfterSale(afterSale:JSON){
        let cuserName:String? = afterSale["cuserName"].string
        let cuserPhone:String? = afterSale["cuserPhone"].string
        let serviceProvince:String? = afterSale["serviceProvince"].string
        let serviceCity:String? = afterSale["serviceCity"].string
        let serviceDistrict:String? = afterSale["serviceDistrict"].string
        let serviceAddress:String? = afterSale["serviceAddress"].string
        
        if let cuserName = cuserName{
            self.nameLabel.text = cuserName
        }else{
            self.nameLabel.text = "--"
        }
        
        if let cuserPhone = cuserPhone{
            self.phoneLabel.text = cuserPhone
        }else{
            self.phoneLabel.text = "--"
        }
        
        var address:String = "--"
        if let serviceProvince = serviceProvince{ //省
            address = serviceProvince
        }
        if let serviceCity = serviceCity{ //市
            address += serviceCity
        }
        if let serviceDistrict = serviceDistrict{  //区
            address += serviceDistrict
        }
        if let serviceAddress = serviceAddress{  //街道
            address += serviceAddress
        }
        self.addressLabel.text = "地址：\(address)"
    }

}
