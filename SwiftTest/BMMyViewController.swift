//
//  BMMyViewController.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/7/31.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit
import PKHUD

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
    
    var url:String? = nil //版本升级的url地址
    
    var alertController:UIAlertController! //提示框
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.automaticallyAdjustsScrollViewInsets = false //这样可以防止scrollview没有置顶
        self.initUI()
       
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
    
    
    private func initUI(){
        
        self.contentView.backgroundColor = UIColor.colorWithHexString(hex: BMBacgroundColor)
        self.headBackgroundView.layer.cornerRadius = self.headBackgroundView.bounds.size.height/2.0
        self.headBackgroundView.isHidden = true
        self.phoneLabel.isHidden = true
        self.loginBtn.addBorder(color: UIColor.white, size: BMBorderSize, borderTypes: [BorderType.top.rawValue,BorderType.left.rawValue,BorderType.right.rawValue,BorderType.bottom.rawValue])
        
        
        ///////////设置提示框////////////////////
        self.alertController = UIAlertController(title: "有新版本，请升级", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        self.alertController.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        self.alertController.addAction(UIAlertAction(title: "确定", style: .default, handler: { (action) in
            
            if let url = self.url{
                //根据iOS系统版本，分别处理
                if #available(iOS 10, *) {
                    UIApplication.shared.open(URL(string: url)!, options: [:],
                                              completionHandler: {
                                                (success) in
                    })
                } else {
                    UIApplication.shared.openURL(URL(string: url)!)
                }
            }else{
                dPrint(item: "更新的url为空")
            }
        }))
    
        self.myInfoView.leftTitleLabel.text = "我的信息"
        self.inviteFriendView.leftTitleLabel.text = "邀请好友注册"
        self.inviteFriendView.addBorderLayer(color: UIColor.colorWithHexString(hex: BMBorderColor), size: BMBorderSize, boderType: BorderType.bottom)
        self.feedBackView.leftTitleLabel.text = "意见反馈"
        self.feedBackView.infoCellClickClosure = {  //点击回调
            () -> Void in
            self.hidesBottomBarWhenPushed = true
            let vc:BMFeedBackViewController = BMFeedBackViewController(nibName: "BMFeedBackViewController", bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
            self.hidesBottomBarWhenPushed = false
        }
        self.checkUpdateView.leftTitleLabel.text = "检查更新"
        self.checkUpdateView.rightTitleLabel.text = "当前版本: \(VERSION)"
        self.checkUpdateView.imageView.isHidden = true
        self.checkUpdateView.infoCellClickClosure = {  //点击回调
            () -> Void in
            
            ////////////查询版本更新////////////
            let url = "\(BMHOST)/appgen/updateVersion"
            let params:Dictionary<String,Any> = ["osType":1,"duserCode":BMDUSERCODE,"appVersion":VERSION]
            NetworkRequest.sharedInstance.getRequest(urlString: url , params: params , success: { value in
                
                let releaseVersion:String? = value["releaseVersion"].string
                let canUpgrade:Bool? = value["canUpgrade"].bool
                self.url = value["url"].string
                
                if let releaseVersion = releaseVersion, let canUpgrade = canUpgrade{
                    
                    if releaseVersion > VERSION && canUpgrade == true {
                        self.present(self.alertController, animated: true, completion: nil)
                    }
                    
                }else{
                    
                    HUD.flash(.label("已是最新版本"), delay: 1.0)
                }
                
                
            }) { error in
                
            }

            
        }
    }
    
    
    //优惠券点击事件
    @IBAction func couponClick(_ sender: UITapGestureRecognizer) {
        let vc:BMCouponListView = BMCouponListView(sourceFrom: CouponListFrom.me)
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //卡包点击事件
    @IBAction func cardsClick(_ sender: UITapGestureRecognizer) {
        let vc:BMCardsViewController = BMCardsViewController(style: .grouped)
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //快速登录点击事件
    @IBAction func loginClick(_ sender: UIButton) {
        
        let loginVC:BMLoginViewController = BMLoginViewController(nibName: "BMLoginViewController", bundle: nil)
        self.navigationController?.present(loginVC, animated: true, completion: nil)
    }
    
    
    //退出登录点击事件
    @IBAction func exitClick(_ sender: UIButton) {
    }


}
