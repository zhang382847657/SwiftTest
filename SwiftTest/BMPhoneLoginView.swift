//
//  BMPhoneLoginView.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/7/31.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit

class BMPhoneLoginView: UIView {

    @IBOutlet weak var loginBtn: UIButton! //登录按钮
    @IBOutlet weak var phoneTextField: UITextField!  //手机
    @IBOutlet weak var codeTextField: UITextField!  //验证码
    @IBOutlet weak var sendCodeBtn: UIButton!  //发送验证码
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        self.loginBtn.addBorder(color: UIColor.white, size: BMBorderSize, borderTypes: [BorderType.top.rawValue,BorderType.left.rawValue,BorderType.right.rawValue,BorderType.bottom.rawValue])
        
        
        self.sendCodeBtn.addBorder(color: UIColor.white, size: BMBorderSize, borderTypes: [BorderType.top.rawValue,BorderType.left.rawValue,BorderType.right.rawValue,BorderType.bottom.rawValue])

    }
    
    
    //密码登录
    @IBAction func pwdLoginClick(_ sender: UIButton) {
        dPrint(item: "密码登录")
    }

}
