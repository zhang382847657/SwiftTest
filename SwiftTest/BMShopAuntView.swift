//
//  BMShopAuntView.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/8/2.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit
import SwiftyJSON

class BMShopAuntView: UIView {
    
    @IBOutlet weak var auntImageBtn: UIButton! //阿姨头像按钮
    @IBOutlet weak var nameLabel: UILabel!  //阿姨名称
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.bounds.size.width/2.0
    }
    
    
    func updateWithAunt(aunt:JSON){
        
        let photoUrl:String? = aunt["photoUrl"].string
        let name:String? = aunt["name"].string
        
        if let photoUrl = photoUrl , photoUrl != "" {
            
            self.auntImageBtn.af_setBackgroundImage(for: .normal, url: URL(string: photoUrl)!, placeholderImage: UIImage(named: "pic_load")!)
            
        }else{
            self.auntImageBtn.setBackgroundImage(UIImage(named: "aunt_default"), for: .normal)
        }
        
        if let name = name{
            self.nameLabel.text = name
        }else{
            self.nameLabel.text = "暂无名字"
        }
        
    
    }

}
