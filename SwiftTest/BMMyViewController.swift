//
//  BMMyViewController.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/7/31.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit

class BMMyViewController: UIViewController {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var couponNumberLabel: UILabel!  //优惠券数量
    @IBOutlet weak var serviceAuntNumberLabel: UILabel!  //服务过的阿姨数量
    @IBOutlet weak var myInfoView: InforCellView!  //我的信息
    @IBOutlet weak var inviteFriendView: InforCellView!  //邀请好友注册
    @IBOutlet weak var feedBackView: InforCellView!  //意见反馈
    @IBOutlet weak var checkUpdateView: InforCellView!  //检查更新
    
    @IBOutlet weak var phoneLabel: UILabel! //手机号
    
    @IBOutlet weak var headBackgroundView: UIView! //头像背景视图
    @IBOutlet weak var headBtn: UIButton! //头像按钮

    @IBOutlet weak var loginBtn: UIButton! //登录按钮
    
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
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)  //隐藏导航栏
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true) //显示导航栏
    }
    
    //快速登录点击事件
    @IBAction func loginClick(_ sender: UIButton) {
        
        let loginVC:BMLoginViewController = BMLoginViewController(nibName: "BMLoginViewController", bundle: nil)
        self.navigationController?.present(loginVC, animated: true, completion: {
            
            
        })
    }
    
    
    //快速登录点击事件
    @IBAction func exitClick(_ sender: UIButton) {
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
