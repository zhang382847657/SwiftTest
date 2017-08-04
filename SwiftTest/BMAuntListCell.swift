//
//  BMAuntListCell.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/8/4.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit
import SwiftyJSON

class BMAuntListCell: UITableViewCell {

    @IBOutlet weak var centerView: UIView!
    @IBOutlet weak var headerImageView: UIImageView!  //阿姨头像
    @IBOutlet weak var nameLabel: UILabel!  //阿姨姓名
    @IBOutlet weak var ageLabel: UILabel!  //阿姨年龄
    @IBOutlet weak var addressLabel: UILabel!  //阿姨地址
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.centerView.layer.cornerRadius = 3
        self.headerImageView.layer.masksToBounds = true
        self.headerImageView.layer.cornerRadius = self.headerImageView.bounds.size.height/2.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func updateWithAunt(aunt:JSON){
        
        let photoUrl:String? = aunt["photoUrl"].string
        let name:String? = aunt["name"].string
        let sex:Int? = aunt["sex"].int
        let age:Int? = aunt["age"].int
        let district:String? = aunt["district"].string
        let address:String? = aunt["address"].string
        let houseNumber:String? = aunt["houseNumber"].string
        
        var finalAddress:String = "" //最终显示的地址
        
        
        if let photoUrl = photoUrl , photoUrl != ""{
            self.headerImageView.af_setImage(withURL: URL(string: photoUrl)!, placeholderImage: UIImage(named: "pic_load")!)
            
        }else{
            self.headerImageView.image = UIImage(named: "aunt_default")
        }
        
        if let name = name , name.trimmingCharacters(in: .whitespaces) != ""{
            self.nameLabel.text = name
        }else{
            self.nameLabel.text = "暂无姓名"
        }
        
        if let sex = sex{
            let borderColor =  sex == 0 ? "#ed297a" : BMThemeColor
            self.headerImageView.layer.borderWidth = 3
            self.headerImageView.layer.borderColor = UIColor.colorWithHexString(hex: borderColor).cgColor
        }
        
        if let age = age , age != 0{
            self.ageLabel.text = "\(age)岁"
        }else{
            self.ageLabel.text = "--岁"
        }
        
        if let district = district{
            finalAddress = finalAddress + district
        }
        
        if let address = address {
            finalAddress = finalAddress + " \(address)"
        }
        
        if let houseNumber = houseNumber {
            finalAddress = finalAddress + " \(houseNumber)"
        }
        
        if finalAddress.trimmingCharacters(in: .whitespaces) == "" {
            self.addressLabel.text = "暂无地址"
        }else{
            self.addressLabel.text = finalAddress
        }
        
    }
    
}
