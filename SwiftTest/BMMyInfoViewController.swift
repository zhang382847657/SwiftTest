//
//  BMMyInfoViewController.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/8/28.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit

class BMMyInfoViewController: UIViewController {
    

    @IBOutlet weak var topView: UIView!  //顶部视图
    @IBOutlet weak var baseInfoBtn: UIButton!  //基本信息按钮
    @IBOutlet weak var otherInfoBtn: UIButton!  //其他信息按钮
    @IBOutlet weak var addressBtn: UIButton!  //常用地址按钮
    @IBOutlet weak var scrollView: UIScrollView!  //滚动视图
    @IBOutlet weak var commonAddressInfoView: BMCommonAddressInfoView! //常用地址视图
    
    var baseInfoView:BMMyBaseInfoView! //基本信息视图
    var otherInfoView:BMMyOtherInfoView! //其他信息视图
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "我的信息"
        

        
        ///////////基本信息视图//////////////
        self.baseInfoView = UIView.loadViewFromNib(nibName: "BMMyBaseInfoView") as! BMMyBaseInfoView
        self.baseInfoView.isHidden = false
        self.scrollView.addSubview(self.baseInfoView)
        self.baseInfoView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self.scrollView)
            make.width.equalTo(self.scrollView.snp.width)
        }
        
        //////////其他信息基本视图////////////
        self.otherInfoView = UIView.loadViewFromNib(nibName: "BMMyOtherInfoView") as! BMMyOtherInfoView
        self.otherInfoView.isHidden = true
        self.scrollView.addSubview(self.otherInfoView)
        self.otherInfoView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self.scrollView)
            make.width.equalTo(self.scrollView.snp.width)
        }
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //顶部按钮点击事件
    @IBAction func infoTypeClick(_ sender: UIButton) {
        
        for view in self.topView.subviews{  //做一个单选的效果
            if view is UIButton {
                let btn:UIButton = view as! UIButton
                if btn == sender{
                    btn.isSelected = true
                }else{
                    btn.isSelected = false
                }
            }
        }
        
        
        switch sender {  //根据按钮的切换显示不同对应的内容视图
        case self.baseInfoBtn:
            self.baseInfoView.isHidden = false
            self.otherInfoView.isHidden = true
            self.commonAddressInfoView.isHidden = true
        case self.otherInfoBtn:
            self.baseInfoView.isHidden = true
            self.otherInfoView.isHidden = false
            self.commonAddressInfoView.isHidden = true
        case self.addressBtn:
            self.baseInfoView.isHidden = true
            self.otherInfoView.isHidden = true
            self.commonAddressInfoView.isHidden = false
        default:
            break
        }
        
    }
    

}
