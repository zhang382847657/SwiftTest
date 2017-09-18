//
//  BMCommonAddressInfoCell.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/9/2.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit
import SwiftyJSON

class BMCommonAddressInfoCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel! //姓名
    @IBOutlet weak var phoneLabel: UILabel! //手机号
    @IBOutlet weak var addressLabel: UILabel! //地址
    
    @IBOutlet weak var leftView: UIView! //左侧内容视图
    @IBOutlet weak var rightView: UIView! //右侧编辑视图
    
    @IBOutlet weak var rightWidthConstraint: NSLayoutConstraint! //右侧编辑视图宽度约束
    @IBOutlet weak var leftLeadingConstraint: NSLayoutConstraint! //左侧视图距离左侧距离约束
    
    
    typealias EditClosure = () -> Void //编辑闭包类型
    typealias DeleteClosure = () -> Void //删除闭包类型
    var editClosure: EditClosure! //声明编辑闭包属性
    var deleteClosure: DeleteClosure! //声明删除闭包属性
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.rightWidthConstraint.constant = 0 //右侧视图先隐藏掉
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    //更新内容视图
    func updateWithAddress(address:JSON){
        let phone:String? = address["phone"].string
        let name:String? = address["name"].string
        let province:String? = address["province"].string
        let city:String? = address["city"].string
        let district:String? = address["district"].string
        let address:String? = address["address"].string
        
        if let phone = phone{
            self.phoneLabel.text = phone
        }else{
            self.phoneLabel.text = "暂无手机号"
        }
        
        if let name = name{
            self.nameLabel.text = name
        }else{
            self.nameLabel.text = "--"
        }
        
        var finalAddress:String = ""
        if let province = province{
            finalAddress = province
        }
        if let city = city{
            finalAddress = finalAddress + city
        }
        if let district = district{
            finalAddress = finalAddress + district
        }
        if let address = address{
            finalAddress = finalAddress + address
        }
        
        if finalAddress == "" {
            finalAddress = "--"
        }
        
        self.addressLabel.text = finalAddress
    }
    
    //删除点击事件
    @IBAction func deleteClick(_ sender: UIButton) {
        if let deleteClosure = self.deleteClosure {
            deleteClosure()
        }
    }
    
    //编辑点击事件
    @IBAction func editClick(_ sender: UIButton) {
        if let editClosure = self.editClosure {
            editClosure()
        }
    }
}
