//
//  BMAuntCerCell.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/8/8.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit
import SwiftyJSON

class BMAuntCerCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!  //证书背景图
    @IBOutlet weak var nameLabel: UILabel!  //证书名字
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func updateWithCer(cer:JSON){
        let certName:String? = cer["certName"].string
        
        if let certName = certName{
            self.nameLabel.text = certName
        }else{
            self.nameLabel.text = "暂无证书名字"
        }
        
        let dic:Dictionary<String,String> = self.getImageAndFontColorWithCerName(name: certName)
        self.imageView.image = UIImage(named: dic["image"]!)
        self.nameLabel.textColor = UIColor.colorWithHexString(hex: dic["color"]!)
    }
    
    
    private func getImageAndFontColorWithCerName(name:String?) -> Dictionary<String,String>{
        if let name = name{
            
            if name=="健康证"||name=="营养师证"||name=="厨师证"||name=="面点师证" {
                return ["image":"zhengshu_5","color":"#70BE12"]
            }else if name=="母婴护理证"||name=="育婴师证"||name=="早教证"||name=="催乳师证" {
                return ["image":"zhengshu_1","color":"#ed297a"]
            }else if name=="美国签证"||name=="英国签证"||name=="意大利签证"||name=="澳大利亚签证"||name=="加拿大签证"||name=="港澳通行证" {
                return ["image":"zhengshu_2","color":"#00b4ff"]
            }else if name=="家政服务员证"||name=="护理工上岗证"||name=="养老护理证" {
                return ["image":"zhengshu_3","color":"#ffb912"]
            }else if name=="驾驶证"||name=="管家证"||name=="其他证书" {
                return ["image":"zhengshu_4","color":"#ffb912"]
            }else{
                return ["image":"zhengshu_4","color":"#ffb912"]
            }
            
        }else{
            return ["image":"zhengshu_4","color":"#ffb912"]
        }
    }

}
