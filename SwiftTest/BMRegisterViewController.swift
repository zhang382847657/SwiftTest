//
//  BMRegisterViewController.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/7/31.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit

class BMRegisterViewController: UIViewController {

    @IBOutlet weak var headImageBtn: UIButton!  //头像按钮
    @IBOutlet weak var phoneTextField: UITextField!  //手机号
    @IBOutlet weak var codeTextField: UITextField!   //验证码
    @IBOutlet weak var inviteCodeTextField: UITextField!  //邀请码
    @IBOutlet weak var registerBtn: UIButton!  //注册按钮
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.headImageBtn.layer.masksToBounds = true
        self.headImageBtn.layer.cornerRadius = self.headImageBtn.bounds.size.height/2.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    //头像点击事件
    @IBAction func headImageClick(_ sender: UIButton) {
    }
    
    //返回点击事件
    @IBAction func backClick(_ sender: UIButton) {
    }
    
    
    //注册点击事件
    @IBAction func registerClick(_ sender: UIButton) {
    }
    
    //立即登录点击事件
    @IBAction func loginClick(_ sender: UIButton) {
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
