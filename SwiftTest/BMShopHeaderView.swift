//
//  BMShopHeaderView.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/8/1.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit
import SwiftyJSON

//查看所有门店闭包
typealias LookAllShopClickClosure = () -> Void

class BMShopHeaderView: UIView {

    @IBOutlet weak var imageView: UIImageView!  //家政公司头像
    @IBOutlet weak var companyNameLabel: UILabel! //家政公司名称
    @IBOutlet weak var companySolganLabel: UILabel! //家政公司slogan
    @IBOutlet weak var headerImageBackgroundView: UIView!  //家政公司头像背景视图
    @IBOutlet weak var shopBtn: UIButton! //查看门店按钮
    
    var lookAllShopClickClosure: LookAllShopClickClosure? //查看所有阿姨点击回调
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.shopBtn.corner(byRoundingCorners: [.bottomLeft,.topLeft], radii: self.shopBtn.bounds.size.height/2)
        self.headerImageBackgroundView.layer.masksToBounds = true
        self.headerImageBackgroundView.layer.cornerRadius = self.headerImageBackgroundView.bounds.size.height/2.0
    }
    
    
    func updateWithCompany(company:JSON){
        
        let icon: String? = company["logoUrl"].string
        let companyName: String? = company["company"].string
        let slogan: String? = company["slogan"].string
        
        if let icon = icon , icon != ""{
            self.imageView.af_setImage(withURL: URL(string: icon)!, placeholderImage: UIImage(named: "pic_load")!)
            
        }else{
            self.imageView.image = UIImage(named: "shop_default")
        }
        
        if let companyName = companyName{
            self.companyNameLabel.text = companyName
        }else{
            self.companyNameLabel.text = "暂无公司名称"
        }
        
        if let slogan = slogan{
            self.companySolganLabel.text = slogan
        }else{
            self.companySolganLabel.text = "暂无公司标语"
        }
    }

    
    //查看门店点击事件
    @IBAction func shopClick(_ sender: UIButton) {
        
        if let lookAllShopClickClosure = self.lookAllShopClickClosure{
            lookAllShopClickClosure()
        }
        
    }
}
