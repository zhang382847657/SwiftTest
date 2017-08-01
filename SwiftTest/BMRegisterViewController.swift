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
    @IBOutlet weak var codeView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //对UI进行设置
        self.loadUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //对UI进行设置
    func loadUI(){
        
        ////////////设置头像按钮圆角以及边框////////
        self.headImageBtn.layer.masksToBounds = true
        self.headImageBtn.layer.cornerRadius = self.headImageBtn.bounds.size.height/2.0
        self.headImageBtn.layer.borderWidth = BMBorderSize
        self.headImageBtn.layer.borderColor = UIColor.white.cgColor
        
        
        //////设置TextField的placeholder为白色////////
        self.phoneTextField.attributedPlaceholder = NSAttributedString.init(string:"请输入手机号", attributes: [NSFontAttributeName:UIFont.systemFont(ofSize:BMTitleFontSize),NSForegroundColorAttributeName:UIColor.white])
        
        self.codeTextField.attributedPlaceholder = NSAttributedString.init(string:"请输入验证码", attributes: [NSFontAttributeName:UIFont.systemFont(ofSize:BMTitleFontSize),NSForegroundColorAttributeName:UIColor.white])
        
        self.inviteCodeTextField.attributedPlaceholder = NSAttributedString.init(string:"请输入邀请码", attributes: [NSFontAttributeName:UIFont.systemFont(ofSize:BMTitleFontSize),NSForegroundColorAttributeName:UIColor.white])
        
        
        ///////////给视图添加下边框////////////
        self.phoneTextField.addBorderLayer(color: UIColor.white, size: BMBorderSize, boderType: .bottom)
        
        self.codeView.addBorderLayer(color: UIColor.white, size: BMBorderSize, boderType: .bottom)
        
        self.inviteCodeTextField.addBorderLayer(color: UIColor.white, size: BMBorderSize, boderType: .bottom)
        
        self.registerBtn.layer.borderColor = UIColor.white.cgColor
        self.registerBtn.layer.borderWidth = BMBorderSize
    }
    
   
    //头像点击事件
    @IBAction func headImageClick(_ sender: UIButton) {
    }
    
    //返回点击事件
    @IBAction func backClick(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    //注册点击事件
    @IBAction func registerClick(_ sender: UIButton) {
    }
    
    //立即登录点击事件
    @IBAction func loginClick(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
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
