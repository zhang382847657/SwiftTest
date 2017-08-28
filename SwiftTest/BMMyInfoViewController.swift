//
//  BMMyInfoViewController.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/8/28.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit

class BMMyInfoViewController: UIViewController {

    @IBOutlet weak var baseInfoBtn: UIButton!  //基本信息按钮
    @IBOutlet weak var otherInfoBtn: UIButton!  //其他信息按钮
    @IBOutlet weak var addressBtn: UIButton!  //常用地址按钮
    @IBOutlet weak var scrollView: UIScrollView!  //滚动视图
    
    var contentView:UIView! //内容视图
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}
