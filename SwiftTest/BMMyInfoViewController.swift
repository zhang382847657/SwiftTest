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
    
    var contentView:UIView! //内容视图
    var baseInfoView:BMMyBaseInfoView! //基本信息视图
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "我的信息"
        
        
        ///////////内容视图//////////////
        self.contentView = UIView(frame: CGRect.zero)
        self.scrollView.addSubview(self.contentView)
        self.contentView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.scrollView)
            make.width.equalTo(self.scrollView.snp.width)
            make.height.greaterThanOrEqualTo(0)
        }
        
        
        ///////////基本信息视图//////////////
        self.baseInfoView = UIView.loadViewFromNib(nibName: "BMMyBaseInfoView") as! BMMyBaseInfoView
        self.contentView.addSubview(self.baseInfoView)
        self.baseInfoView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.contentView)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //顶部按钮点击事件
    @IBAction func infoTypeClick(_ sender: UIButton) {
        
        for view in self.topView.subviews{
            if view is UIButton {
                let btn:UIButton = view as! UIButton
                
                if btn == sender{
                    btn.isSelected = true
                }else{
                    btn.isSelected = false
                }
            }
        }
        
    }
    

}
