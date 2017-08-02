//
//  BMShopAuntView.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/8/2.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit

class BMShopAuntView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.bounds.size.width/2.0
    }

}
