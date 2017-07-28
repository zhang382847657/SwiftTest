//
//  BMMeViewController.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/7/26.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit

class BMMeViewController: UIViewController {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var couponNumberLabel: UILabel!  //优惠券数量
    @IBOutlet weak var serviceAuntNumberLabel: UILabel!  //服务过的阿姨数量
    @IBOutlet weak var myInfoView: InforCellView!  //我的信息
    @IBOutlet weak var inviteFriendView: InforCellView!  //邀请好友注册
    @IBOutlet weak var feedBackView: InforCellView!  //意见反馈
    @IBOutlet weak var checkUpdateView: InforCellView!  //检查更新
 
    @IBOutlet weak var phoneLabel: UILabel! //手机号
    @IBOutlet weak var loginBtn: UIButton! //快速登录
    
    @IBOutlet weak var headBackgroundView: UIView! //头像背景视图
    @IBOutlet weak var headBtn: UIButton! //头像按钮
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false //这样可以防止scrollview没有置顶
        
        self.contentView.backgroundColor = UIColor.colorWithHexString(hex: BMBacgroundColor)
        self.headBackgroundView.layer.cornerRadius = self.headBackgroundView.bounds.size.height/2.0
        self.headBackgroundView.isHidden = true
        self.phoneLabel.isHidden = true
        self.loginBtn.addBorder(color: UIColor.white, size: BMBorderSize, borderTypes: [BorderType.top.rawValue,BorderType.left.rawValue,BorderType.right.rawValue,BorderType.bottom.rawValue])
        
        self.inviteFriendView.titleLabel.text = "邀请好友注册"
        self.feedBackView.titleLabel.text = "意见反馈"
        self.checkUpdateView.titleLabel.text = "检查更新"

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)  //隐藏导航栏
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true) //显示导航栏
    }
    
    
    //快速登录
    @IBAction func loginBtn(_ sender: UIButton) {
        
        let loginVC:BMLoginViewController = BMLoginViewController(nibName: "BMLoginViewController", bundle: nil)
        self.navigationController?.present(loginVC, animated: true, completion: { 
            
            
        })
    }
    
    //退出登录
    @IBAction func exitClick(_ sender: UIButton) {
    }
    


}
