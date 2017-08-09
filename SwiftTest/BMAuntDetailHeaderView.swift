//
//  BMAuntDetailHeaderView.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/8/4.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit
import SwiftyJSON

//阿姨证书按钮闭包
typealias AuntCerClickClosureType = () -> Void

class BMAuntDetailHeaderView: UIView {

    @IBOutlet weak var imageBackgroundView: UIView!  //阿姨头像背景图
    @IBOutlet weak var headImageView: UIImageView!  //阿姨头像
    @IBOutlet weak var sexImageView: UIImageView!  //阿姨性别
    @IBOutlet weak var nameLabel: UILabel!  //阿姨姓名
    @IBOutlet weak var auntCerBtn: UIButton!  //阿姨证书按钮
    var auntCerClickClosureType: AuntCerClickClosureType? //阿姨证书按钮点击回调
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.headImageView.layer.masksToBounds = true
        self.headImageView.layer.cornerRadius = self.headImageView.bounds.size.height/2.0
        
        self.auntCerBtn.corner(byRoundingCorners: [.bottomLeft,.topLeft], radii: self.auntCerBtn.bounds.size.height/2)
    }
    
    
    func updateWithAunt(aunt:JSON){
        
        let photoUrl:String? = aunt["photoUrl"].string
        let name:String? = aunt["name"].string
        let sex:Int? = aunt["sex"].int
        let cers:Array? = aunt["auntCertList"].array
        
        if let photoUrl = photoUrl , photoUrl != ""{
            self.headImageView.af_setImage(withURL: URL(string: photoUrl)!, placeholderImage: UIImage(named: "pic_load")!)
        }else{
            self.headImageView.image = UIImage(named: "aunt_default")
        }
        
        
        if let name = name{
            self.nameLabel.text = name
        }else{
            self.nameLabel.text = "暂无名字"
        }
        
        if let sex = sex{
            self.sexImageView.image = sex == 0 ? UIImage(named:"female") : UIImage(named:"male")
        }else{
            self.sexImageView.image = nil
        }
        
        if let _ = cers{
            self.auntCerBtn.isHidden = false
        }else{
            self.auntCerBtn.isHidden = true
        }
    }
   
    
    //阿姨证书点击事件
    @IBAction func auntCerClick(_ sender: UIButton) {
        if let auntCerClickClosureType = self.auntCerClickClosureType{
            auntCerClickClosureType()
        }
    }

}
