//
//  BMAuntDetailHeaderView.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/8/4.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit
import SwiftyJSON

class BMAuntDetailHeaderView: UIView {

    @IBOutlet weak var imageBackgroundView: UIView!  //阿姨头像背景图
    @IBOutlet weak var headImageView: UIImageView!  //阿姨头像
    @IBOutlet weak var sexImageView: UIImageView!  //阿姨性别
    @IBOutlet weak var nameLabel: UILabel!  //阿姨姓名
    @IBOutlet weak var auntCerBtn: UIButton!  //阿姨证书按钮
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.imageBackgroundView.layer.cornerRadius = self.imageBackgroundView.bounds.size.height/2.0
        
    }
    
    
    func updateWithAunt(aunt:JSON){
        
        let photoUrl:String? = aunt["photoUrl"].string
        let name:String? = aunt["name"].string
        let sex:Int? = aunt["sex"].int
        
        if let photoUrl = photoUrl{
            
        }else{
            
        }
        
        
        if let name = name{
            self.nameLabel.text = name
        }else{
            self.nameLabel.text = "暂无名字"
        }
        
        if let sex = sex{
            self.sexImageView.image = UIImage(named:"")
        }else{
            self.sexImageView.image = UIImage(named: "")
        }
    }
   
    
    //阿姨证书点击事件
    @IBAction func auntCerClick(_ sender: UIButton) {
    }

}
