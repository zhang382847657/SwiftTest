//
//  BMShopHeaderView.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/8/1.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit

class BMShopHeaderView: UIView {

    @IBOutlet weak var imageView: UIImageView!  //家政公司头像
    @IBOutlet weak var companyNameLabel: UILabel! //家政公司名称
    @IBOutlet weak var companySolganLabel: UILabel! //家政公司slogan
    @IBOutlet weak var headerImageBackgroundView: UIView!  //家政公司头像背景视图
    @IBOutlet weak var shopBtn: UIButton! //查看门店按钮
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.shopBtn.layer.cornerRadius = self.shopBtn.bounds.size.height/2.0
        self.headerImageBackgroundView.layer.masksToBounds = true
        self.headerImageBackgroundView.layer.cornerRadius = self.headerImageBackgroundView.bounds.size.height/2.0
    }

    
    //查看门店点击事件
    @IBAction func shopClick(_ sender: UIButton) {
    }
}
