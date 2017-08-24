//
//  BMAfterSaleAuntView.swift
//  SwiftTest
//  售后单——阿姨信息
//  Created by 张琳 on 2017/8/24.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit
import SwiftyJSON

class BMAfterSaleAuntView: UIView {

    @IBOutlet weak var imageView: UIImageView!  //阿姨头像
    @IBOutlet weak var nameLabel: UILabel!  //阿姨姓名
    @IBOutlet weak var ageLabel: UILabel!  //阿姨年龄
    @IBOutlet weak var addressLabel: UILabel!  //阿姨地址
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imageView.layer.masksToBounds = true
        self.imageView.layer.cornerRadius = self.imageView.bounds.size.width/2.0
        self.imageView.layer.borderColor = UIColor.colorWithHexString(hex: BMThemeColor).cgColor
        self.imageView.layer.borderWidth = 2
    }
    
    
    func updateWithAunts(aunts:Array<JSON>){
        
//        aunts.sorted { (v1, v2) -> Bool in //根据添加时间进行排序，让最新的阿姨在最上面
//            return v1["addTime"].intValue > v2["addTime"].intValue
//        }
//        
//        aunts.sorted { (v1, v2) -> Bool in //根据添加时间进行排序，让最新的阿姨在最上面
//            return v1["addTime"].intValue > v2["addTime"].intValue
//        }
        
        let aunt:JSON = aunts.first!
        let auntName:String? = aunt["name"].string
        let age:Int? = aunt["age"].int
        let photoUrl:String? = aunt["photoUrl"].string
        let province:String? = aunt["city"].string
        let city:String? = aunt["district"].string
        
        if let age = age{
            self.ageLabel.text = "\(age)岁"
        }else{
            self.ageLabel.text = "0岁"
        }
        
        if let auntName = auntName{
            self.nameLabel.text = auntName
        }else{
            self.nameLabel.text = "暂无阿姨名字"
        }
        
        if let photoUrl = photoUrl, photoUrl.trimmingCharacters(in: .whitespaces) != ""{
            self.imageView.af_setImage(withURL: URL(string: photoUrl)!, placeholderImage: UIImage(named: "aunt_default"))
        }else{
            
            self.imageView.image = UIImage(named: "aunt_default")
        }
        
        var address = "--"
        if let province = province, province.trimmingCharacters(in: .whitespaces) != ""{
            address = province
        }
        if let city = city, city.trimmingCharacters(in: .whitespaces) != ""{
            address += city
        }
        self.addressLabel.text = address
        
        
        
    }
    

}
