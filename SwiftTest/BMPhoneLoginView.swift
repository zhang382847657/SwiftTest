//
//  BMPhoneLoginView.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/7/31.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit
import SwiftyUserDefaults
import PKHUD

class BMPhoneLoginView: UIView {

    @IBOutlet weak var loginBtn: UIButton! //登录按钮
    @IBOutlet weak var phoneTextField: UITextField!  //手机
    @IBOutlet weak var codeTextField: UITextField!  //验证码
    @IBOutlet weak var sendCodeBtn: UIButton!  //发送验证码
    @IBOutlet weak var codeView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        self.loginBtn.addBorder(color: UIColor.white, size: BMBorderSize, borderTypes: [BorderType.top.rawValue,BorderType.left.rawValue,BorderType.right.rawValue,BorderType.bottom.rawValue])
        
        
        self.sendCodeBtn.addBorder(color: UIColor.white, size: BMBorderSize, borderTypes: [BorderType.top.rawValue,BorderType.left.rawValue,BorderType.right.rawValue,BorderType.bottom.rawValue])
        
        self.phoneTextField.attributedPlaceholder = NSAttributedString.init(string:"请输入手机号", attributes: [NSFontAttributeName:UIFont.systemFont(ofSize:BMTitleFontSize),NSForegroundColorAttributeName:UIColor.white])
        
        self.codeTextField.attributedPlaceholder = NSAttributedString.init(string:"请输入验证码", attributes: [NSFontAttributeName:UIFont.systemFont(ofSize:BMTitleFontSize),NSForegroundColorAttributeName:UIColor.white])
        
        self.phoneTextField.addBorderLayer(color: UIColor.white, size: BMBorderSize, boderType: .bottom)
        
        self.codeView.addBorderLayer(color: UIColor.white, size: BMBorderSize, boderType: .bottom)
        

    }
    

    //登录点击事件
    @IBAction func loginClick(_ sender: UIButton) {
        
        let loginViewController:BMLoginViewController = self.getViewController() as! BMLoginViewController
        
        guard self.phoneTextField.text == nil else {
            HUD.flash(.label("请输入手机号"), delay: 1.0)
            return
        }
        
        if Validate.phoneNum(self.phoneTextField.text!).isRight == false {
            HUD.flash(.label("请输入正确的手机号"), delay: 1.0)
            return
        }
        
        
        
    }
    
    //密码登录
    @IBAction func pwdLoginClick(_ sender: UIButton) {
        dPrint(item: "密码登录")
    }

}
