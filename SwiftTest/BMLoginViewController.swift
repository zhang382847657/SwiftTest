//
//  BMLoginViewController.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/7/28.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit

class BMLoginViewController: UIViewController {
    
    @IBOutlet weak var logoImageView: UIImageView! //家政公司图标
    @IBOutlet weak var companyNameLabel: UILabel!  //家政公司名称
    
    
    @IBOutlet weak var contentScrollView: UIScrollView!
    var contentView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.logoImageView.layer.masksToBounds = true
        self.logoImageView.layer.cornerRadius = logoImageView.bounds.size.height/2.0
        
        
        self.loadUI()  //加载UI
        self.loadAppLogo()  //加载加载公司LOGO
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //加载UI
    func loadUI(){
        
        ///////////内容视图///////////////
        self.contentView = UIView(frame: CGRect.zero)
        self.contentScrollView.addSubview(contentView)
        self.contentView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.contentScrollView)
            make.height.equalTo(self.contentScrollView.snp.height)
            make.width.greaterThanOrEqualTo(0)
        }
        
        ////////////手机登录///////////////
        let phoneLoginView:BMPhoneLoginView = UIView.loadViewFromNib(nibName: "BMPhoneLoginView") as! BMPhoneLoginView
        self.contentView.addSubview(phoneLoginView)
        phoneLoginView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self.contentView)
            make.left.equalTo(self.contentView)
            make.width.equalTo(self.contentScrollView.bounds.size)
        }
        
        ////////////密码登录///////////////
        let pwdLoginView:BMPhoneLoginView = UIView.loadViewFromNib(nibName: "BMPhoneLoginView") as! BMPhoneLoginView
        self.contentView.addSubview(pwdLoginView)
        
        pwdLoginView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self.contentView)
            make.left.equalTo(phoneLoginView.snp.right)
            make.right.equalTo(self.contentView.snp.right)
            make.width.equalTo(self.contentScrollView.bounds.size)
        }
        
    }
    
    //加载App图标
    func loadAppLogo(){
        
        
        let url = "\(BMHOST)/custom/share?duserCode=\(BMDUSERCODE)"
        let params = ["":""]
        NetworkRequest.sharedInstance.getRequest(urlString: url , params: params , success: { value in
            let icon: String? = value["icon"].string
            let company: String? = value["company"].string
            
        
            if let icon = icon{
                self.logoImageView.af_setImage(withURL: URL(string: icon)!, placeholderImage: UIImage(named: "pic_load")!)
            }else{
                self.logoImageView.image = UIImage(named: "pic_error")
            }
            
            if let company = company{
                self.companyNameLabel.text = company
            }else{
                self.companyNameLabel.text = "暂无公司名称"
            }
            
            
        }) { error in
            
        }
    }
    
    
    //立即注册点击事件
    @IBAction func registerClick(_ sender: UIButton) {
        let vc:BMRegisterViewController = BMRegisterViewController(nibName: "BMRegisterViewController", bundle: nil)
        self.present(vc, animated: true, completion: nil)
    }
    
    //返回点击事件
    @IBAction func backClick(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
        
    }

    

}
