//
//  BMEditCommonAddressViewController.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/9/2.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit
import SwiftyJSON

class BMEditCommonAddressViewController: UIViewController {

    @IBOutlet weak var nameView: InputView!  //姓名
    @IBOutlet weak var phoneView: InputView! //手机号
    @IBOutlet weak var addressView: InforPickerView! //地址
    @IBOutlet weak var houseNumberView: InputView! //门牌号
    var commonAddress:JSON?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nameView.titile = "姓名"
        self.phoneView.titile = "手机号"
        self.addressView.titile = "地址"
        self.houseNumberView.titile = "门牌号"
        
        self.nameView.addBorderLayer(color: UIColor(hex:BMBorderColor), size: BMBorderSize, boderType: BorderType.bottom)
        self.phoneView.addBorderLayer(color: UIColor(hex:BMBorderColor), size: BMBorderSize, boderType: BorderType.bottom)
        self.addressView.addBorderLayer(color: UIColor(hex:BMBorderColor), size: BMBorderSize, boderType: BorderType.bottom)
        
        self.updateContent() //更新内容数据
        
    }
    
    
    //MARK: 编辑常用地址初始化
    //parmas: commonAddress 地址信息
    init(withCommonAddress commonAddress:JSON) {
        
        super.init(nibName: nil, bundle: nil)
        self.title = "编辑常用地址"
        self.commonAddress = commonAddress
    
    }
    
    //MARK: 新增常用地址初始化
    init(){
        super.init(nibName: nil, bundle: nil)
        self.title = "添加常用地址"
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: 更新内容数据
    private func updateContent(){
        
        if let commonAddress = self.commonAddress{
            
            let phone:String? = commonAddress["phone"].string
            let name:String? = commonAddress["name"].string
            let province:String? = commonAddress["province"].string
            let city:String? = commonAddress["city"].string
            let district:String? = commonAddress["district"].string
            let address:String? = commonAddress["address"].string
            let houseNumber:String? = commonAddress["houseNumber"].string
            
            if let phone = phone{
                self.phoneView.valueText = phone
            }
            
            if let name = name{
                self.nameView.valueText = name
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
            
            if finalAddress != "" {
                self.addressView.valueText = finalAddress
            }
            
            if let houseNumber = houseNumber{
                self.houseNumberView.valueText = houseNumber
            }
        }
        
    }

    //保存点击事件
    @IBAction func saveClick(_ sender: UIButton) {
        
        
    }
}
