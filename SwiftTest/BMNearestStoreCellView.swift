//
//  BMNearestStoreCellView.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/6/26.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit
import SwiftyJSON
import AlamofireImage

class BMNearestStoreCellView: UIView {

    @IBOutlet weak var imageView: UIImageView! //门店图片
    @IBOutlet weak var storeNameLabel: UILabel! //门店名称
    @IBOutlet weak var storeSolganLabel: UILabel! //门店标语
    @IBOutlet weak var distanceLabel: UILabel!  //门店距离
    @IBOutlet weak var phoneBtn: UIButton!  //门店联系电话
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.distanceLabel.layer.borderWidth = 1.0
        self.distanceLabel.layer.borderColor = UIColor.colorWithHexString(hex: "FFB912").cgColor
    }
    
    
    /**
     * 更新内容
     */
    func updateUIWithStore(store:JSON) {
        
        
        let logoUrl:String? = store["logoUrl"].string
        let shopName:String? = store["shopName"].string
        let slogan:String? = store["slogan"].string
        let mobilePhone:String? = store["mobilePhone"].string
        let distance:Float? = store["distance"].float
        
        if let logoUrl = logoUrl , logoUrl != ""{
            self.imageView.af_setImage(withURL: URL(string: logoUrl)!, placeholderImage: UIImage(named: "shop_default")!)
        }
        
        if let shopName = shopName{
            storeNameLabel.text = shopName
        }else{
            storeNameLabel.text = "暂无门店名"
        }
        
        if let slogan = slogan{
            storeSolganLabel.text = slogan
        }else{
            storeSolganLabel.text = "全球领先的家庭服务提供商"
        }
        
        if let mobilePhone = mobilePhone{
            phoneBtn.titleLabel?.text = mobilePhone
        }else{
            phoneBtn.titleLabel?.text = "暂无联系方式"
        }
        
        if let distance = distance{
            distanceLabel.text = " \(lroundf(distance/10)/100)km ";
        }else{
            distanceLabel.text = " 0m "
        }
    }

    
    /**
     *  电话号点击事件
     */
    @IBAction func phoneClick(_ sender: UIButton) {
        
        if sender.titleLabel?.text != "暂无联系方式" {
            
            let phoneNum:String = (sender.titleLabel?.text!)!
            let url = URL(string: "tel://\(phoneNum)")
            //根据iOS系统版本，分别处理
            if #available(iOS 10, *) {
                UIApplication.shared.open(url!, options: [:],
                                          completionHandler: {
                                            (success) in
                })
            } else {
                UIApplication.shared.openURL(url!)
            }
        }
        
        
        
    }
}
