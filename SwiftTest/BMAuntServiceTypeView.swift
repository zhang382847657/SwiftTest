//
//  BMAuntServiceTypeView.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/8/4.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit
import SwiftyJSON

class BMAuntServiceTypeView: UIView {

    @IBOutlet weak var serviceImageView: UIImageView!
    @IBOutlet weak var serviceTypeLabel: UILabel!
    @IBOutlet weak var levelBtn: UIButton!
    
    
    
    func updateWithServiceType(serviceType:JSON,levelName:JSON){
        let text:String? = serviceType["text"].string
        let levelName:String? = levelName.string
        let itemId:Int? = serviceType["itemId"].int
        
        
        if let itemId = itemId{
            self.serviceImageView.image = UIImage(named: Config.productByItemId(itemId: itemId)["icon"]!)
        }else{
            self.serviceImageView.image = UIImage(named: "tybj")
        }
        
        if let text = text{
            self.serviceTypeLabel.text = text
        
        }else{
            self.serviceTypeLabel.text = "暂无服务类型"
        }
        
        if let levelName = levelName{
            self.levelBtn.setTitle(levelName, for: .normal)
        }else{
            self.levelBtn.setTitle("暂无级别", for: .normal)
        }
    
    }

}
