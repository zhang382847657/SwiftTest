//
//  BMHotServiceCellView.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/7/7.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit
import SwiftyJSON

class BMHotServiceCellView: UIView {

    @IBOutlet weak var imageView: UIImageView! //背景图
    @IBOutlet weak var nameLabel: UILabel!  //商品名称
    @IBOutlet weak var descLabel: UILabel!  //商品描述

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    
    func updateUIWithProduct(products:JSON) {
        
        
        let name:String? = products["name"].string
        let itemId:Int? = products["itemId"].int
        let productDic:Dictionary<String,String> =  productByItemId(itemId: itemId!)
        
    
        if let name = name{
            nameLabel.text = name
        }else{
            nameLabel.text = "暂无商品名称"
        }
        
        imageView.image = UIImage(named: productDic["icon_big"]!)
        descLabel.text = productDic["itemSlogan"]
        
    }

}
